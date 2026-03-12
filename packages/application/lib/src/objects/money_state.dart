part of money_og;

final class MoneyState extends Equatable {
  const MoneyState({this.amount = 0});

  final int amount;

  @override
  List<Object?> get props => _$props;

  MoneyState change({required int delta}) {
    return MoneyState(amount: max(0, amount + delta));
  }
}
