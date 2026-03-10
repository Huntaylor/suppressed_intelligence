part of game_config_og;

sealed class GameConfigEvent {
  const GameConfigEvent();
}

class _AddName extends GameConfigEvent {
  const _AddName({required this.name});

  final String name;
}

class _Events {
  _Events(this._object);

  final GameConfigOg _object;

  void addName(String name) {
    _object.add(_AddName(name: name));
  }
}
