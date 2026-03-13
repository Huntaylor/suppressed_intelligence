part of info_dots_og;

sealed class InfoDotsEvent {
  const InfoDotsEvent();
}

class _SpawnInfoDot extends InfoDotsEvent {
  const _SpawnInfoDot({required this.dot, required this.pipe});

  final PipeDot dot;
  final Pipe pipe;
}

class _DropInfoDot extends InfoDotsEvent {
  const _DropInfoDot({required this.dot});

  final InfoDot dot;
}

class _Events {
  _Events(this._object);

  final InfoDotsOg _object;

  void dropInfoDot(InfoDot dot) {
    _object.add(_DropInfoDot(dot: dot));
  }
}
