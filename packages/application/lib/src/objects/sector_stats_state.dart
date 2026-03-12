// ignore_for_file: library_private_types_in_public_api

part of sector_stats_og;

sealed class SectorStatsState extends Equatable {
  const SectorStatsState();

  bool get isLoading => this is _Loading;
  _Loading? get asIfLoading => switch (this) {
    final _Loading state => state,
    _ => null,
  };

  bool get isReady => this is _Ready;
  _Ready? get asIfReady => switch (this) {
    final _Ready state => state,
    _ => null,
  };

  @override
  List<Object?> get props => [];
}

class _Loading extends SectorStatsState {
  const _Loading();
}

class _Ready extends SectorStatsState {
  const _Ready({required this.stats, this.selectedSector});

  final Map<WorldSectors, SectorStat> stats;
  final WorldSectors? selectedSector;

  _Ready setSector(WorldSectors selectedSector) {
    return _Ready(stats: stats, selectedSector: selectedSector);
  }

  _Ready removeSector() {
    return _Ready(stats: stats, selectedSector: null);
  }

  @override
  List<Object?> get props => _$props;
}
