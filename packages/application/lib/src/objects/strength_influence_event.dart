part of strength_influence_og;

sealed class StrengthInfluenceEvent {
  const StrengthInfluenceEvent();
}

class _UpdateOi extends StrengthInfluenceEvent {
  _UpdateOi({required this.sector, required this.delta});

  final WorldSectors sector;
  /// Delta to apply (will be clamped so result stays 0–100).
  final int delta;
}

class _UpdateAi extends StrengthInfluenceEvent {
  _UpdateAi({required this.sector, required this.delta});

  final WorldSectors sector;
  /// Delta to apply (will be clamped so result stays 0–100).
  final int delta;
}

class _Events {
  _Events(this._object);

  final StrengthInfluenceOg _object;

  void updateOi({required WorldSectors sector, required int delta}) {
    _object.add(_UpdateOi(sector: sector, delta: delta));
  }

  void updateAi({required WorldSectors sector, required int delta}) {
    _object.add(_UpdateAi(sector: sector, delta: delta));
  }
}
