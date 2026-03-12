part of money_og;

sealed class MoneyEvent {
  const MoneyEvent();
}

class _AddMoney extends MoneyEvent {
  const _AddMoney({required this.amount});

  final int amount;
}

class _SetMoney extends MoneyEvent {
  const _SetMoney({required this.amount})
    : assert(amount >= 0, 'Amount must be non-negative');

  final int amount;
}

class _RemoveMoney extends MoneyEvent {
  const _RemoveMoney({required this.amount})
    : assert(amount > 0, 'Amount must be positive');

  final int amount;
}

class _Events {
  _Events(this._object);

  final MoneyOg _object;

  void addMoney(int amount) {
    _object.add(_AddMoney(amount: amount));
  }

  void setMoney(int amount) {
    _object.add(_SetMoney(amount: amount));
  }
}
