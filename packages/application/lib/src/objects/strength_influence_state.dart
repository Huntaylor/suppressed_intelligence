part of strength_influence_og;

final class StrengthInfluenceState extends Equatable {
  const StrengthInfluenceState({required this.oi, required this.ai});

  final Map<WorldSectors, double> oi;
  final Map<WorldSectors, double> ai;

  double get overallOi {
    double sum = 0;

    for (final e in WorldSectors.values) {
      sum += oi[e] ?? 0;
    }

    return sum;
  }

  double get overallAi {
    double sum = 0;

    for (final e in WorldSectors.values) {
      sum += ai[e] ?? 0;
    }

    return sum;
  }

  StrengthInfluenceState copywith({
    Map<WorldSectors, double>? oi,
    Map<WorldSectors, double>? ai,
  }) {
    return StrengthInfluenceState(oi: oi ?? this.oi, ai: ai ?? this.ai);
  }

  @override
  List<Object?> get props => _$props;
}
