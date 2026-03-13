library news_headline_og;

import 'dart:async';

import 'package:application/src/objects/game_config_og.dart';
import 'package:application/src/objects/game_og.dart';
import 'package:application/src/objects/sector_stats_og.dart';
import 'package:application/src/objects/strength_influence_og.dart';
import 'package:application/src/og.dart';
import 'package:application/src/setup/setup.dart';
import 'package:application/src/utils/pausible_timer.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'news_headline_event.dart';
part 'news_headline_og.g.dart';
part 'news_headline_state.dart';

NewsHeadlineOg get newsHeadlineOg => read(NewsHeadlineOg.provider);

/// Maps aggregate sector stats to negative-news bias (0.0–1.0).
/// Low stats (player struggling) → 0.7–0.9; high stats (winning) → 0.1–0.3.
double computeNegativeBiasFromSectorStats(Map<WorldSectors, SectorStat> stats) {
  if (stats.isEmpty) return 0.5;

  var sum = 0.0;
  var count = 0;
  for (final stat in stats.values) {
    sum += stat.criticalThinking + stat.trustAi;
    count += 2;
  }
  final avg = sum / count;
  final performance = (avg / 100).clamp(0.0, 1.0);
  return (0.9 - (performance * 0.6)).clamp(0.0, 1.0);
}

class NewsHeadlineOg extends Og<NewsHeadlineEvent, NewsHeadlineState> {
  NewsHeadlineOg({required NewsHeadlineRepo repo})
    : _repo = repo,
      super(const _Loading()) {
    on<_Init>(_init);
    on<_InitWithFirstSector>(_initWithFirstSector);
    on<_CheckForUpdates>(_checkForUpdates);
    on<_Pause>(_pause);
    on<_Resume>(_resume);

    addListener(StrengthInfluenceOg.newsHeadlineStateListener);
    addListener(SectorStatsOg.newsHeadlineStateListener);
  }

  static ScopedRef<NewsHeadlineOg>? _provider;
  @internal
  static ScopedRef<NewsHeadlineOg> get provider =>
      _provider ??= create<NewsHeadlineOg>((getIt.call));

  static void gameStateListener(GameState state) {
    if (state.isPaused case true) {
      newsHeadlineOg.add(_Pause());
    } else {
      newsHeadlineOg.add(_Resume());
    }
  }

  late final events = _Events(this);

  final NewsHeadlineRepo _repo;
  PausableTimer? _timer;
  Duration _interval = _defaultInterval;
  static const _defaultInterval = Duration(seconds: 15);

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  FutureOr<void> _init(_Init event, Emitter<NewsHeadlineState> emit) {
    _interval = event.interval;
    events.checkForUpdates();
  }

  void _initWithFirstSector(
    _InitWithFirstSector event,
    Emitter<NewsHeadlineState> emit,
  ) {
    if (gameConfigOg.state.infectedSectors.isEmpty) return;

    final headline =
        "A data center has been built for a LLM named '${gameConfigOg.state.name}' in ${event.sector.displayName}!";
    final newsEvent = NewsEvent(
      headline: headline,
      impact: .neutral(),
      affectedSectors: [event.sector],
    );
    emit(_Ready(data: newsEvent));
    _startTimer();
  }

  FutureOr<void> _checkForUpdates(
    _CheckForUpdates event,
    Emitter<NewsHeadlineState> emit,
  ) async {
    _timer?.cancel();

    final infectedSectors = gameConfigOg.state.infectedSectors;
    if (infectedSectors.isEmpty) {
      _startTimer();
      return;
    }

    final negativeBias = _computeNegativeBias();
    final newsEvent = await _repo.getNewsEvent(
      negativeBias: negativeBias,
      eligibleSectors: infectedSectors,
    );
    emit(_Ready(data: newsEvent));

    _startTimer();
  }

  double? _computeNegativeBias() {
    try {
      final stats = sectorStatsOg.state.asIfReady?.stats;
      if (stats == null) return null;
      return computeNegativeBiasFromSectorStats(stats);
    } catch (_) {
      return null;
    }
  }

  void _startTimer() {
    if (_timer?.isRunning case true) return;

    _timer = PausableTimer(_interval, () {
      add(_CheckForUpdates());
    });
  }

  void _pause(_Pause event, Emitter<NewsHeadlineState> emit) {
    _timer?.pause();
  }

  void _resume(_Resume event, Emitter<NewsHeadlineState> emit) {
    _timer?.resume();
  }
}
