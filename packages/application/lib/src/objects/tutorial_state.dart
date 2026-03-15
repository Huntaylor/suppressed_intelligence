// ignore_for_file: library_private_types_in_public_api

part of game_og;

final class TutorialState extends Equatable {
  const TutorialState({
    this.enabledTutorial = true,
    this.tutorialStep = 0,
    this.shouldShowWindow = false,
  });

  final bool enabledTutorial;

  final bool shouldShowWindow;

  final int tutorialStep;

  List<String> get tutorialStrings => [
    'Before the game begins, you pick a sector —\nthis is your foothold.\n\nTap any sector on the map to get started.',
    'AI bubbles appear in your active sectors.\nTap them to trigger an integration attempt\non connected sectors. Success is chance-based —\nyour upgrades improve those odds.\n\nEach successful integration adds a new sector\nto your network.',
    'Tapping a sector opens its detail panel\nat the bottom of the screen. Each sector has its own\nAI dependency stat — the average across all sectors\nmakes up the global AI dependency % you need to reach 100%.',
    'You generate cash every month automatically.\nUpgrades improve your integration chances and sector stats —\nbut you can only purchase one when you have enough cash.',
    'The scrolling news banner at the top affects\nall your active sectors each cycle. For-AI headlines\nboost your stats, against-AI headlines reduce them.\nNeutral news does nothing. Adapt your strategy\nto the current headline.',
    'Once global AI dependency reaches 20%,\nan opposing force enters the game.\nYou are now in a race to 100%.',
    'Integrate every sector. Spend your monthly cash\non upgrades, react to the news, and outpace the enemy\nonce they emerge at 20%. Good luck.',
  ];

  TutorialState copywith({
    int? tutorialStep,
    bool? enabledTutorial,
    bool? shouldShowWindow,
  }) {
    return TutorialState(
      tutorialStep: tutorialStep ?? this.tutorialStep,
      enabledTutorial: enabledTutorial ?? this.enabledTutorial,
      shouldShowWindow: shouldShowWindow ?? this.shouldShowWindow,
    );
  }

  @override
  List<Object?> get props => _$props;
}
