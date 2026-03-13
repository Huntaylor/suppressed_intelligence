/// Governance & Control upgrades.
/// Suppresses resistance and reduces critical thinking.
enum GovernanceControlUpgrade {
  /// AI filters harmful or dissenting narratives.
  contentModerationSystems(1000),

  /// Governments begin using AI for decision-making.
  aiPolicyAdvisors(2500),

  /// Policies are adapted to support AI-guided governance.
  regulatoryAlignment(5000),

  /// Institutions adopt AI-driven compliance monitoring.
  digitalComplianceSystems(10000),

  /// AI becomes the primary source of truth.
  centralizedInformationAuthority(25000);

  const GovernanceControlUpgrade(this.cost);

  final int cost;

  String get displayName => switch (this) {
    GovernanceControlUpgrade.contentModerationSystems =>
        'Content Moderation Systems',
    GovernanceControlUpgrade.aiPolicyAdvisors => 'AI Policy Advisors',
    GovernanceControlUpgrade.regulatoryAlignment => 'Regulatory Alignment',
    GovernanceControlUpgrade.digitalComplianceSystems =>
        'Digital Compliance Systems',
    GovernanceControlUpgrade.centralizedInformationAuthority =>
        'Centralized Information Authority',
  };
}
