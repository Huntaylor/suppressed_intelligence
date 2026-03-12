library money_og;

import 'dart:async';
import 'dart:math';

import 'package:application/src/og.dart';
import 'package:application/src/setup/setup.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'money_event.dart';
part 'money_og.g.dart';
part 'money_state.dart';

MoneyOg get moneyOg => read(MoneyOg.provider);

class MoneyOg extends Og<MoneyEvent, MoneyState> {
  MoneyOg() : super(const MoneyState()) {
    on<_AddMoney>(_addMoney);
    on<_SetMoney>(_setMoney);
    on<_RemoveMoney>(_removeMoney);
  }

  static ScopedRef<MoneyOg>? _provider;
  @internal
  static ScopedRef<MoneyOg> get provider =>
      _provider ??= create<MoneyOg>((getIt.call));

  late final events = _Events(this);

  FutureOr<void> _addMoney(_AddMoney event, Emitter<MoneyState> emit) {
    emit(state.change(delta: event.amount));
  }

  FutureOr<void> _removeMoney(_RemoveMoney event, Emitter<MoneyState> emit) {
    emit(state.change(delta: -event.amount));
  }

  FutureOr<void> _setMoney(_SetMoney event, Emitter<MoneyState> emit) {
    emit(MoneyState(amount: event.amount));
  }
}
