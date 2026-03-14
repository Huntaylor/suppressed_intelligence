part of upgrades_og;

final class UpgradesState extends Equatable {
  UpgradesState()
    : researchDevelopment = {},
      mediaInfrastructure = {},
      governanceControl = {};

  const UpgradesState._({
    required this.researchDevelopment,
    required this.mediaInfrastructure,
    required this.governanceControl,
  });

  final Set<ResearchDevelopmentUpgrade> researchDevelopment;
  final Set<MediaInfrastructureUpgrade> mediaInfrastructure;
  final Set<GovernanceControlUpgrade> governanceControl;

  bool hasPurchased<T>(T upgrade) {
    return switch (upgrade) {
      ResearchDevelopmentUpgrade() => researchDevelopment.contains(upgrade),
      MediaInfrastructureUpgrade() => mediaInfrastructure.contains(upgrade),
      GovernanceControlUpgrade() => governanceControl.contains(upgrade),
      _ => false,
    };
  }

  UpgradesState purchaseResearchDevelopment(
    ResearchDevelopmentUpgrade upgrade,
  ) {
    return UpgradesState._(
      researchDevelopment: researchDevelopment..add(upgrade),
      mediaInfrastructure: mediaInfrastructure,
      governanceControl: governanceControl,
    );
  }

  UpgradesState purchaseMediaInfrastructure(
    MediaInfrastructureUpgrade upgrade,
  ) {
    return UpgradesState._(
      researchDevelopment: researchDevelopment,
      mediaInfrastructure: mediaInfrastructure..add(upgrade),
      governanceControl: governanceControl,
    );
  }

  UpgradesState purchaseGovernanceControl(GovernanceControlUpgrade upgrade) {
    return UpgradesState._(
      researchDevelopment: researchDevelopment,
      mediaInfrastructure: mediaInfrastructure,
      governanceControl: governanceControl..add(upgrade),
    );
  }

  @override
  List<Object?> get props => _$props;
}
