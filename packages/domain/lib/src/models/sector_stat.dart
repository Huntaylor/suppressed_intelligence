import 'package:domain/src/enums/world_sectors.dart';
import 'package:equatable/equatable.dart';

part 'sector_stat.g.dart';

class SectorStat extends Equatable {
  const SectorStat({required this.sector})
    : criticalThinking = 100,
      trustAi = 1,
      receievedInfoDots = 0;

  const SectorStat._({
    required this.sector,
    required this.criticalThinking,
    required this.trustAi,
    required this.receievedInfoDots,
  });

  final WorldSectors sector;
  final int criticalThinking;
  final int trustAi;
  final int receievedInfoDots;

  double get progress => (trustAi + (100 - criticalThinking)) / 2;
  bool get isComplete => trustAi >= 100 && criticalThinking <= 0;

  SectorStat copyWith({int? criticalThinking, int? trustAi}) => SectorStat._(
    sector: sector,
    criticalThinking: criticalThinking ?? this.criticalThinking,
    trustAi: trustAi ?? this.trustAi,
    receievedInfoDots: receievedInfoDots,
  );

  SectorStat incrementReceievedInfoDots() => SectorStat._(
    sector: sector,
    criticalThinking: criticalThinking,
    trustAi: trustAi,
    receievedInfoDots: receievedInfoDots + 1,
  );

  @override
  List<Object?> get props => _$props;
}
