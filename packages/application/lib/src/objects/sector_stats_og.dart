library sector_stats_og;

import 'dart:async';

import 'package:application/src/objects/game_config_og.dart';
import 'package:application/src/objects/news_headline_og.dart';
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
    on<_SelectSector>(_selectSector);
    on<_RemoveSelection>(_removeSelection);
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
        mediaDependency: _clampStat(
          stat.mediaDependency + impact.mediaDependency,
        ),
        trustAi: _clampStat(stat.trustAi + impact.trustAi),
        connectivity: _clampStat(stat.connectivity + impact.connectivity),
      );
    }

    emit(_Ready(stats: updated, selectedSector: current.selectedSector));
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
}
