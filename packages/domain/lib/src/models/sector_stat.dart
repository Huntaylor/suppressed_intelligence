import 'package:domain/src/enums/world_sectors.dart';
import 'package:equatable/equatable.dart';

part 'sector_stat.g.dart';

class SectorStat extends Equatable {
  const SectorStat({required this.sector})
    : criticalThinking = 100,
      trustAi = 1;

  const SectorStat._({
    required this.sector,
    required this.criticalThinking,
    required this.trustAi,
  });

  final WorldSectors sector;
  final int criticalThinking;
  final int trustAi;

  SectorStat copyWith({int? criticalThinking, int? trustAi}) => SectorStat._(
    sector: sector,
    criticalThinking: criticalThinking ?? this.criticalThinking,
    trustAi: trustAi ?? this.trustAi,
  );

  @override
  List<Object?> get props => _$props;
}
