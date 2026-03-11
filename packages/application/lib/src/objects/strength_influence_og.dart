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

StrengthInfluenceOg get strengthInfluenceOg => read(StrengthInfluenceOg.provider);

class StrengthInfluenceOg extends Og<StrengthInfluenceEvent, StrengthInfluenceState> {
  StrengthInfluenceOg()
    : super(const StrengthInfluenceState(
        oi: StrengthInfluence(strength: 0.5, influence: 0.5),
        ai: StrengthInfluence(strength: 0.5, influence: 0.5),
      )) {
    on<_UpdateOi>(_updateOi);
    on<_UpdateAi>(_updateAi);
  }

  static ScopedRef<StrengthInfluenceOg>? _provider;
  @internal
  static ScopedRef<StrengthInfluenceOg> get provider =>
      _provider ??= create<StrengthInfluenceOg>((getIt.call));

  late final events = _Events(this);

  FutureOr<void> _updateOi(
    _UpdateOi event,
    Emitter<StrengthInfluenceState> emit,
  ) {
    emit(state.copywith(
      oi: state.oi.copyWith(
        strength: event.strength,
        influence: event.influence,
      ),
    ));
  }

  FutureOr<void> _updateAi(
    _UpdateAi event,
    Emitter<StrengthInfluenceState> emit,
  ) {
    emit(state.copywith(
      ai: state.ai.copyWith(
        strength: event.strength,
        influence: event.influence,
      ),
    ));
  }
}
