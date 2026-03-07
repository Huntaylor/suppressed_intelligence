// ignore_for_file: library_private_types_in_public_api

part of game_og;

sealed class GameState extends Equatable {
  const GameState();

  bool get isLoading => this is _Loading;
  _Loading? get asIfLoading => switch (this) {
    final _Loading state => state,
    _ => null,
  };

  bool get isReady => this is _Ready;
  _Ready? get asIfReady => switch (this) {
    final _Ready state => state,
    _ => null,
  };

  @override
  List<Object?> get props => [];
}

class _Loading extends GameState {
  const _Loading();
}

class _Ready extends GameState {
  const _Ready({required this.score});

  final int score;

  @override
  List<Object?> get props => _$props;
}
