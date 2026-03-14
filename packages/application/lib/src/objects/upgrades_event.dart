part of upgrades_og;

sealed class UpgradesEvent {
  const UpgradesEvent();
}

class _PurchaseResearchDevelopment extends UpgradesEvent {
  const _PurchaseResearchDevelopment({required this.upgrade});

  final ResearchDevelopmentUpgrade upgrade;
}

class _PurchaseMediaInfrastructure extends UpgradesEvent {
  const _PurchaseMediaInfrastructure({required this.upgrade});

  final MediaInfrastructureUpgrade upgrade;
}

class _PurchaseGovernanceControl extends UpgradesEvent {
  const _PurchaseGovernanceControl({required this.upgrade});

  final GovernanceControlUpgrade upgrade;
}

class _Events {
  _Events(this._object);

  final UpgradesOg _object;

  void purchaseResearchDevelopment(ResearchDevelopmentUpgrade upgrade) {
    _object.add(_PurchaseResearchDevelopment(upgrade: upgrade));
  }

  void purchaseMediaInfrastructure(MediaInfrastructureUpgrade upgrade) {
    _object.add(_PurchaseMediaInfrastructure(upgrade: upgrade));
  }

  void purchaseGovernanceControl(GovernanceControlUpgrade upgrade) {
    _object.add(_PurchaseGovernanceControl(upgrade: upgrade));
  }

  void purchase<T>(T upgrade) {
    switch (upgrade) {
      case ResearchDevelopmentUpgrade():
        _object.add(_PurchaseResearchDevelopment(upgrade: upgrade));
      case MediaInfrastructureUpgrade():
        _object.add(_PurchaseMediaInfrastructure(upgrade: upgrade));
      case GovernanceControlUpgrade():
        _object.add(_PurchaseGovernanceControl(upgrade: upgrade));
      case final other:
        throw UnimplementedError('No purchase handler for $other');
    }
  }
}
