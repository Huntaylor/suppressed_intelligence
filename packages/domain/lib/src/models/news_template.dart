import 'package:domain/src/enums/news_slot_type.dart';
import 'package:domain/src/enums/news_tone.dart';
import 'package:domain/src/models/impact_profile.dart';

/// A grammatical sentence structure for news generation.
class NewsTemplate {
  const NewsTemplate({
    required this.id,
    required this.template,
    required this.slotTypes,
    required this.impactProfile,
    required this.tone,
    this.sectorBias,
    this.sectorSuffix,
  });

  final String id;
  final String template;
  final List<NewsSlotType> slotTypes;
  final ImpactProfile impactProfile;
  final NewsTone tone;
  final SectorBias sectorBias;

  /// Optional suffix appended to the headline, e.g. " in [sector]" or
  /// " across [sector]". The [sector] placeholder is filled from sector vocabulary.
  /// Allows any template to include a sector without a dedicated slot.
  final String? sectorSuffix;
}
