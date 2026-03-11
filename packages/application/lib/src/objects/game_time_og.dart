library game_time_og;

import 'dart:async';

import 'package:application/src/og.dart';
import 'package:application/src/setup/setup.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'game_time_event.dart';
part 'game_time_og.g.dart';
part 'game_time_state.dart';

GameTimeOg get gameTimeOg => read(GameTimeOg.provider);

class GameTimeOg extends Og<GameTimeEvent, GameTimeState> {
  GameTimeOg() : super(const GameTimeState(month: 1, year: 2024)) {
    on<_Init>(_init);
    on<_Tick>(_tick);
  }

  static ScopedRef<GameTimeOg>? _provider;
  @internal
  static ScopedRef<GameTimeOg> get provider =>
      _provider ??= create<GameTimeOg>((getIt.call));

  static const _defaultInterval = Duration(seconds: 3);

  late final events = _Events(this);

  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  FutureOr<void> _init(_Init event, Emitter<GameTimeState> emit) async {
    if (_timer?.isActive case true) {
      assert(
        _timer == null,
        'Timer is already set and running, this should only be called once',
      );

      return;
    }

    _timer?.cancel();
    emit(GameTimeState(month: event.month, year: event.year));
    _startTimer(event.interval ?? _defaultInterval);
  }

  FutureOr<void> _tick(_Tick event, Emitter<GameTimeState> emit) {
    var nextMonth = state.month + 1;
    var nextYear = state.year;
    if (nextMonth > 12) {
      nextMonth = 1;
      nextYear++;
    }
    emit(state.copywith(month: nextMonth, year: nextYear));
  }

  void _startTimer(Duration interval) {
    if (_timer?.isActive case true) return;

    _timer = Timer.periodic(interval, (_) {
      add(const _Tick());
    });
  }
}
