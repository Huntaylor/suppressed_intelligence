part of game_config_og;

final class GameConfigState extends Equatable {
  const GameConfigState({required this.name});

  final String name;

  @override
  List<Object?> get props => _$props;
}
