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

// class _Win extends GameEvent {
//   const _Win();
// }

// class _Lose extends GameEvent {
//   const _Lose();
// }

class _Events {
  _Events(this._object);

  final GameOg _object;

  void pause() {
    _object.add(_Pause());
  }

  void resume() {
    _object.add(_Resume());
  }

  // void win() {
  //   _object.add(_Win());
  // }

  // void lose() {
  //   _object.add(_Lose());
  // }
}
