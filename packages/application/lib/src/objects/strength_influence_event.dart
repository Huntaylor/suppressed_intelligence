part of strength_influence_og;

sealed class StrengthInfluenceEvent {
  const StrengthInfluenceEvent();
}

class _UpdateOi extends StrengthInfluenceEvent {
  const _UpdateOi({this.strength, this.influence});

  final double? strength;
  final double? influence;
}

class _UpdateAi extends StrengthInfluenceEvent {
  const _UpdateAi({this.strength, this.influence});

  final double? strength;
  final double? influence;
}

class _Events {
  _Events(this._object);

  final StrengthInfluenceOg _object;

  void updateOi({double? strength, double? influence}) {
    _object.add(_UpdateOi(strength: strength, influence: influence));
  }

  void updateAi({double? strength, double? influence}) {
    _object.add(_UpdateAi(strength: strength, influence: influence));
  }
}
