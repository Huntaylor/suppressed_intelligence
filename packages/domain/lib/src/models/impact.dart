import 'package:equatable/equatable.dart';

part 'impact.g.dart';

/// Modifies [Stat] values (e.g. deltas to apply to mediaDependency, trustAi, criticalThinking, connectivity).
class Impact extends Equatable {
  const Impact({
    required this.mediaDependency,
    required this.trustAi,
    required this.criticalThinking,
    required this.connectivity,
  });

  final int mediaDependency;
  final int trustAi;
  final int criticalThinking;
  final int connectivity;

  /// Scale factor for converting stat deltas to strength influence (AI/OI), 0–100.
  ///
  /// Example values from profiles:
  /// - warning (trustAi: -3, mediaDependency: 5, criticalThinking: 2) → deltaForAi: -1, deltaForOi: +4
  /// - positiveStudy (trustAi: 4, mediaDependency: 0, criticalThinking: -2) → deltaForAi: +8, deltaForOi: -4
  /// - regulation (trustAi: -1, mediaDependency: 2, criticalThinking: 1) → deltaForAi: 0, deltaForOi: +2
  /// - informational (trustAi: 0, mediaDependency: 1, criticalThinking: 0) → deltaForAi: +1, deltaForOi: 0
  static const int _deltaScale = 2;
  static const int _mediaDependencyScale = 1;

  /// Whether this impact affects AI strength (trustAi ≠ 0 or mediaDependency ≠ 0).
  bool get impactsAi => trustAi != 0 || mediaDependency != 0;

  /// Delta to apply to AI strength (0–100 scale). [trustAi] is primary; [mediaDependency] adds
  /// a secondary boost (more media reliance → more exposure to AI-mediated content).
  int get deltaForAi => trustAi * _deltaScale + mediaDependency * _mediaDependencyScale;

  /// Whether this impact affects OI strength (criticalThinking ≠ 0).
  bool get impactsOi => criticalThinking != 0;

  /// Delta to apply to OI strength (0–100 scale). Positive [criticalThinking] increases OI influence.
  int get deltaForOi => criticalThinking * _deltaScale;

  @override
  List<Object?> get props => _$props;
}
