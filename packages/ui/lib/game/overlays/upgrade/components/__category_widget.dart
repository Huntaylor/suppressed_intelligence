part of upgrade_overlay;

/// When false, Media Infrastructure category is hidden on the upgrade page.
const bool _showMediaInfrastructureCategory = false;

/// When false, Governance & Control category is hidden on the upgrade page.
const bool _showGovernanceControlCategory = false;

class _UpgradeCategoryWidget extends StatefulWidget {
  const _UpgradeCategoryWidget();

  @override
  State<_UpgradeCategoryWidget> createState() => _UpgradeCategoryWidgetState();
}

class _UpgradeCategoryWidgetState extends State<_UpgradeCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _UpgradeSection<ResearchDevelopmentUpgrade>(
          title: 'Research & Development',
          name: (upgrade) => upgrade.displayName,
          cost: (upgrade) => upgrade.cost,
          firstUpgrade: .behavioralModeling,
          secondUpgrade: .sentimentAnalysis,
          thirdUpgrade: .narrativeOptimization,
          fourthUpgrade: .hardwareUpgrade1,
          fifthUpgrade: .hardwareUpgrade2,
        ),
        if (_showMediaInfrastructureCategory) ...[
          const VerticalDivider(indent: 32, endIndent: 8),
          _UpgradeSection<MediaInfrastructureUpgrade>(
            title: 'Media Infrastructure',
            name: (upgrade) => upgrade.displayName,
            cost: (upgrade) => upgrade.cost,
            firstUpgrade: .algorithmicFeeds,
            secondUpgrade: .platformIntegration,
            thirdUpgrade: .globalNewsNetwork,
            fourthUpgrade: .automatedContentDistribution,
            fifthUpgrade: .omnipresentFeed,
          ),
        ],
        if (_showGovernanceControlCategory) ...[
          const VerticalDivider(indent: 32, endIndent: 8),
          _UpgradeSection<GovernanceControlUpgrade>(
            title: 'Governance & Control',
            name: (upgrade) => upgrade.displayName,
            cost: (upgrade) => upgrade.cost,
            firstUpgrade: .contentModerationSystems,
            secondUpgrade: .aiPolicyAdvisors,
            thirdUpgrade: .regulatoryAlignment,
            fourthUpgrade: .digitalComplianceSystems,
            fifthUpgrade: .centralizedInformationAuthority,
          ),
        ],
      ],
    );
  }
}
