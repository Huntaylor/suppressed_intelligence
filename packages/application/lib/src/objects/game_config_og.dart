library game_config_og;

import 'dart:async';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'game_config_event.dart';
part 'game_config_og.g.dart';
part 'game_config_state.dart';

GameConfigOg get gameConfigOg => read(GameConfigOg.provider);

class GameConfigOg extends Og<GameConfigEvent, GameConfigState> {
  GameConfigOg()
    : super(const GameConfigState(name: _defaultName, infectedSectors: {})) {
    on<_AddName>(_addName);
    on<_InfectSector>(_infectSector);
    on<_InfectFirstSector>(_infectFirstSector);
    on<_ClearInfectedSectors>(_clearInfectedSectors);
    on<_SetOIPresent>(_setOIPresent);
    on<_GameOver>(_gameOver);
  }

  static const _defaultName = 'ChatGibitty';
  static ScopedRef<GameConfigOg>? _provider;
  @internal
  static ScopedRef<GameConfigOg> get provider =>
      _provider ??= create<GameConfigOg>((getIt.call));

  late final events = _Events(this);

  static void gameOverCondition(StrengthInfluenceState state) {
    final oiStat = state.oi;
    final aiStat = state.overallAi;

    if (aiStat.floor() >= 100) {
      gameConfigOg.add(_GameOver(gameOverCondition: .win));
    }

    if (oiStat >= 100) {
      gameConfigOg.add(_GameOver(gameOverCondition: .lose));
    }
  }

  FutureOr<void> _addName(_AddName event, Emitter<GameConfigState> emit) {
    emit(state.copywith(name: event.name));
  }

  FutureOr<void> _infectSector(
    _InfectSector event,
    Emitter<GameConfigState> emit,
  ) {
    emit(
      state.copywith(infectedSectors: {...state.infectedSectors, event.sector}),
    );
  }

  void _infectFirstSector(
    _InfectFirstSector event,
    Emitter<GameConfigState> emit,
  ) {
    if (state.infectedSectors.isNotEmpty) return;

    emit(
      state.copywith(infectedSectors: {...state.infectedSectors, event.sector}),
    );

    if (tutorialOg.state.enabledTutorial) {
      tutorialOg.events.show();
    }
  }

  void _clearInfectedSectors(
    _ClearInfectedSectors event,
    Emitter<GameConfigState> emit,
  ) {
    emit(state.copywith(infectedSectors: {}));
  }

  void _setOIPresent(_SetOIPresent event, Emitter<GameConfigState> emit) {
    emit(state.copywith(isOIPresent: true));
  }

  static void oiActivation(StrengthInfluenceState state) {
    final overallAi = state.overallAi;

    if (overallAi >= 20) {
      gameConfigOg.events.setOIPresent();
    }
  }

  FutureOr<void> _gameOver(_GameOver event, Emitter<GameConfigState> emit) {
    emit(state.copywith(gameOverCondition: event.gameOverCondition));
  }
}
