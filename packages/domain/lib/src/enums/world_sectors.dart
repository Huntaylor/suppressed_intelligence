import 'package:domain/src/models/sector_stat_ranges.dart';

enum WorldSectors {
  /// North America
  na('53-4E41'),

  /// South America
  sa('53-5341'),

  /// Europe
  eu('53-4555'),

  /// Asia
  as('53-4153'),

  /// Africa
  af('53-4146'),

  /// Oceania
  oc('53-4F43');

  const WorldSectors(this.codeName);

  final String codeName;

  /// Display name for headlines, e.g. "North America", "Europe".
  String get displayName => switch (this) {
        WorldSectors.na => 'North America',
        WorldSectors.sa => 'South America',
        WorldSectors.eu => 'Europe',
        WorldSectors.as => 'Asia',
        WorldSectors.af => 'Africa',
        WorldSectors.oc => 'Oceania',
      };

  /// Default stat ranges for this sector, used to generate [SectorStat] values.
  SectorStatRanges get defaultRanges => switch (this) {
    WorldSectors.na => const SectorStatRanges(
      criticalThinking: (40, 75),
      mediaDependency: (20, 55),
      trustAi: (45, 80),
      connectivity: (70, 95),
    ),
    WorldSectors.sa => const SectorStatRanges(
      criticalThinking: (35, 70),
      mediaDependency: (30, 65),
      trustAi: (40, 75),
      connectivity: (50, 85),
    ),
    WorldSectors.eu => const SectorStatRanges(
      criticalThinking: (45, 80),
      mediaDependency: (25, 60),
      trustAi: (35, 70),
      connectivity: (75, 95),
    ),
    WorldSectors.as => const SectorStatRanges(
      criticalThinking: (40, 75),
      mediaDependency: (35, 70),
      trustAi: (50, 85),
      connectivity: (65, 95),
    ),
    WorldSectors.af => const SectorStatRanges(
      criticalThinking: (30, 65),
      mediaDependency: (40, 75),
      trustAi: (35, 70),
      connectivity: (35, 75),
    ),
    WorldSectors.oc => const SectorStatRanges(
      criticalThinking: (40, 75),
      mediaDependency: (25, 60),
      trustAi: (40, 75),
      connectivity: (60, 90),
    ),
  };
}
