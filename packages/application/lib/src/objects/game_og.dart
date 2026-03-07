library game_og;

import 'dart:async' show FutureOr;

import 'package:application/setup.dart';
import 'package:application/src/og.dart';
import 'package:equatable/equatable.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'game_event.dart';
part 'game_og.g.dart';
part 'game_state.dart';

final gameOgProvider = create<GameOg>((getIt.call()));
GameOg get gameOg => read(gameOgProvider);

class GameOg extends Og<GameEvent, GameState> {
  GameOg() : super(const _Playing()) {
    on<_Pause>(_pause);
    on<_Resume>(_resume);
  }

  late final events = _Events(this);

  FutureOr<void> _resume(_Resume event, Emitter<GameState> emit) {
    emit(const _Playing());
  }

  FutureOr<void> _pause(_Pause event, Emitter<GameState> emit) {
    emit(const _Paused());
  }
}
