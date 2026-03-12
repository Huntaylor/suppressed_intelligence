import 'package:domain/src/enums/sector_bubble_type.dart';
import 'package:domain/src/enums/world_sectors.dart';
import 'package:equatable/equatable.dart';

part 'sector_bubble.g.dart';

final class SectorBubble extends Equatable {
  SectorBubble({required this.sector, required this.type, this.position})
    : id = _nextId++;

  static int _nextId = 0;

  final int id;
  final WorldSectors sector;
  final SectorBubbleType type;

  /// When set, the bubble is placed at this world position (e.g. for first-sector
  /// infection at click location). Otherwise placement is randomised.
  final ({double x, double y})? position;

  @override
  List<Object?> get props => _$props;
}
