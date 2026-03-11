part of strength_influence_og;

final class StrengthInfluenceState extends Equatable {
  const StrengthInfluenceState({required this.oi, required this.ai});

  final Map<WorldSectors, double> oi;
  final Map<WorldSectors, double> ai;

  double oiForSector(WorldSectors sector) =>
      oi[sector] ?? (throw Exception('OI for sector $sector not found'));
  double aiForSector(WorldSectors sector) =>
      ai[sector] ?? (throw Exception('AI for sector $sector not found'));

  double get overallOi {
    return oi.values.reduce((a, b) => a + b);
  }

  double get overallAi {
    return ai.values.reduce((a, b) => a + b);
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
