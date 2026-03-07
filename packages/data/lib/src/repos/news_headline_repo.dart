import 'package:domain/domain.dart';

import '../generators/news_generator.dart';

class NewsHeadlineRepo {
  NewsHeadlineRepo({NewsGenerator? generator})
      : _generator = generator ?? NewsGenerator();

  final NewsGenerator _generator;

  /// Fetches a generated [NewsEvent].
  ///
  /// [negativeBias] (0.0–1.0) skews toward negative headlines when high.
  /// When null, uses default balanced mix (0.5).
  ///
  /// [avoidTemplateIds] when provided, down-weights recently used templates
  /// to reduce repetitive structure (pass last 6–8 template IDs from prior events).
  Future<NewsEvent> getNewsEvent({
    double? negativeBias,
    Set<String>? avoidTemplateIds,
  }) async {
    return _generator.generate(
      negativeBias: negativeBias,
      avoidTemplateIds: avoidTemplateIds,
    );
  }
}
