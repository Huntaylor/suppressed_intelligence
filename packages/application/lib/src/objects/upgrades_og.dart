library upgrades_og;

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'upgrades_event.dart';
part 'upgrades_og.g.dart';
part 'upgrades_state.dart';

UpgradesOg get upgradesOg => read(UpgradesOg.provider);

class UpgradesOg extends Og<UpgradesEvent, UpgradesState> {
  UpgradesOg() : super(UpgradesState()) {
    on<_PurchaseResearchDevelopment>(_purchaseResearchDevelopment);
    on<_PurchaseMediaInfrastructure>(_purchaseMediaInfrastructure);
    on<_PurchaseGovernanceControl>(_purchaseGovernanceControl);

    addListener(InfoDotsOg.onUpgradesStateChanged);
  }

  static ScopedRef<UpgradesOg>? _provider;
  @internal
  static ScopedRef<UpgradesOg> get provider =>
      _provider ??= create<UpgradesOg>((getIt.call));

  late final events = _Events(this);

  void _purchaseResearchDevelopment(
    _PurchaseResearchDevelopment event,
    Emitter<UpgradesState> emit,
  ) {
    if (moneyOg.state.amount < event.upgrade.cost) return;

    moneyOg.events.removeMoney(event.upgrade.cost);
    emit(state.purchaseResearchDevelopment(event.upgrade));

    if (event.upgrade == ResearchDevelopmentUpgrade.narrativeOptimization) {
      sectorStatsOg.events.applyTrustAiBonus(6);
    }
    if (event.upgrade == ResearchDevelopmentUpgrade.hardwareUpgrade1 ||
        event.upgrade == ResearchDevelopmentUpgrade.hardwareUpgrade2) {
      sectorStatsOg.events.resetReceivedInfoDots();
    }
  }

  void _purchaseMediaInfrastructure(
    _PurchaseMediaInfrastructure event,
    Emitter<UpgradesState> emit,
  ) {
    if (moneyOg.state.amount < event.upgrade.cost) return;

    moneyOg.events.removeMoney(event.upgrade.cost);
    emit(state.purchaseMediaInfrastructure(event.upgrade));
  }

  void _purchaseGovernanceControl(
    _PurchaseGovernanceControl event,
    Emitter<UpgradesState> emit,
  ) {
    if (moneyOg.state.amount < event.upgrade.cost) return;

    moneyOg.events.removeMoney(event.upgrade.cost);
    emit(state.purchaseGovernanceControl(event.upgrade));
  }
}
