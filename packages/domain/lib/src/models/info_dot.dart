import 'package:domain/src/enums/world_sectors.dart';
import 'package:domain/src/models/pipes.dart';
import 'package:equatable/equatable.dart';

part 'info_dot.g.dart';

class InfoDot extends Equatable {
  InfoDot({required this.fromSector, required this.pipe}) : id = _id++;

  static int _id = 0;

  final WorldSectors fromSector;
  final Pipe pipe;
  final int id;

  WorldSectors get toSector => isReverse ? pipe.start.sector : pipe.end.sector;

  bool get isReverse => switch (pipe) {
    Pipe(:final start) when start.sector == fromSector => false,
    Pipe(:final end) when end.sector == fromSector => true,
    _ => throw UnimplementedError(),
  };

  @override
  List<Object?> get props => _$props;
}
