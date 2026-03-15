// ignore_for_file: library_private_types_in_public_api

part of game_og;

final class TutorialState extends Equatable {
  const TutorialState({
    this.enabledTutorial = false,
    this.tutorialStep = 0,
    this.shouldShowWindow = false,
  });

  final bool enabledTutorial;

  final bool shouldShowWindow;

  final int tutorialStep;

  List<String> get tutorialStrings => [
    'Before the game begins, you pick a sector — this is your foothold.\n\nTap any sector on the map to get started',
    'AI bubbles appear in your active sectors. Tap them to trigger an integration attempt on connected sectors. Success is chance-based — your upgrades improve those odds.\n\nEach successful integration adds a new sector to your network.',
    'Tapping a sector opens its detail panel at the bottom of the screen. Each sector has its own AI dependency stat — the average across all sectors makes up the global AI dependency % you need to reach 100%.',
    "You generate cash every month automatically. Upgrades improve your integration chances and sector stats — but you can only purchase one when you have enough cash.",
    "The scrolling news banner at the top affects all your active sectors each cycle. For-AI headlines boost your stats, against-AI headlines reduce them. Neutral news does nothing. Adapt your strategy to the current headline.",
    "Once global AI dependency reaches 20%, an opposing force enters the game. You are now in a race to 100%.",
    "Integrate every sector. Spend your monthly cash on upgrades, react to the news, and outpace the enemy once they emerge at 20%. Good luck.",
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
