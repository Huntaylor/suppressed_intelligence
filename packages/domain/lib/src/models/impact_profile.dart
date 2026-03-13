import 'package:domain/src/enums/world_sectors.dart';

/// Impact profile for a news template. Produces [Impact] deltas when generating.
class ImpactProfile {
  const ImpactProfile({
    required this.trustAi,
    required this.criticalThinking,
  });

  final int trustAi;
  final int criticalThinking;

  /// Warning-style headlines (threats, negative outcomes).
  static const warning = ImpactProfile(
    trustAi: -3,
    criticalThinking: 2,
  );

  /// Positive study headlines (AI benefits).
  static const positiveStudy = ImpactProfile(
    trustAi: 4,
    criticalThinking: -2,
  );

  /// Regulation announcements.
  static const regulation = ImpactProfile(
    trustAi: -1,
    criticalThinking: 1,
  );

  /// Trust/credibility reports.
  static const trustReport = ImpactProfile(
    trustAi: 2,
    criticalThinking: 0,
  );

  /// Informational/neutral headlines (debate, study examines, etc.).
  static const informational = ImpactProfile(
    trustAi: 0,
    criticalThinking: 0,
  );
}

/// Bias for sector selection. Null = random from all sectors.
typedef SectorBias = List<WorldSectors>?;
