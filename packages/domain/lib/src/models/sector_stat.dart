import 'package:domain/src/enums/world_sectors.dart';
import 'package:domain/src/models/sector_stat_ranges.dart';
import 'package:equatable/equatable.dart';

part 'sector_stat.g.dart';

class SectorStat extends Equatable {
  const SectorStat({
    required this.sector,
    required this.criticalThinking,
    required this.mediaDependency,
    required this.trustAi,
    required this.connectivity,
  });

  final WorldSectors sector;
  final int criticalThinking;
  final int mediaDependency;
  final int trustAi;
  final int connectivity;

  /// Creates a [SectorStat] from [ranges] using the midpoint of each range.
  factory SectorStat.fromRanges(WorldSectors sector, SectorStatRanges ranges) {
    return SectorStat(
      sector: sector,
      criticalThinking: _midpoint(ranges.criticalThinking),
      mediaDependency: _midpoint(ranges.mediaDependency),
      trustAi: _midpoint(ranges.trustAi),
      connectivity: _midpoint(ranges.connectivity),
    );
  }

  static int _midpoint((int min, int max) range) =>
      (range.$1 + range.$2) ~/ 2;

  SectorStat copyWith({
    int? criticalThinking,
    int? mediaDependency,
    int? trustAi,
    int? connectivity,
  }) => SectorStat(
    sector: sector,
    criticalThinking: criticalThinking ?? this.criticalThinking,
    mediaDependency: mediaDependency ?? this.mediaDependency,
    trustAi: trustAi ?? this.trustAi,
    connectivity: connectivity ?? this.connectivity,
  );

  @override
  List<Object?> get props => _$props;
}
