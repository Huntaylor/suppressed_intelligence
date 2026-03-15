part of game_og;

sealed class TutorialEvent {
  const TutorialEvent();
}

class _Start extends TutorialEvent {
  final bool enabled;
  const _Start({required this.enabled});
}

class _Next extends TutorialEvent {
  const _Next();
}

class _Show extends TutorialEvent {
  const _Show();
}

class _Events {
  _Events(this._object);

  final TutorialOg _object;

  void shouldStart(bool enabled) {
    _object.add(_Start(enabled: enabled));
  }

  void show() {
    _object.add(_Show());
  }

  void next() {
    _object.add(_Next());
  }
}
