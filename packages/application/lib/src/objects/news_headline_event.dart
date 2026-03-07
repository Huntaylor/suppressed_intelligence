part of news_headline_og;

sealed class NewsHeadlineEvent {
  const NewsHeadlineEvent();
}

class _Init extends NewsHeadlineEvent {
  const _Init();
}

class _CheckForUpdates extends NewsHeadlineEvent {
  const _CheckForUpdates();
}

class _Events {
  _Events(this._object);

  final NewsHeadlineOg _object;

  void init() {
    _object.add(_Init());
  }

  void checkForUpdates() {
    _object.add(_CheckForUpdates());
  }
}
