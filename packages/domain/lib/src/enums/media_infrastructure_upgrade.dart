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
  omnipresentFeed(25000);

  const MediaInfrastructureUpgrade(this.cost);

  final int cost;

  String get displayName => switch (this) {
    MediaInfrastructureUpgrade.algorithmicFeeds => 'Algorithmic Feeds',
    MediaInfrastructureUpgrade.platformIntegration => 'Platform Integration',
    MediaInfrastructureUpgrade.globalNewsNetwork => 'Global News Network',
    MediaInfrastructureUpgrade.automatedContentDistribution =>
      'Automated Content Distribution',
    MediaInfrastructureUpgrade.omnipresentFeed => 'Omnipresent Feed',
  };
}
