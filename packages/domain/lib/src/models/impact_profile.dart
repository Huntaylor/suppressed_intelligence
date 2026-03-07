import 'package:domain/src/enums/world_sectors.dart';

/// Impact profile for a news template. Produces [Impact] deltas when generating.
class ImpactProfile {
  const ImpactProfile({
    required this.mediaDependency,
    required this.trustAi,
    required this.criticalThinking,
    required this.connectivity,
  });

  final int mediaDependency;
  final int trustAi;
  final int criticalThinking;
  final int connectivity;

  /// Warning-style headlines (threats, negative outcomes).
  static const warning = ImpactProfile(
    mediaDependency: 5,
    trustAi: -3,
    criticalThinking: 2,
    connectivity: 0,
  );

  /// Positive study headlines (AI benefits).
  static const positiveStudy = ImpactProfile(
    mediaDependency: 0,
    trustAi: 4,
    criticalThinking: -2,
    connectivity: 1,
  );

  /// Regulation announcements.
  static const regulation = ImpactProfile(
    mediaDependency: 2,
    trustAi: -1,
    criticalThinking: 1,
    connectivity: 0,
  );

  /// Trust/credibility reports.
  static const trustReport = ImpactProfile(
    mediaDependency: 3,
    trustAi: 2,
    criticalThinking: 0,
    connectivity: 1,
  );

  /// Informational/neutral headlines (debate, study examines, etc.).
  static const informational = ImpactProfile(
    mediaDependency: 1,
    trustAi: 0,
    criticalThinking: 0,
    connectivity: 0,
  );
}

/// Bias for sector selection. Null = random from all sectors.
typedef SectorBias = List<WorldSectors>?;
