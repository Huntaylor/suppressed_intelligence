library sector_bubble_og;

import 'dart:async';
import 'dart:math';

import 'package:application/src/objects/game_og.dart';
import 'package:application/src/og.dart';
import 'package:application/src/setup/setup.dart';
import 'package:application/src/utils/pausible_timer.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'sector_bubble_event.dart';
part 'sector_bubble_og.g.dart';
part 'sector_bubble_state.dart';

SectorBubbleOg get sectorBubbleOg => read(SectorBubbleOg.provider);

class SectorBubbleOg extends Og<SectorBubbleEvent, SectorBubbleState> {
  SectorBubbleOg() : super(const SectorBubbleState()) {
    on<_Init>(_init);
    on<_SpawnBubble>(_spawnBubble);
    on<_ClearBubble>(_clearBubble);
    on<_Pause>(_pause);
    on<_Resume>(_resume);
  }

  static ScopedRef<SectorBubbleOg>? _provider;
  @internal
  static ScopedRef<SectorBubbleOg> get provider =>
      _provider ??= create<SectorBubbleOg>((getIt.call));

  static void gameStateListener(GameState state) {
    if (state.isPaused case true) {
      sectorBubbleOg.add(const _Pause());
    } else {
      sectorBubbleOg.add(const _Resume());
    }
  }

  late final events = _Events(this);

  final Random _random = Random();
  PausableTimer? _timer;
  Duration _interval = _defaultInterval;
  static const _defaultInterval = Duration(seconds: 8);

  @override
  void dispose() {
    gameOg.removeListener(gameStateListener);
    _timer?.cancel();
    super.dispose();
  }

  FutureOr<void> _init(_Init event, Emitter<SectorBubbleState> emit) {
    _interval = event.interval ?? _defaultInterval;
    _startTimer();
  }

  FutureOr<void> _spawnBubble(
    _SpawnBubble event,
    Emitter<SectorBubbleState> emit,
  ) {
    final sectors = WorldSectors.values;
    final sector = sectors[_random.nextInt(sectors.length)];
    final type = SectorBubbleType.values[_random.nextInt(2)];
    final bubble = SectorBubble(sector: sector, type: type);

    emit(SectorBubbleState(bubbles: [...state.bubbles, bubble]));
  }

  void _clearBubble(_ClearBubble event, Emitter<SectorBubbleState> emit) {
    SectorBubble? bubble;
    final bubbles = [...state.bubbles];
    for (final b in state.bubbles) {
      if (b.id == event.bubbleId) {
        bubble = b;
        break;
      }
    }

    if (bubble == null) return;
    bubbles.remove(bubble);

    emit(_RemovedBubble(bubble));
    emit(SectorBubbleState(bubbles: bubbles));
  }

  void _startTimer() {
    if (_timer?.isRunning case true) return;

    _timer = PausableTimer(_interval, () {
      add(const _SpawnBubble());
    });
  }

  void _pause(_Pause event, Emitter<SectorBubbleState> emit) {
    _timer?.pause();
  }

  void _resume(_Resume event, Emitter<SectorBubbleState> emit) {
    _timer?.resume();
  }
}
