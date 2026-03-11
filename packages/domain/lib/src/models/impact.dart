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

  /// Scale factor for converting stat deltas to strength influence (AI/OI).
  ///
  /// Example values from profiles:
  /// - warning (trustAi: -3, mediaDependency: 5, criticalThinking: 2) → deltaForAi: -0.01, deltaForOi: +0.04
  /// - positiveStudy (trustAi: 4, mediaDependency: 0, criticalThinking: -2) → deltaForAi: +0.08, deltaForOi: -0.04
  /// - regulation (trustAi: -1, mediaDependency: 2, criticalThinking: 1) → deltaForAi: 0.0, deltaForOi: +0.02
  /// - informational (trustAi: 0, mediaDependency: 1, criticalThinking: 0) → deltaForAi: +0.01, deltaForOi: 0.0
  static const double _deltaScale = 0.02;
  static const double _mediaDependencyScale = 0.01;

  /// Whether this impact affects AI strength (trustAi ≠ 0 or mediaDependency ≠ 0).
  bool get impactsAi => trustAi != 0 || mediaDependency != 0;

  /// Small delta to apply to AI strength. [trustAi] is primary; [mediaDependency] adds
  /// a secondary boost (more media reliance → more exposure to AI-mediated content).
  double get deltaForAi => trustAi * _deltaScale + mediaDependency * _mediaDependencyScale;

  /// Whether this impact affects OI strength (criticalThinking ≠ 0).
  bool get impactsOi => criticalThinking != 0;

  /// Small delta to apply to OI strength. Positive [criticalThinking] increases OI influence.
  double get deltaForOi => criticalThinking * _deltaScale;

  @override
  List<Object?> get props => _$props;
}
