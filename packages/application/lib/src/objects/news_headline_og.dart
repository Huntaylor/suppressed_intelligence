library news_headline_og;

import 'dart:async';

import 'package:application/setup.dart';
import 'package:application/src/og.dart';
import 'package:data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'news_headline_event.dart';
part 'news_headline_og.g.dart';
part 'news_headline_state.dart';

final newsHeadlineOgProvider = create<NewsHeadlineOg>((getIt.call()));
NewsHeadlineOg get newsHeadlineOg => read(newsHeadlineOgProvider);

class NewsHeadlineOg extends Og<NewsHeadlineEvent, NewsHeadlineState> {
  NewsHeadlineOg({required NewsHeadlineRepo repo})
    : _repo = repo,
      super(const _Loading()) {
    on<_Init>(_init);
    on<_CheckForUpdates>(_checkForUpdates);
  }

  late final events = _Events(this);

  final NewsHeadlineRepo _repo;
  Timer? _timer;
  Duration _interval = const Duration(minutes: 1);

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  FutureOr<void> _init(_Init event, Emitter<NewsHeadlineState> emit) {
    _interval = event.interval;
    _startTimer();
  }

  FutureOr<void> _checkForUpdates(
    _CheckForUpdates event,
    Emitter<NewsHeadlineState> emit,
  ) async {
    _timer?.cancel();

    final headline = await _repo.getHeadline();
    emit(_Ready(headline: headline));

    _startTimer();
  }

  void _startTimer() {
    if (_timer?.isActive case true) return;

    _timer = Timer.periodic(_interval, (timer) {
      add(_CheckForUpdates());
    });
  }
}
