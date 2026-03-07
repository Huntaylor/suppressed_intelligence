// ignore_for_file: library_private_types_in_public_api

part of game_og;

sealed class GameState extends Equatable {
  const GameState();

  bool get isLoading => this is _Loading;
  _Loading? get asIfLoading => switch (this) {
    final _Loading state => state,
    _ => null,
  };

  bool get isPaused => this is _Paused;
  _Paused? get asIfPaused => switch (this) {
    final _Paused state => state,
    _ => null,
  };

  bool get isPlaying => this is _Playing;
  _Playing? get asIfPlaying => switch (this) {
    final _Playing state => state,
    _ => null,
  };

  @override
  List<Object?> get props => [];
}

class _Loading extends GameState {
  const _Loading();
}

class _Paused extends GameState {
  const _Paused();
}

class _Playing extends GameState {
  const _Playing();
}
