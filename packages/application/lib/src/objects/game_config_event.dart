part of game_config_og;

sealed class GameConfigEvent {
  const GameConfigEvent();
}

class _AddName extends GameConfigEvent {
  const _AddName({required this.name});

  final String name;
}

class _InfectSector extends GameConfigEvent {
  const _InfectSector({required this.sector});

  final WorldSectors sector;
}

/// Infects the first sector at the given click coordinates. Only processes when
/// [infectedSectors] is empty.
class _InfectFirstSector extends GameConfigEvent {
  const _InfectFirstSector({required this.sector});

  final WorldSectors sector;
}

class _ClearInfectedSectors extends GameConfigEvent {
  const _ClearInfectedSectors();
}

class _Events {
  _Events(this._object);

  final GameConfigOg _object;

  void addName(String name) {
    _object.add(_AddName(name: name));
  }

  void infectSector(WorldSectors sector) {
    _object.add(_InfectSector(sector: sector));
  }

  /// Infects the first sector at the given world coordinates. Only processes
  /// when there are no infected sectors.
  void infectFirstSector(WorldSectors sector) {
    _object.add(_InfectFirstSector(sector: sector));
  }

  void clearInfectedSectors() {
    _object.add(const _ClearInfectedSectors());
  }
}
