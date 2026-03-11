import 'package:equatable/equatable.dart';

part 'strength_influence.g.dart';

/// Shared model for strength and influence values.
/// Used for both OI (Organic Intelligence) and AI (Artificial Intelligence).
class StrengthInfluence extends Equatable {
  const StrengthInfluence({
    required this.strength,
    required this.influence,
  });

  final double strength;
  final double influence;

  StrengthInfluence copyWith({double? strength, double? influence}) {
    return StrengthInfluence(
      strength: strength ?? this.strength,
      influence: influence ?? this.influence,
    );
  }

  @override
  List<Object?> get props => _$props;
}
