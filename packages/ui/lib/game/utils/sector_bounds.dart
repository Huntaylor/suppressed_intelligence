import 'dart:math';

import 'package:domain/domain.dart';
import 'package:flame/components.dart';

/// Center position and size for each sector on the world map.
/// Matches [SectorComponent] layout (anchor: center).
final _sectorLayout = {
  WorldSectors.na: (Vector2(216.0, 177.0), Vector2(338.0, 344.0)),
  WorldSectors.sa: (Vector2(283.0, 423.0), Vector2(102.0, 172.0)),
  WorldSectors.eu: (Vector2(507.5, 182.5), Vector2(215.0, 133.0)),
  WorldSectors.as: (Vector2(705.5, 219.0), Vector2(401.0, 304.0)),
  WorldSectors.af: (Vector2(497.0, 327.0), Vector2(160.0, 172.0)),
  WorldSectors.oc: (Vector2(847.0, 420.5), Vector2(196.0, 157.0)),
};

/// Returns a random position within the given sector's bounds.
Vector2 randomPositionInSector(WorldSectors sector, Random random) {
  final (center, size) = _sectorLayout[sector]!;
  final left = center.x - size.x / 2;
  final top = center.y - size.y / 2;
  return Vector2(
    left + random.nextDouble() * size.x,
    top + random.nextDouble() * size.y,
  );
}
