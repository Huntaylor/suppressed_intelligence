part of strength_influence_og;

sealed class StrengthInfluenceEvent {
  const StrengthInfluenceEvent();
}

class _UpdateOi extends StrengthInfluenceEvent {
  const _UpdateOi({required this.sector, this.strength, this.influence});

  final WorldSectors sector;
  final double? strength;
  final double? influence;
}

class _UpdateAi extends StrengthInfluenceEvent {
  const _UpdateAi({required this.sector, this.strength, this.influence});

  final WorldSectors sector;
  final double? strength;
  final double? influence;
}

class _Events {
  _Events(this._object);

  final StrengthInfluenceOg _object;

  void updateOi({
    required WorldSectors sector,
    double? strength,
    double? influence,
  }) {
    _object.add(
      _UpdateOi(sector: sector, strength: strength, influence: influence),
    );
  }

  void updateAi({
    required WorldSectors sector,
    double? strength,
    double? influence,
  }) {
    _object.add(
      _UpdateAi(sector: sector, strength: strength, influence: influence),
    );
  }
}
