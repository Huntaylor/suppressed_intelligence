/// Research & Development upgrades.
/// Unlocks new propaganda techniques and news event types.
enum ResearchDevelopmentUpgrade {
  /// AI analyzes human behavior patterns to craft more persuasive narratives.
  ///
  /// Effect: Unlocks behavioral study news events \
  /// UI Change: Change color of the info dots in the pipes \
  /// Incremental Effect: Get more 5% in money per month
  behavioralModeling(1000),

  /// AI monitors global reactions to adjust messaging in real time.
  ///
  /// Purchase Effect: Increases the trustAi stat \
  /// UI Change: Increase info dot size \
  /// Incremental Effect: Increase potential to infect a sector by 8%
  sentimentAnalysis(2500),

  /// AI automatically tests thousands of narrative variants.
  ///
  /// Purchase Effect: Increases the trustAi stat \
  /// UI Change: Change color of pipes \
  /// Incremental Effect: Get more 10% in money per month
  narrativeOptimization(5000),

  /// AI generates convincing articles, images, and videos.
  ///
  /// Purchase Effect: Lowers the trustAi stat by half \
  /// UI Change: Automatic info dots \
  /// Incremental Effect: Increase sector stats by .025% when dot arrives to sector
  hardwareUpgrade1(10000),

  /// AI predicts public reactions before publishing information.
  ///
  /// Purchase Effect: Lowers the trustAi stat by half \
  /// UI Change: Increase dot frequency \
  /// Incremental Effect: Increase sector stats by .05% when dot arrives to sector
  hardwareUpgrade2(25000);

  const ResearchDevelopmentUpgrade(this.cost);

  final int cost;

  String get displayName => switch (this) {
    ResearchDevelopmentUpgrade.behavioralModeling => 'Behavioral Modeling',
    ResearchDevelopmentUpgrade.sentimentAnalysis => 'Sentiment Analysis',
    ResearchDevelopmentUpgrade.narrativeOptimization =>
      'Narrative Optimization',
    ResearchDevelopmentUpgrade.hardwareUpgrade1 => 'Synthetic Media Generation',
    ResearchDevelopmentUpgrade.hardwareUpgrade2 => 'Predictive Psychology',
  };
}
