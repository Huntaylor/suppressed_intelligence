part of strength_influence_og;

final class StrengthInfluenceState extends Equatable {
  const StrengthInfluenceState({required this.oi, required this.ai});

  /// OI (organic intelligence) strength for the whole map, 0–100.
  final int oi;
  /// AI strength per sector, 0–100.
  final Map<WorldSectors, int> ai;

  int get overallAi {
    var sum = 0;

    for (final e in WorldSectors.values) {
      sum += ai[e] ?? 0;
    }

    return sum;
  }

  StrengthInfluenceState copywith({
    int? oi,
    Map<WorldSectors, int>? ai,
  }) {
    return StrengthInfluenceState(oi: oi ?? this.oi, ai: ai ?? this.ai);
  }

  @override
  List<Object?> get props => _$props;
}
