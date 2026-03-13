library info_dots_og;

import 'dart:async';

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
  }

  static void sectorBubbleStateListener(SectorBubbleState state) {
    final spawned = state.asIfClickedBubble?.bubble;
    if (spawned == null) return;

    if (spawned.type != SectorBubbleType.ai) return;

    final pipes = Pipe.allBySector(spawned.sector, includeEnd: false);

    for (final pipe in pipes) {
      infoDotsOg.add(_SpawnInfoDot(dot: pipe.start, pipe: pipe));
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
          InfoDot(dot: event.dot, pipe: event.pipe),
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
}
