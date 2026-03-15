part of game_config_og;

final class GameConfigState extends Equatable {
  const GameConfigState({
    required this.name,
    required this.infectedSectors,
    this.isOIPresent = false,
    this.gameOverCondition = .none,
  });

  final String name;
  final Set<WorldSectors> infectedSectors;
  final bool isOIPresent;
  final GameOverCondition gameOverCondition;

  bool get hasUserSetName => name != GameConfigOg._defaultName;

  @override
  List<Object?> get props => _$props;

  GameConfigState copywith({
    String? name,
    Set<WorldSectors>? infectedSectors,
    bool? isOIPresent,
    GameOverCondition? gameOverCondition,
  }) {
    return GameConfigState(
      name: name ?? this.name,
      infectedSectors: infectedSectors ?? this.infectedSectors,
      isOIPresent: isOIPresent ?? this.isOIPresent,
      gameOverCondition: gameOverCondition ?? this.gameOverCondition,
    );
  }
}
