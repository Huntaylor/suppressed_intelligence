part of game_object;

sealed class GameEvent {
  const GameEvent();
}

class _Load extends GameEvent {
  const _Load();
}

class _Events {
  _Events(this._object);

  final GameObject _object;

  void load() {
    _object._load(_Load(), _object._emitter);
  }
}
