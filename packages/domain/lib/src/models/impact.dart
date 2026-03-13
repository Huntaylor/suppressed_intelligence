import 'package:equatable/equatable.dart';

part 'impact.g.dart';

/// Modifies [Stat] values (e.g. deltas to apply to trustAi, criticalThinking).
class Impact extends Equatable {
  const Impact({
    required this.trustAi,
    required this.criticalThinking,
  });

  const Impact.neutral()
    : trustAi = 0,
      criticalThinking = 0;

  final int trustAi;
  final int criticalThinking;

  /// Scale factor for converting stat deltas to strength influence (AI/OI), 0–100.
  ///
  /// Example values from profiles:
  /// - warning (trustAi: -3, criticalThinking: 2) → deltaForAi: -6, deltaForOi: +4
  /// - positiveStudy (trustAi: 4, criticalThinking: -2) → deltaForAi: +8, deltaForOi: -4
  /// - regulation (trustAi: -1, criticalThinking: 1) → deltaForAi: -2, deltaForOi: +2
  /// - informational (trustAi: 0, criticalThinking: 0) → deltaForAi: 0, deltaForOi: 0
  static const int _deltaScale = 2;

  /// Whether this impact affects AI strength (trustAi ≠ 0).
  bool get impactsAi => trustAi != 0;

  /// Delta to apply to AI strength (0–100 scale).
  int get deltaForAi => trustAi * _deltaScale;

  /// Whether this impact affects OI strength (criticalThinking ≠ 0).
  bool get impactsOi => criticalThinking != 0;

  /// Delta to apply to OI strength (0–100 scale). Positive [criticalThinking] increases OI influence.
  int get deltaForOi => criticalThinking * _deltaScale;

  @override
  List<Object?> get props => _$props;
}
