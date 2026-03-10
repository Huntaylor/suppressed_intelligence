library game_config_og;

import 'dart:async';

import 'package:application/application.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'game_config_event.dart';
part 'game_config_og.g.dart';
part 'game_config_state.dart';

GameConfigOg get gameConfigOg => read(GameConfigOg.provider);

class GameConfigOg extends Og<GameConfigEvent, GameConfigState> {
  GameConfigOg() : super(const GameConfigState(name: 'ChatGibitty')) {
    on<_AddName>(_addName);
  }

  static ScopedRef<GameConfigOg>? _provider;
  @internal
  static ScopedRef<GameConfigOg> get provider =>
      _provider ??= create<GameConfigOg>((getIt.call));

  late final events = _Events(this);

  FutureOr<void> _addName(_AddName event, Emitter<GameConfigState> emit) {
    emit(GameConfigState(name: event.name));
  }
}
