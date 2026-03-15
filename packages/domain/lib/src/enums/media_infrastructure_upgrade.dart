/// Media Infrastructure upgrades.
/// Controls how quickly AI influence spreads.
enum MediaInfrastructureUpgrade {
  /// AI curates personalized news feeds for users.
  algorithmicFeeds(1000),

  /// Major platforms integrate AI-generated content.
  ///
  /// Lowers criticalThinking stat
  platformIntegration(2500),

  /// AI systems coordinate messaging across media outlets.
  ///
  /// Lowers criticalThinking stat
  globalNewsNetwork(5000),

  /// AI automatically publishes and amplifies stories.
  ///
  ///
  automatedContentDistribution(10000),

  /// AI-controlled media becomes the primary global information source.
  omnipresentFeed(10000);

  const MediaInfrastructureUpgrade(this.cost);

  final int cost;

  String get displayName => switch (this) {
    algorithmicFeeds => 'Algorithmic Feeds',
    platformIntegration => 'Platform Integration',
    globalNewsNetwork => 'Global News Network',
    automatedContentDistribution => 'Automated Content Distribution',
    omnipresentFeed => 'Omnipresent Feed',
  };

  /// Short player-facing description of what this upgrade does.
  String get description => switch (this) {
    algorithmicFeeds => 'Personalized feeds spread influence faster.',
    platformIntegration =>
      'Major platforms integrate AI content; lowers critical thinking.',
    globalNewsNetwork =>
      'AI coordinates messaging across outlets; lowers critical thinking.',
    automatedContentDistribution => 'AI auto-publishes and amplifies stories.',
    omnipresentFeed =>
      'AI-controlled media becomes the primary global information source.',
  };
}
