part of game_time_og;

final class GameTimeState extends Equatable {
  const GameTimeState({
    required this.month,
    required this.year,
  });

  final int month;
  final int year;

  @override
  List<Object?> get props => _$props;

  GameTimeState copywith({int? month, int? year}) {
    return GameTimeState(
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }
}
