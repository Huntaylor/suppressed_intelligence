part of news_headline_og;

sealed class NewsHeadlineEvent {
  const NewsHeadlineEvent();
}

class _Init extends NewsHeadlineEvent {
  const _Init({required this.interval});

  final Duration interval;
}

/// Initializes with the first headline when AI emerges in the given sector.
/// Only valid when [infectedSectors] has exactly one sector.
class _InitWithFirstSector extends NewsHeadlineEvent {
  const _InitWithFirstSector({required this.sector});

  final WorldSectors sector;
}

class _CheckForUpdates extends NewsHeadlineEvent {
  const _CheckForUpdates();
}

class _Pause extends NewsHeadlineEvent {
  const _Pause();
}

class _Resume extends NewsHeadlineEvent {
  const _Resume();
}

class _Events {
  _Events(this._object);

  final NewsHeadlineOg _object;

  void init({Duration interval = NewsHeadlineOg._defaultInterval}) {
    _object.add(_Init(interval: interval));
  }

  void initWithFirstSector(WorldSectors sector) {
    _object.add(_InitWithFirstSector(sector: sector));
  }

  void checkForUpdates() {
    _object.add(_CheckForUpdates());
  }
}
