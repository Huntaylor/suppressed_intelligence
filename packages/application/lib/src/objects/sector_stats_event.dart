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

class _Events {
  _Events(this._object);

  final SectorStatsOg _object;

  void init() {
    _object.add(const _Init());
  }

  void refresh() {
    _object.add(const _Refresh());
  }
}
