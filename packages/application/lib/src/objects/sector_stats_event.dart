part of sector_stats_og;

sealed class SectorStatsEvent {
  const SectorStatsEvent();
}

class _Init extends SectorStatsEvent {
  const _Init();
}

class _Refresh extends SectorStatsEvent {
  const _Refresh();
}

class _ApplyNewsImpact extends SectorStatsEvent {
  const _ApplyNewsImpact(this.event);
  final NewsEvent event;
}

class _SelectSector extends SectorStatsEvent {
  const _SelectSector({required this.sector});
  final WorldSectors sector;
}

class _RemoveSelection extends SectorStatsEvent {
  const _RemoveSelection();
}

class _Events {
  _Events(this._object);

  final SectorStatsOg _object;

  void init() {
    _object.add(const _Init());
  }

  void refresh() {
    _object.add(const _Refresh());
  }

  void selectSector(WorldSectors sector) {
    _object.add(_SelectSector(sector: sector));
  }

  void removeSelection() {
    _object.add(const _RemoveSelection());
  }
}
