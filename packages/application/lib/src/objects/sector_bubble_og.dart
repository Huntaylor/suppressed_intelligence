library sector_bubble_og;

import 'dart:async';
import 'dart:math';

import 'package:application/src/objects/game_config_og.dart';
import 'package:application/src/objects/game_og.dart';
import 'package:application/src/objects/info_dots_og.dart';
import 'package:application/src/objects/money_og.dart';
import 'package:application/src/objects/sector_stats_og.dart';
import 'package:application/src/objects/upgrades_og.dart';
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
    on<_SpawnFirstBubble>(_spawnFirstBubble);
    on<_ClickBubble>(_clickBubble);
    on<_ClearBubble>(_clearBubble);
    on<_Pause>(_pause);
    on<_Resume>(_resume);

    addListener(InfoDotsOg.sectorBubbleStateListener);
    addListener(MoneyOg.sectorBubbleStateListener);
    addListener(SectorStatsOg.sectorBubbleStateListener);
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
  PausableTimer? _expiryTimer;
  Duration _interval = _defaultInterval;
  static const _defaultInterval = Duration(seconds: 1);
  static const _bubbleLifespan = Duration(seconds: 10);
  int _activeSeconds = 0;
  final Map<int, int> _bubbleSpawnTimes = {};

  @override
  void dispose() {
    gameOg.removeListener(gameStateListener);
    _timer?.cancel();
    _expiryTimer?.cancel();
    super.dispose();
  }

  FutureOr<void> _init(_Init event, Emitter<SectorBubbleState> emit) {
    _interval = event.interval ?? _defaultInterval;
    _startTimer();
    _startExpiryTimer();
  }

  void _spawnFirstBubble(
    _SpawnFirstBubble event,
    Emitter<SectorBubbleState> emit,
  ) {
    if (state.bubbles.isNotEmpty) return;

    final bubble = SectorBubble(
      sector: event.sector,
      type: SectorBubbleType.ai,
      position: (x: event.x, y: event.y),
    );
    _bubbleSpawnTimes[bubble.id] = _activeSeconds;
    emit(SectorBubbleState(bubbles: [...state.bubbles, bubble]));
  }

  void _spawnBubble(_SpawnBubble event, Emitter<SectorBubbleState> emit) {
    if (upgradesOg.state.hasPurchased(
      ResearchDevelopmentUpgrade.hardwareUpgrade1,
    )) {
      return;
    }

    final config = gameConfigOg.state;
    if (config.infectedSectors.isEmpty) return;

    final sectors = config.infectedSectors.toList();
    final sector = sectors[_random.nextInt(sectors.length)];
    final type = config.isOIPresent
        ? SectorBubbleType.values[_random.nextInt(2)]
        : SectorBubbleType.ai;
    final bubble = SectorBubble(sector: sector, type: type);

    _bubbleSpawnTimes[bubble.id] = _activeSeconds;
    emit(SectorBubbleState(bubbles: [...state.bubbles, bubble]));
  }

  void _clickBubble(_ClickBubble event, Emitter<SectorBubbleState> emit) {
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
    _bubbleSpawnTimes.remove(bubble.id);

    emit(_ClickedBubble(bubble));
    emit(SectorBubbleState(bubbles: bubbles));
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
    _bubbleSpawnTimes.remove(bubble.id);

    emit(SectorBubbleState(bubbles: bubbles));
  }

  void _startTimer() {
    if (_timer?.isRunning case true) return;

    _timer = PausableTimer(_interval, () {
      add(const _SpawnBubble());
    });
  }

  void _startExpiryTimer() {
    if (_expiryTimer?.isRunning case true) return;

    _expiryTimer = PausableTimer(const Duration(seconds: 1), () {
      _activeSeconds++;
      for (final entry in _bubbleSpawnTimes.entries.toList()) {
        if (_activeSeconds - entry.value >= _bubbleLifespan.inSeconds) {
          add(_ClearBubble(bubbleId: entry.key));
        }
      }
    });
  }

  void _pause(_Pause event, Emitter<SectorBubbleState> emit) {
    _timer?.pause();
    _expiryTimer?.pause();
  }

  void _resume(_Resume event, Emitter<SectorBubbleState> emit) {
    _timer?.resume();
    _expiryTimer?.resume();
  }
}
