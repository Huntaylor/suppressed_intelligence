import 'package:equatable/equatable.dart';

part 'impact.g.dart';

/// Modifies [Stat] values (e.g. deltas to apply to trustAi, criticalThinking).
class Impact extends Equatable {
  const Impact({required this.trustAi, required this.criticalThinking});

  const Impact.neutral() : trustAi = 0, criticalThinking = 0;

  final int trustAi;
  final int criticalThinking;

  /// Scale factor for converting stat deltas to strength influence (AI), 0–100.
  static const int _deltaScale = 2;

  /// Whether this impact affects AI strength (trustAi ≠ 0).
  bool get impactsAi => trustAi != 0;

  /// Delta to apply to AI strength (0–100 scale).
  int get deltaForAi => trustAi * _deltaScale;

  /// Whether this impact affects OI strength (criticalThinking ≠ 0).
  bool get impactsOi => criticalThinking != 0;

  /// Delta to apply to OI strength (0–100 scale). Positive [criticalThinking] increases OI influence.
  int get deltaForOi => criticalThinking.clamp(1, 3);

  @override
  List<Object?> get props => _$props;
}
