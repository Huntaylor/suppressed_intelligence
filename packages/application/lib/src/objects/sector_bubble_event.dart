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

/// Spawns the first AI bubble at the given world coordinates. Only processes
/// when [infectedSectors] is empty.
class _SpawnFirstBubble extends SectorBubbleEvent {
  const _SpawnFirstBubble({
    required this.sector,
    required this.x,
    required this.y,
  });

  final WorldSectors sector;
  final double x;
  final double y;
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

  void spawnFirstBubble(WorldSectors sector, {required double x, required double y}) {
    _object.add(_SpawnFirstBubble(sector: sector, x: x, y: y));
  }

  void clearBubble(int bubbleId) {
    _object.add(_ClearBubble(bubbleId: bubbleId));
  }
}
