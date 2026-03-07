import 'package:domain/domain.dart';

class NewsHeadlineRepo {
  const NewsHeadlineRepo();

  Future<NewsEvent> getNewsEvent() async {
    return NewsEvent(
      headline: 'The sky is falling',
      impact: const Impact(
        mediaDependency: 10,
        trustAi: 10,
        criticalThinking: 10,
        connectivity: 10,
      ),
      affectedSectors: [WorldSectors.na],
    );
  }
}
