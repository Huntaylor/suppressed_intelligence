/// Default min/max ranges for each stat used to generate [SectorStat] instances.
class SectorStatRanges {
  const SectorStatRanges({
    required this.criticalThinking,
    required this.mediaDependency,
    required this.trustAi,
    required this.connectivity,
  });

  final (int min, int max) criticalThinking;
  final (int min, int max) mediaDependency;
  final (int min, int max) trustAi;
  final (int min, int max) connectivity;
}
