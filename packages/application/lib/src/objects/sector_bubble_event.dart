part of sector_bubble_og;

sealed class SectorBubbleEvent {
  const SectorBubbleEvent();
}

class _Init extends SectorBubbleEvent {
  const _Init({this.interval});

  final Duration? interval;
}

class _SpawnBubble extends SectorBubbleEvent {
  const _SpawnBubble();
}

class _ClearBubble extends SectorBubbleEvent {
  const _ClearBubble({required this.bubbleId});

  final int bubbleId;
}

class _Pause extends SectorBubbleEvent {
  const _Pause();
}

class _Resume extends SectorBubbleEvent {
  const _Resume();
}

class _Events {
  _Events(this._object);

  final SectorBubbleOg _object;

  void init({Duration? interval}) {
    _object.add(_Init(interval: interval));
  }

  void clearBubble(int bubbleId) {
    _object.add(_ClearBubble(bubbleId: bubbleId));
  }
}
