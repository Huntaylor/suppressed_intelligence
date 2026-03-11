library strength_influence_og;

import 'dart:async';

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
  StrengthInfluenceOg() : super(StrengthInfluenceState(oi: {}, ai: {})) {
    on<_UpdateOi>(_updateOi);
    on<_UpdateAi>(_updateAi);
  }

  static ScopedRef<StrengthInfluenceOg>? _provider;
  @internal
  static ScopedRef<StrengthInfluenceOg> get provider =>
      _provider ??= create<StrengthInfluenceOg>((getIt.call));

  static void newsHeadlineStateListener(NewsHeadlineState state) {
    final event = state.asIfReady?.data;
    if (event case null) return;

    for (final sector in event.affectedSectors) {
      if (event.impact.impactsAi) {
        strengthInfluenceOg.events.updateAi(
          sector: sector,
          delta: event.impact.deltaForAi,
        );
      }

      if (event.impact.impactsOi) {
        strengthInfluenceOg.events.updateOi(
          sector: sector,
          delta: event.impact.deltaForOi,
        );
      }
    }
  }

  static void sectorBubbleStateListener(SectorBubbleState state) {
    final removed = state.asIfRemovedBubble?.bubble;
    if (removed == null) return;

    switch (removed.type) {
      case SectorBubbleType.oi:
        strengthInfluenceOg.events.updateOi(sector: removed.sector, delta: -1);

      case SectorBubbleType.ai:
        strengthInfluenceOg.events.updateAi(sector: removed.sector, delta: 1);
    }
  }

  late final events = _Events(this);

  FutureOr<void> _updateOi(
    _UpdateOi event,
    Emitter<StrengthInfluenceState> emit,
  ) {
    final next = ((state.oi[event.sector] ?? 0) + event.delta).clamp(0, 100);

    emit(state.copywith(oi: {...state.oi, event.sector: next}));
  }

  FutureOr<void> _updateAi(
    _UpdateAi event,
    Emitter<StrengthInfluenceState> emit,
  ) {
    final next = ((state.ai[event.sector] ?? 0) + event.delta).clamp(0, 100);

    emit(state.copywith(ai: {...state.ai, event.sector: next}));
  }
}
