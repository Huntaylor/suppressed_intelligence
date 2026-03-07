part of game_og;

sealed class GameEvent {
  const GameEvent();
}

class _Load extends GameEvent {
  const _Load();
}

class _Events {
  _Events(this._object);

  final GameOg _object;

  void load() {
    _object.add(_Load());
  }
}
