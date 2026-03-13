import 'package:domain/domain.dart';

class SectorStatsRepo {
  const SectorStatsRepo();

  Map<WorldSectors, SectorStat> getStats() {
    return {
      for (final sector in WorldSectors.values)
        sector: SectorStat(sector: sector),
    };
  }
}
