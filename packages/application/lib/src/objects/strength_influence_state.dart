part of strength_influence_og;

final class StrengthInfluenceState extends Equatable {
  const StrengthInfluenceState({required this.oi, required this.overallAi});

  /// OI (organic intelligence) strength for the whole map, 0–100.
  final int oi;

  /// AI strength per sector, 0–100.
  final double overallAi;

  StrengthInfluenceState copywith({int? oi, double? overallAi}) {
    return StrengthInfluenceState(
      oi: oi ?? this.oi,
      overallAi: overallAi ?? this.overallAi,
    );
  }

  @override
  List<Object?> get props => _$props;
}
