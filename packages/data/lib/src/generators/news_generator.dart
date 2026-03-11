import 'dart:math';

import 'package:domain/domain.dart';
import 'package:get_it_injector/get_it_injector.dart';

import '../data/news_templates.dart';
import '../data/news_vocabulary.dart';

@factory
/// Generates [NewsEvent] headlines from grammatical templates and vocabulary.
class NewsGenerator {
  NewsGenerator({required Random random}) : _random = random;

  final Random _random;

  /// Chance (0.0–1.0) that a sector-focused template produces sector-specific impact.
  static const double _sectorSpecificImpactChance = 0.3;

  /// Weighted distribution: 70% common (8–15), 25% strong (15–20), 5% rare (20–25).
  static int _pickPercent(Random random) {
    final r = random.nextDouble();
    if (r < 0.70) return 8 + random.nextInt(8); // 8–15
    if (r < 0.95) return 15 + random.nextInt(6); // 15–20
    return 20 + random.nextInt(6); // 20–25
  }

  /// Generates a new [NewsEvent] with a dynamic headline.
  ///
  /// [negativeBias] (0.0–1.0) skews template selection: higher values favor
  /// negative templates (warnings, regulations), lower values favor positive
  /// templates (studies). When null, defaults to 0.5 (balanced mix).
  ///
  /// [avoidHeadlines] when provided, retries if the generated headline matches
  /// (reduces duplicates in batches).
  ///
  /// [avoidTemplateIds] when provided, down-weights recently used templates so
  /// the same structure doesn't repeat too often (keeps news feeling fresh).
  NewsEvent generate({
    double? negativeBias,
    Set<String>? avoidHeadlines,
    Set<String>? avoidTemplateIds,
  }) {
    final bias = negativeBias?.clamp(0.0, 1.0) ?? 0.5;
    const maxRetries = 25;
    for (var attempt = 0; attempt < maxRetries; attempt++) {
      final event = _generateOne(bias, avoidTemplateIds);
      if (avoidHeadlines == null || !avoidHeadlines.contains(event.headline)) {
        return event;
      }
    }
    return _generateOne(bias, avoidTemplateIds);
  }

  NewsEvent _generateOne(double bias, [Set<String>? avoidTemplateIds]) {
    final template = _pickTemplate(bias, avoidTemplateIds);
    final slotValues = <NewsSlotType, String>{};

    for (final slotType in template.slotTypes) {
      final value = _pickSlotValue(slotType, template, slotValues);
      if (value != null) {
        slotValues[slotType] = value;
      }
    }

    var headline = template.template;

    for (final slotType in template.slotTypes) {
      final value = slotValues[slotType];
      if (value == null) continue;

      final placeholder = slotType.placeholder;
      final index = headline.indexOf(placeholder);
      if (index == -1) continue;

      final isSlotSentenceStart =
          index == 0 || headline.substring(0, index).trimRight().endsWith('.');
      final formatted = _formatSlotValue(value, slotType, isSlotSentenceStart);
      headline = headline.replaceFirst(placeholder, formatted);
    }

    // Append optional sector suffix (e.g. " in [sector]." → " in North America.").
    if (template.sectorSuffix != null && template.sectorSuffix!.isNotEmpty) {
      final sector = _pickWorldSectorForHeadline(template);
      final suffix = template.sectorSuffix!.replaceAll(
        NewsSlotType.sector.placeholder,
        sector.displayName,
      );
      headline = headline.trim();
      if (headline.endsWith('.')) {
        headline = headline.substring(0, headline.length - 1);
      }
      headline = headline + suffix;
    }

    final impact = Impact(
      mediaDependency: template.impactProfile.mediaDependency,
      trustAi: template.impactProfile.trustAi,
      criticalThinking: template.impactProfile.criticalThinking,
      connectivity: template.impactProfile.connectivity,
    );

    final affectedSectors = _pickAffectedSectors(template);

    // Occasionally apply impact only to affected sectors (sector-specific events).
    final hasSectorInHeadline =
        template.slotTypes.contains(NewsSlotType.sector) ||
        (template.sectorSuffix != null && template.sectorSuffix!.isNotEmpty);
    final impactsSectorsOnly =
        hasSectorInHeadline &&
        _random.nextDouble() < _sectorSpecificImpactChance;

    return NewsEvent(
      headline: headline.trim(),
      impact: impact,
      affectedSectors: affectedSectors,
      templateId: template.id,
      impactsSectorsOnly: impactsSectorsOnly,
    );
  }

  NewsTemplate _pickTemplate(
    double negativeBias, [
    Set<String>? avoidTemplateIds,
  ]) {
    final weighted = newsTemplates.map((t) {
      var weight = switch (t.tone) {
        NewsTone.negative => negativeBias,
        NewsTone.positive => 1.0 - negativeBias,
        // Exclude neutral when bias is 0 or 1 — positive/negative pools stay pure
        NewsTone.neutral => (negativeBias > 0 && negativeBias < 1) ? 0.5 : 0.0,
      };
      // Down-weight recently used templates to avoid repetitive structure
      if (avoidTemplateIds != null &&
          avoidTemplateIds.isNotEmpty &&
          avoidTemplateIds.contains(t.id)) {
        weight *= 0.2;
      }
      return WeightedEntry(t, weight: weight);
    }).toList();
    return pickWeighted(weighted, _random);
  }

  String? _pickSlotValue(
    NewsSlotType slotType,
    NewsTemplate newsTemplate,
    Map<NewsSlotType, String> existingValues,
  ) {
    switch (slotType) {
      case NewsSlotType.percent:
        final percent = _pickPercent(_random);
        final formatEntry = pickWeighted(percentFormatVocabulary, _random);
        return formatEntry.replaceAll('{n}', percent.toString());
      case NewsSlotType.percentFormat:
        return null;
      case NewsSlotType.authority:
        return pickWeighted(authorityVocabulary, _random);
      case NewsSlotType.threat:
        return pickWeighted(threatVocabulary, _random);
      case NewsSlotType.negativeOutcome:
        return pickWeighted(negativeOutcomeVocabulary, _random);
      case NewsSlotType.aiRecommendation:
        return pickWeighted(aiRecommendationVocabulary, _random);
      case NewsSlotType.sector:
        return _pickWorldSectorForHeadline(newsTemplate).displayName;
      case NewsSlotType.aiSystem:
        return newsTemplate.tone == NewsTone.positive
            ? pickWeighted(aiSystemPositiveVocabulary, _random)
            : pickWeighted(aiSystemVocabulary, _random);
      case NewsSlotType.studySource:
        return pickWeighted(studySourceVocabulary, _random);
      case NewsSlotType.studySourceAttribution:
        return pickWeighted(studySourceAttributionVocabulary, _random);
      case NewsSlotType.studySourceFinds:
        return pickWeighted(studySourceFindsVocabulary, _random);
      case NewsSlotType.behavior:
        return _pickBehavior(existingValues);
      case NewsSlotType.benefitVerb:
        return _pickBenefitVerb(existingValues);
      case NewsSlotType.outcome:
        return _pickOutcome(existingValues);
      case NewsSlotType.aiGuidance:
        return pickWeighted(aiGuidanceVocabulary, _random);
      case NewsSlotType.optionalReason:
        return pickWeighted(optionalReasonVocabulary, _random);
      case NewsSlotType.tonePrefix:
        return pickWeighted(tonePrefixVocabulary, _random);
    }
  }

  /// Avoid "stabilizes emotional stability" — exclude stabilizes when outcome
  /// is emotional stability, and vice versa.
  String _pickBenefitVerb(Map<NewsSlotType, String> existingValues) {
    final outcome = existingValues[NewsSlotType.outcome];
    final filtered = outcome == 'emotional stability'
        ? benefitVerbVocabulary.where((e) => e.value != 'stabilizes').toList()
        : benefitVerbVocabulary;
    return pickWeighted(filtered, _random);
  }

  /// Avoid "media consumption" + "decision confidence" — odd pairing.
  /// Prefer decision-making/daily planning for decision confidence.
  String _pickBehavior(Map<NewsSlotType, String> existingValues) {
    final outcome = existingValues[NewsSlotType.outcome];
    if (outcome == 'decision confidence') {
      final filtered = behaviorVocabulary
          .where(
            (e) =>
                e.value == 'decision-making' ||
                e.value == 'daily planning' ||
                e.value == 'financial decision-making' ||
                e.value == 'financial planning' ||
                e.value == 'personal scheduling',
          )
          .toList();
      if (filtered.isNotEmpty) {
        return pickWeighted(filtered, _random);
      }
    }
    return pickWeighted(behaviorVocabulary, _random);
  }

  String _pickOutcome(Map<NewsSlotType, String> existingValues) {
    final verb = existingValues[NewsSlotType.benefitVerb];
    var filtered = verb == 'stabilizes'
        ? outcomeVocabulary
              .where((e) => e.value != 'emotional stability')
              .toList()
        : outcomeVocabulary;
    // Avoid "media consumption" + "decision confidence" — odd pairing
    final behavior = existingValues[NewsSlotType.behavior];
    if (behavior == 'media consumption' || behavior == 'social interaction') {
      filtered = filtered
          .where((e) => e.value != 'decision confidence')
          .toList();
    }
    return pickWeighted(filtered, _random);
  }

  /// Known acronyms/proper nouns that should never be lowercased.
  static const _preserveCase = {'WHO', 'FDA', 'EU', 'AI'};

  String _formatSlotValue(
    String value,
    NewsSlotType slotType,
    bool isSentenceStart,
  ) {
    if (value.isEmpty) return value;
    // Authority slot: preserve WHO, FDA, EU etc.; otherwise capitalize at sentence start.
    if (slotType == NewsSlotType.authority) {
      final words = value.split(RegExp(r'\s+'));
      if (_preserveCase.any(
        (acronym) => words.any((w) => w.toUpperCase() == acronym),
      )) {
        return value;
      }
      if (isSentenceStart && value.isNotEmpty) {
        return value.substring(0, 1).toUpperCase() + value.substring(1);
      }
      return value;
    }
    // Preserve known acronyms only when they appear as whole words.
    final words = value.split(RegExp(r'\s+'));
    if (_preserveCase.any(
      (acronym) => words.any((w) => w.toUpperCase() == acronym),
    )) {
      return value;
    }
    if (isSentenceStart && value.isNotEmpty) {
      // Always capitalize first letter for sentence start.
      final result = value.substring(0, 1).toUpperCase() + value.substring(1);
      return result;
    }
    return value;
  }

  /// Picks a single [WorldSectors] for use in headline (sector slot or sectorSuffix).
  /// Uses [template.sectorBias] when present, otherwise random from all.
  WorldSectors _pickWorldSectorForHeadline(NewsTemplate template) {
    if (template.sectorBias != null && template.sectorBias!.isNotEmpty) {
      return template.sectorBias![_random.nextInt(template.sectorBias!.length)];
    }
    return WorldSectors.values[_random.nextInt(WorldSectors.values.length)];
  }

  List<WorldSectors> _pickAffectedSectors(NewsTemplate template) {
    if (template.sectorBias != null && template.sectorBias!.isNotEmpty) {
      final count =
          1 + _random.nextInt(template.sectorBias!.length.clamp(1, 3));
      final shuffled = List<WorldSectors>.from(template.sectorBias!)
        ..shuffle(_random);
      return shuffled.take(count).toList();
    }
    final all = WorldSectors.values;
    final count = 1 + _random.nextInt(3);
    final shuffled = List<WorldSectors>.from(all)..shuffle(_random);
    return shuffled.take(count).toList();
  }
}

/// Weighted random selection from vocabulary.
T pickWeighted<T>(List<WeightedEntry<T>> entries, Random random) {
  if (entries.isEmpty) throw StateError('Vocabulary list is empty');
  final total = entries.fold<double>(0, (s, e) => s + e.weight);
  var r = random.nextDouble() * total;
  for (final entry in entries) {
    r -= entry.weight;
    if (r <= 0) return entry.value;
  }
  return entries.last.value;
}
