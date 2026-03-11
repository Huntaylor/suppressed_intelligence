library news_headline_og;

import 'dart:async';

import 'package:application/src/objects/sector_stats_og.dart';
import 'package:application/src/og.dart';
import 'package:application/src/setup/setup.dart';
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
    sum +=
        stat.criticalThinking +
        stat.mediaDependency +
        stat.trustAi +
        stat.connectivity;
    count += 4;
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
    on<_CheckForUpdates>(_checkForUpdates);
  }

  static ScopedRef<NewsHeadlineOg>? _provider;
  @internal
  static ScopedRef<NewsHeadlineOg> get provider =>
      _provider ??= create<NewsHeadlineOg>((getIt.call));

  late final events = _Events(this);

  final NewsHeadlineRepo _repo;
  Timer? _timer;
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

  FutureOr<void> _checkForUpdates(
    _CheckForUpdates event,
    Emitter<NewsHeadlineState> emit,
  ) async {
    _timer?.cancel();

    final negativeBias = _computeNegativeBias();
    final newsEvent = await _repo.getNewsEvent(negativeBias: negativeBias);
    emit(_Ready(data: newsEvent));

    _startTimer();
  }

  double? _computeNegativeBias() {
    try {
      final sectorOg = sectorStatsOg;
      final state = sectorOg.state;
      if (!state.isReady) return null;
      final stats = state.asIfReady!.stats;
      return computeNegativeBiasFromSectorStats(stats);
    } catch (_) {
      return null;
    }
  }

  void _startTimer() {
    if (_timer?.isActive case true) return;

    _timer = Timer.periodic(_interval, (timer) {
      add(_CheckForUpdates());
    });
  }
}
