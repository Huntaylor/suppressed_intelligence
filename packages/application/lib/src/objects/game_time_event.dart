part of game_time_og;

sealed class GameTimeEvent {
  const GameTimeEvent();
}

class _Init extends GameTimeEvent {
  const _Init({
    this.month = 1,
    this.year = 2024,
    this.interval,
  });

  final int month;
  final int year;
  final Duration? interval;
}

class _Tick extends GameTimeEvent {
  const _Tick();
}

class _Events {
  _Events(this._object);

  final GameTimeOg _object;

  void init({
    int month = 1,
    int year = 2024,
    Duration? interval,
  }) {
    _object.add(_Init(
      month: month,
      year: year,
      interval: interval ?? GameTimeOg._defaultInterval,
    ));
  }
}
