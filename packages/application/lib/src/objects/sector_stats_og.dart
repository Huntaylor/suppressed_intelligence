library sector_stats_og;

import 'dart:async';
import 'dart:math';

import 'package:application/src/objects/game_config_og.dart';
import 'package:application/src/objects/news_headline_og.dart';
import 'package:application/src/objects/sector_bubble_og.dart';
import 'package:application/src/objects/strength_influence_og.dart';
import 'package:application/src/objects/upgrades_og.dart';
import 'package:application/src/og.dart';
import 'package:application/src/setup/setup.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'sector_stats_event.dart';
part 'sector_stats_og.g.dart';
part 'sector_stats_state.dart';

SectorStatsOg get sectorStatsOg => read(SectorStatsOg.provider);

class SectorStatsOg extends Og<SectorStatsEvent, SectorStatsState> {
  SectorStatsOg({required SectorStatsRepo repo})
    : _repo = repo,
      super(const _Loading()) {
    on<_Init>(_init);
    on<_Refresh>(_refresh);
    on<_ApplyNewsImpact>(_applyNewsImpact);
    on<_ApplyBubbleImpact>(_applyBubbleImpact);
    on<_SelectSector>(_selectSector);
    on<_RemoveSelection>(_removeSelection);
    on<_ReceiveInfoDot>(_receiveInfoDot);
    on<_ApplyTrustAiBonus>(_applyTrustAiBonus);
    on<_ResetReceivedInfoDots>(_resetReceivedInfoDots);
    on<_HalveTrustAi>(_halveTrustAi);

    addListener(StrengthInfluenceOg.collectStats);
  }

  static ScopedRef<SectorStatsOg>? _provider;
  @internal
  static ScopedRef<SectorStatsOg> get provider =>
      _provider ??= create<SectorStatsOg>((getIt.call));

  static void newsHeadlineStateListener(NewsHeadlineState state) {
    final event = state.asIfReady?.data;
    if (event == null) return;
    sectorStatsOg.add(_ApplyNewsImpact(event));
  }

  static void sectorBubbleStateListener(SectorBubbleState state) {
    final clicked = state.asIfClickedBubble?.bubble;
    if (clicked == null) return;

    switch (clicked.type) {
      case SectorBubbleType.oi:
        strengthInfluenceOg.events.updateOi(delta: -1);

      case SectorBubbleType.ai:
        sectorStatsOg.add(_ApplyBubbleImpact(clicked.sector));
    }
  }

  late final events = _Events(this);

  final SectorStatsRepo _repo;

  FutureOr<void> _init(_Init event, Emitter<SectorStatsState> emit) {
    add(const _Refresh());
  }

  FutureOr<void> _refresh(
    _Refresh event,
    Emitter<SectorStatsState> emit,
  ) async {
    emit(const _Loading());
    final stats = _repo.getStats();
    emit(_Ready(stats: stats));
  }

  void _applyNewsImpact(
    _ApplyNewsImpact event,
    Emitter<SectorStatsState> emit,
  ) {
    final current = state.asIfReady;
    if (current == null) return;

    final newsEvent = event.event;
    final impact = newsEvent.impact;
    // Apply impact only to infected sectors (news pool).
    final sectorsToUpdate = gameConfigOg.state.infectedSectors;

    final updated = Map<WorldSectors, SectorStat>.from(current.stats);
    for (final sector in sectorsToUpdate) {
      final stat = updated[sector];
      if (stat == null) continue;

      updated[sector] = stat.copyWith(
        criticalThinking: _clampStat(
          stat.criticalThinking + impact.criticalThinking,
        ),
        trustAi: _clampStat(stat.trustAi + impact.trustAi),
      );
    }

    emit(_Ready(stats: updated, selectedSector: current.selectedSector));
  }

  void _applyBubbleImpact(
    _ApplyBubbleImpact event,
    Emitter<SectorStatsState> emit,
  ) {
    final current = state.asIfReady;
    if (current == null) return;

    // Apply impact only to infected sectors (news pool).

    final sectorMap = Map<WorldSectors, SectorStat>.from(current.stats);
    final stat = sectorMap[event.sector];

    if (stat == null) return;

    final updated = stat.copyWith(
      criticalThinking: _clampStat(stat.criticalThinking - 5),
      trustAi: _clampStat(stat.trustAi + 5),
    );

    emit(current.updateStat(event.sector, updated));
  }

  void _selectSector(_SelectSector event, Emitter<SectorStatsState> emit) {
    final current = state.asIfReady;
    if (current == null) return;
    emit(current.setSector(event.sector));
  }

  void _removeSelection(
    _RemoveSelection event,
    Emitter<SectorStatsState> emit,
  ) {
    final current = state.asIfReady;
    if (current == null) return;
    emit(current.removeSector());
  }

  static int _clampStat(int value) => value.clamp(0, 100);

  static const _infectionBasePercent = 1;
  static const _infectionPerReceivedPercent = 2;

  /// Each already-infected sector reduces infection chance (harder to spread).
  static const _infectionPenaltyPerInfectedPercent = 8;

  /// Sentiment Analysis upgrade: sectors 8% more likely to become infected.
  static const _infectionSentimentAnalysisBonusPercent = 8;

  /// When [hardwareUpgrade1] is purchased, each info dot received in a sector
  /// increases that sector's trustAI by 0.025 percentage points (+1 every 40 receives).
  static const _trustAiBonusEveryNReceivesHardware1 = 40;

  /// When [hardwareUpgrade2] is purchased, each info dot received in a sector
  /// increases that sector's trustAI by 0.05 percentage points (+1 every 20 receives).
  static const _trustAiBonusEveryNReceivesHardware2 = 20;

  void _receiveInfoDot(_ReceiveInfoDot event, Emitter<SectorStatsState> emit) {
    final current = state.asIfReady;

    final stats = state.asIfReady?.stats;
    final sector = event.dot.toSector;
    final stat = stats?[sector];
    if (stat == null || current == null) return;

    var updated = stat.incrementReceievedInfoDots();
    var trustBonus = 0;
    if (upgradesOg.state.hasPurchased(
          ResearchDevelopmentUpgrade.hardwareUpgrade1,
        ) &&
        updated.receievedInfoDots % _trustAiBonusEveryNReceivesHardware1 == 0) {
      trustBonus += 1;
    }
    if (upgradesOg.state.hasPurchased(
          ResearchDevelopmentUpgrade.hardwareUpgrade2,
        ) &&
        updated.receievedInfoDots % _trustAiBonusEveryNReceivesHardware2 == 0) {
      trustBonus += 1;
    }
    if (trustBonus != 0) {
      updated = updated.copyWith(
        trustAi: _clampStat(updated.trustAi + trustBonus),
        criticalThinking: _clampStat(updated.criticalThinking - trustBonus),
      );
    }
    emit(current.updateStat(sector, updated));

    final infectedSectors = gameConfigOg.state.infectedSectors;
    if (!infectedSectors.contains(sector) &&
        _hasBecomeInfected(
          receivedInfoCount: updated.receievedInfoDots,
          infectedSectorCount: infectedSectors.length,
        )) {
      gameConfigOg.events.infectSector(sector);
    }
  }

  void _applyTrustAiBonus(
    _ApplyTrustAiBonus event,
    Emitter<SectorStatsState> emit,
  ) {
    final current = state.asIfReady;
    if (current == null) return;
    final updated = Map<WorldSectors, SectorStat>.from(current.stats);
    for (final entry in updated.entries) {
      final stat = entry.value;
      updated[entry.key] = stat.copyWith(
        trustAi: _clampStat(stat.trustAi + event.amount),
      );
    }
    emit(_Ready(stats: updated, selectedSector: current.selectedSector));
  }

  void _resetReceivedInfoDots(
    _ResetReceivedInfoDots event,
    Emitter<SectorStatsState> emit,
  ) {
    final current = state.asIfReady;
    if (current == null) return;
    final updated = Map<WorldSectors, SectorStat>.from(current.stats);
    for (final entry in updated.entries) {
      updated[entry.key] = entry.value.withReceievedInfoDots(0);
    }
    emit(_Ready(stats: updated, selectedSector: current.selectedSector));
  }

  void _halveTrustAi(_HalveTrustAi event, Emitter<SectorStatsState> emit) {
    final current = state.asIfReady;
    if (current == null) return;
    final updated = Map<WorldSectors, SectorStat>.from(current.stats);
    for (final entry in updated.entries) {
      final stat = entry.value;
      updated[entry.key] = stat.copyWith(
        trustAi: _clampStat(stat.trustAi ~/ 2),
      );
    }
    emit(_Ready(stats: updated, selectedSector: current.selectedSector));
  }

  bool _hasBecomeInfected({
    required int receivedInfoCount,
    required int infectedSectorCount,
  }) {
    var rawPercent =
        _infectionBasePercent +
        receivedInfoCount * _infectionPerReceivedPercent;
    final penalty = infectedSectorCount * _infectionPenaltyPerInfectedPercent;
    rawPercent -= penalty;
    if (upgradesOg.state.hasPurchased(
      ResearchDevelopmentUpgrade.sentimentAnalysis,
    )) {
      rawPercent += _infectionSentimentAnalysisBonusPercent;
    }
    final probabilityPercent = rawPercent.clamp(0, 100);
    return _random.nextInt(100) < probabilityPercent;
  }

  final Random _random = Random();
}
