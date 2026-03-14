library money_og;

import 'dart:async';
import 'dart:math';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
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

  static const _incomePerMonth = 100;
  static const _incomePerMonthBehavioralModelingBonusPercent = 5;
  static const _incomePerMonthNarrativeOptimizationBonusPercent = 10;
  static const _incomePerAiBubble = 25;

  static void sectorBubbleStateListener(SectorBubbleState state) {
    final clicked = state.asIfClickedBubble?.bubble;
    if (clicked == null || clicked.type != SectorBubbleType.ai) return;
    moneyOg.events.addMoney(_incomePerAiBubble);
  }

  static void gameTimeListener(GameTimeState state) {
    final hasBehavioralModeling = upgradesOg.state.hasPurchased(
      ResearchDevelopmentUpgrade.behavioralModeling,
    );
    final hasNarrativeOptimization = upgradesOg.state.hasPurchased(
      ResearchDevelopmentUpgrade.narrativeOptimization,
    );

    // dart format off
    final income = switch ((hasBehavioralModeling, hasNarrativeOptimization)) {
      (true, true) => _incomePerMonth +
          (_incomePerMonth * _incomePerMonthBehavioralModelingBonusPercent / 100).round() +
          (_incomePerMonth * _incomePerMonthNarrativeOptimizationBonusPercent / 100).round(),
      (true, false) => _incomePerMonth +
          (_incomePerMonth * _incomePerMonthBehavioralModelingBonusPercent / 100).round(),
      (false, true) => _incomePerMonth +
          (_incomePerMonth * _incomePerMonthNarrativeOptimizationBonusPercent / 100).round(),
      (false, false) => _incomePerMonth,
    };
    // dart format on

    moneyOg.events.addMoney(income);
  }

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
