library game_og;

import 'dart:async' show FutureOr;
import 'package:application/src/objects/strength_influence_og.dart';
import 'package:application/src/og.dart';
import 'package:application/src/setup/setup.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'tutorial_event.dart';
part 'tutorial_og.g.dart';
part 'tutorial_state.dart';

TutorialOg get tutorialOg => read(TutorialOg.provider);

class TutorialOg extends Og<TutorialEvent, TutorialState> {
  TutorialOg() : super(const TutorialState()) {
    on<_Start>(_start);
    on<_Next>(_next);
    on<_Show>(_show);
  }
  static ScopedRef<TutorialOg>? _provider;
  @internal
  static ScopedRef<TutorialOg> get provider =>
      _provider ??= create<TutorialOg>((getIt.call));

  late final events = _Events(this);

  static void oiUpdate(StrengthInfluenceState state) {
    if (state.overallAi >= 15 && tutorialOg.state.tutorialStep <= 7) {
      tutorialOg.events.show();
    }
  }

  FutureOr<void> _start(_Start event, Emitter<TutorialState> emit) {
    emit(state.copywith(enabledTutorial: event.enabled));
  }

  FutureOr<void> _next(_Next event, Emitter<TutorialState> emit) {
    emit(
      state.copywith(
        tutorialStep: state.tutorialStep + 1,
        shouldShowWindow: false,
      ),
    );

    if (state.tutorialStep >= 2 && state.tutorialStep <= 4) {
      add(_Show());
    } else if (state.tutorialStep >= 5 &&
        state.tutorialStep <= 6 &&
        strengthInfluenceOg.state.overallAi >= 15) {
      add(_Show());
    }
    if (state.tutorialStep <= 7) {}
  }

  FutureOr<void> _show(_Show event, Emitter<TutorialState> emit) {
    emit(state.copywith(shouldShowWindow: true));
  }
}
