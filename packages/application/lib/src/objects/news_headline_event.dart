part of news_headline_og;

sealed class NewsHeadlineEvent {
  const NewsHeadlineEvent();
}

class _Init extends NewsHeadlineEvent {
  const _Init({required this.interval});

  final Duration interval;
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

  void checkForUpdates() {
    _object.add(_CheckForUpdates());
  }
}
