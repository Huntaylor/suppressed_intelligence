library game_og;

import 'dart:async' show FutureOr;

import 'package:application/setup.dart';
import 'package:application/src/og.dart';
import 'package:equatable/equatable.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'game_event.dart';
part 'game_og.g.dart';
part 'game_state.dart';

final gameOgProvider = create(GameOg.new);
GameOg get gameOg => read(getIt.call());

class GameOg extends Og<GameEvent, GameState> {
  GameOg() : super(const _Loading()) {
    on<_Load>(_load);
  }

  late final events = _Events(this);

  FutureOr<void> _load(GameEvent event, Emitter<GameState> emit) {}
}
