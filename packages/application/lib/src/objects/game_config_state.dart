part of game_config_og;

final class GameConfigState extends Equatable {
  const GameConfigState({required this.name, required this.infectedSectors});

  final String name;
  final Set<WorldSectors> infectedSectors;

  bool get hasUserSetName => name != GameConfigOg._defaultName;

  @override
  List<Object?> get props => _$props;

  GameConfigState copywith({String? name, Set<WorldSectors>? infectedSectors}) {
    return GameConfigState(
      name: name ?? this.name,
      infectedSectors: infectedSectors ?? this.infectedSectors,
    );
  }
}
