library info_dots_og;

import 'dart:async';
import 'dart:math';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'info_dots_event.dart';
part 'info_dots_og.g.dart';
part 'info_dots_state.dart';

InfoDotsOg get infoDotsOg => read(InfoDotsOg.provider);

class InfoDotsOg extends Og<InfoDotsEvent, InfoDotsState> {
  InfoDotsOg() : super(const InfoDotsState()) {
    on<_SpawnInfoDot>(_spawnInfoDot);
    on<_DropInfoDot>(_dropInfoDot);
    on<_StartAuto>(_startAuto);
  }

  static const _autoEmitInterval = Duration(milliseconds: 500);
  /// Shorter interval when [ResearchDevelopmentUpgrade.hardwareUpgrade2] is purchased.
  static const _autoEmitIntervalHardware2 = Duration(milliseconds: 250);
  PausableTimer? _autoEmitTimer;
  final Random _random = Random();

  static void gameStateListener(GameState state) {
    if (state.isPaused case true) {
      infoDotsOg._autoEmitTimer?.pause();
    } else {
      infoDotsOg._autoEmitTimer?.resume();
    }
  }

  static void onUpgradesStateChanged(UpgradesState state) {
    if (!state.hasPurchased(ResearchDevelopmentUpgrade.hardwareUpgrade1)) {
      return;
    }

    // When hardwareUpgrade2 is purchased, restart timer with higher frequency.
    if (state.hasPurchased(ResearchDevelopmentUpgrade.hardwareUpgrade2) &&
        infoDotsOg._autoEmitTimer != null) {
      infoDotsOg._autoEmitTimer?.cancel();
      infoDotsOg._autoEmitTimer = null;
    }

    if (infoDotsOg._autoEmitTimer != null) {
      return;
    }

    infoDotsOg.add(_StartAuto());
  }

  @override
  void dispose() {
    _autoEmitTimer?.cancel();
    super.dispose();
  }

  static void sectorBubbleStateListener(SectorBubbleState state) {
    final spawned = state.asIfClickedBubble?.bubble;
    if (spawned == null) return;

    if (spawned.type != SectorBubbleType.ai) return;

    final pipes = Pipe.allBySector(spawned.sector);

    for (final pipe in pipes) {
      infoDotsOg.add(_SpawnInfoDot(fromSector: spawned.sector, pipe: pipe));
    }
  }

  static ScopedRef<InfoDotsOg>? _provider;
  @internal
  static ScopedRef<InfoDotsOg> get provider =>
      _provider ??= create<InfoDotsOg>((getIt.call));

  late final events = _Events(this);

  FutureOr<void> _spawnInfoDot(
    _SpawnInfoDot event,
    Emitter<InfoDotsState> emit,
  ) {
    final existing = state.asIfVisibleDots?.dots;

    emit(
      _VisibleDots(
        dots: [
          ...?existing,
          InfoDot(fromSector: event.fromSector, pipe: event.pipe),
        ],
      ),
    );
  }

  void _dropInfoDot(_DropInfoDot event, Emitter<InfoDotsState> emit) {
    final dots = state.asIfVisibleDots?.dots;
    if (dots == null) {
      return;
    }

    emit(_VisibleDots(dots: dots..remove(event.dot)));
  }

  Duration get _currentAutoEmitInterval =>
      upgradesOg.state.hasPurchased(ResearchDevelopmentUpgrade.hardwareUpgrade2)
          ? _autoEmitIntervalHardware2
          : _autoEmitInterval;

  void _startAuto(_StartAuto event, Emitter<InfoDotsState> emit) {
    if (_autoEmitTimer?.isRunning case true) return;

    _autoEmitTimer = PausableTimer(_currentAutoEmitInterval, () {
      final config = gameConfigOg.state;
      if (config.infectedSectors.isEmpty) return;

      final sectors = config.infectedSectors.toList();
      final sector = sectors[_random.nextInt(sectors.length)];
      final pipes = Pipe.allBySector(sector);
      if (pipes.isEmpty) return;

      final pipe = pipes[_random.nextInt(pipes.length)];
      add(_SpawnInfoDot(fromSector: sector, pipe: pipe));
    });
  }
}
