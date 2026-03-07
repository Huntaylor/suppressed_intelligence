part of game_og;

sealed class GameEvent {
  const GameEvent();
}

class _Pause extends GameEvent {
  const _Pause();
}

class _Resume extends GameEvent {
  const _Resume();
}

class _Events {
  _Events(this._object);

  final GameOg _object;

  void pause() {
    _object.add(_Pause());
  }

  void resume() {
    _object.add(_Resume());
  }
}
