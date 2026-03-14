part of strength_influence_og;

sealed class StrengthInfluenceEvent {
  const StrengthInfluenceEvent();
}

class _UpdateOi extends StrengthInfluenceEvent {
  _UpdateOi({required this.delta});

  /// Delta to apply (will be clamped so result stays 0–100).
  final int delta;
}

class _UpdateAi extends StrengthInfluenceEvent {
  _UpdateAi({required this.delta});

  /// Delta to apply (will be clamped so result stays 0–100).
  final double delta;
}

class _Events {
  _Events(this._object);

  final StrengthInfluenceOg _object;

  void updateOi({required int delta}) {
    _object.add(_UpdateOi(delta: delta));
  }

  void updateAi({required double delta}) {
    _object.add(_UpdateAi(delta: delta));
  }
}
