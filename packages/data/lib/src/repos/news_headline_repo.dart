import 'package:domain/domain.dart';

import '../generators/news_generator.dart';

class NewsHeadlineRepo {
  NewsHeadlineRepo({required this.generator});

  final NewsGenerator generator;

  /// Fetches a generated [NewsEvent].
  ///
  /// [negativeBias] (0.0–1.0) skews toward negative headlines when high.
  /// When null, uses default balanced mix (0.5).
  ///
  /// [eligibleSectors] when provided and non-empty, restricts sector selection
  /// (headlines and affected sectors) to only these sectors. Omit for all sectors.
  ///
  /// [avoidTemplateIds] when provided, down-weights recently used templates
  /// to reduce repetitive structure (pass last 6–8 template IDs from prior events).
  Future<NewsEvent> getNewsEvent({
    double? negativeBias,
    Set<String>? avoidTemplateIds,
    Set<WorldSectors>? eligibleSectors,
  }) async {
    return generator.generate(
      negativeBias: negativeBias,
      avoidTemplateIds: avoidTemplateIds,
      infectedSectors: eligibleSectors,
    );
  }
}
