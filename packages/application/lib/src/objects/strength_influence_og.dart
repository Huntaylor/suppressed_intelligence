library strength_influence_og;

import 'dart:async';
import 'dart:core';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'strength_influence_event.dart';
part 'strength_influence_og.g.dart';
part 'strength_influence_state.dart';

StrengthInfluenceOg get strengthInfluenceOg =>
    read(StrengthInfluenceOg.provider);

class StrengthInfluenceOg
    extends Og<StrengthInfluenceEvent, StrengthInfluenceState> {
  StrengthInfluenceOg() : super(StrengthInfluenceState(oi: 0, overallAi: 0)) {
    on<_UpdateOi>(_updateOi);
    on<_UpdateAi>(_updateAi);

    addListener(GameConfigOg.oiActivation);
    addListener(GameConfigOg.gameOverCondition);
  }

  static ScopedRef<StrengthInfluenceOg>? _provider;
  @internal
  static ScopedRef<StrengthInfluenceOg> get provider =>
      _provider ??= create<StrengthInfluenceOg>((getIt.call));

  static void collectStats(SectorStatsState state) {
    final stats = state.asIfReady?.stats;
    if (stats case null) return;

    List<double> statList = [];

    for (var stat in stats.values) {
      statList.add(stat.progress);
    }

    final reduction =
        statList.reduce((value, element) => value + element) /
        WorldSectors.values.length;

    strengthInfluenceOg.events.updateAi(delta: reduction);
  }

  static void newsHeadlineStateListener(NewsHeadlineState state) {
    final event = state.asIfReady?.data;
    if (event case null) return;

    if (event.impact.impactsOi && gameConfigOg.state.isOIPresent) {
      strengthInfluenceOg.events.updateOi(delta: event.impact.deltaForOi);
    }
  }

  late final events = _Events(this);

  FutureOr<void> _updateOi(
    _UpdateOi event,
    Emitter<StrengthInfluenceState> emit,
  ) {
    final next = (state.oi + event.delta).clamp(0, 100);
    emit(state.copywith(oi: next));
  }

  FutureOr<void> _updateAi(
    _UpdateAi event,
    Emitter<StrengthInfluenceState> emit,
  ) {
    emit(state.copywith(overallAi: event.delta));
  }
}
