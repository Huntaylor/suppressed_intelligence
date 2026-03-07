import 'package:equatable/equatable.dart';

part 'stat.g.dart';

/// Holds the four core stat values: mediaDependency, trustAi, criticalThinking, connectivity.
class Stat extends Equatable {
  const Stat({
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
