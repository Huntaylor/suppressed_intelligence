part of strength_influence_og;

sealed class StrengthInfluenceEvent {
  const StrengthInfluenceEvent();
}

class _UpdateOi extends StrengthInfluenceEvent {
  _UpdateOi({required this.sector, required double delta}) {
    delta = double.parse(delta.toStringAsFixed(2));
  }

  final WorldSectors sector;
  late final double delta;
}

class _UpdateAi extends StrengthInfluenceEvent {
  const _UpdateAi({required this.sector, required this.delta});

  final WorldSectors sector;
  final double delta;
}

class _Events {
  _Events(this._object);

  final StrengthInfluenceOg _object;

  void updateOi({required WorldSectors sector, required double delta}) {
    _object.add(_UpdateOi(sector: sector, delta: delta));
  }

  void updateAi({required WorldSectors sector, required double delta}) {
    _object.add(_UpdateAi(sector: sector, delta: delta));
  }
}
