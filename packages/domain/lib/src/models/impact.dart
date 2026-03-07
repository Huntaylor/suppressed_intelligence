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

  @override
  List<Object?> get props => _$props;
}
