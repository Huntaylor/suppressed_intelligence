part of strength_influence_og;

final class StrengthInfluenceState extends Equatable {
  const StrengthInfluenceState({
    required this.oi,
    required this.ai,
  });

  final StrengthInfluence oi;
  final StrengthInfluence ai;

  @override
  List<Object?> get props => _$props;

  StrengthInfluenceState copywith({
    StrengthInfluence? oi,
    StrengthInfluence? ai,
  }) {
    return StrengthInfluenceState(
      oi: oi ?? this.oi,
      ai: ai ?? this.ai,
    );
  }
}
