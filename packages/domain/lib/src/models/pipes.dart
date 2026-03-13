import 'dart:math' as math;

import 'package:domain/src/enums/world_sectors.dart';
import 'package:equatable/equatable.dart';

part 'pipes.g.dart';

class Point extends Equatable {
  const Point(this.x, this.y);

  final double x;
  final double y;

  @override
  List<Object?> get props => _$props;
}

sealed class Pipe extends Equatable {
  const Pipe();

  String get debugName;
  List<Point> get path;

  PipeDot get start;
  PipeDot get end;

  /// Time it takes for a data packet to travel through the pipe.
  /// Scales with distance—long pipes (~800 units) take ~5 seconds.
  /// Minimum travel time is 1.5 seconds.
  Duration get travelTime {
    final dx = end.point.x - start.point.x;
    final dy = end.point.y - start.point.y;
    final distance = math.sqrt(dx * dx + dy * dy);
    final ms = (distance * 6.5).round();
    return Duration(milliseconds: math.max(ms, 1500));
  }

  /// Pipes connecting the dots - each pipe connects different sectors.
  static final all = [
    AlaskaToScandinaviaPipe(),
    EasternCanadaToWesternEuropePipe(),
    GreenlandToScandinaviaPipe(),
    NorthernSAToWesternAfricaPipe(),
    SouthernSAToSouthernAfricaPipe(),
    WesternEuropeToEasternCanadaPipe(),
    ScandinaviaToGreenlandPipe(),
    MediterraneanToWesternAfricaPipe(),
    WesternAfricaToNorthernSAPipe(),
    SouthernAfricaToSouthernSAPipe(),
    MadagascarToIndiaPipe(),
    IndiaToIndonesiaPipe(),
    SoutheastAsiaToIndonesiaPipe(),
    JapanToIndonesiaPipe(),
    IndonesiaToSoutheastAsiaPipe(),
    CentralAustraliaToIndiaPipe(),
    SouthernAustraliaToSoutheastAsiaPipe(),
  ];

  static List<Pipe> allBySector(
    WorldSectors sector, {
    bool includeEnd = true,
  }) => all.where((pipe) {
    if (includeEnd) {
      if (pipe.end.sector == sector) return true;
    }

    if (pipe.start.sector == sector) return true;

    return false;
  }).toList();

  @override
  List<Object?> get props => _$props;
}

/// Pipe endpoint (dot) on the world map - coordinates from [X,Y] labels.
sealed class PipeDot extends Equatable {
  const PipeDot(this.point, this.sector);

  final Point point;
  final WorldSectors sector;

  static List<PipeDot> get all => [
    AlaskaDot(),
    EasternCanadaDot(),
    GreenlandDot(),
    NorthernSADot(),
    SouthernSADot(),
    WesternEuropeDot(),
    ScandinaviaDot(),
  ];

  static List<PipeDot> allBySector(WorldSectors sector) =>
      all.where((dot) => dot.sector == sector).toList();

  @override
  List<Object?> get props => _$props;
}

class AlaskaDot extends PipeDot {
  const AlaskaDot() : super(const Point(48, 175), WorldSectors.na);
}

class EasternCanadaDot extends PipeDot {
  const EasternCanadaDot() : super(const Point(298, 251), WorldSectors.na);
}

class GreenlandDot extends PipeDot {
  const GreenlandDot() : super(const Point(365, 146), WorldSectors.na);
}

class NorthernSADot extends PipeDot {
  const NorthernSADot() : super(const Point(293, 349), WorldSectors.sa);
}

class SouthernSADot extends PipeDot {
  const SouthernSADot() : super(const Point(286, 459), WorldSectors.sa);
}

class WesternEuropeDot extends PipeDot {
  const WesternEuropeDot() : super(const Point(443, 205), WorldSectors.eu);
}

class ScandinaviaDot extends PipeDot {
  const ScandinaviaDot() : super(const Point(513, 149), WorldSectors.eu);
}

class MediterraneanDot extends PipeDot {
  const MediterraneanDot() : super(const Point(502, 245), WorldSectors.eu);
}

class WesternAfricaDot extends PipeDot {
  const WesternAfricaDot() : super(const Point(420, 276), WorldSectors.af);
}

class SouthernAfricaDot extends PipeDot {
  const SouthernAfricaDot() : super(const Point(478, 381), WorldSectors.af);
}

class MadagascarDot extends PipeDot {
  const MadagascarDot() : super(const Point(577, 360), WorldSectors.af);
}

class IndiaDot extends PipeDot {
  const IndiaDot() : super(const Point(651, 315), WorldSectors.as);
}

class SoutheastAsiaDot extends PipeDot {
  const SoutheastAsiaDot() : super(const Point(749, 282), WorldSectors.as);
}

class JapanDot extends PipeDot {
  const JapanDot() : super(const Point(813, 264), WorldSectors.as);
}

class IndonesiaDot extends PipeDot {
  const IndonesiaDot() : super(const Point(846, 352), WorldSectors.oc);
}

class CentralAustraliaDot extends PipeDot {
  const CentralAustraliaDot() : super(const Point(750, 420), WorldSectors.oc);
}

class SouthernAustraliaDot extends PipeDot {
  const SouthernAustraliaDot() : super(const Point(758, 463), WorldSectors.oc);
}

class AlaskaToScandinaviaPipe extends Pipe {
  @override
  String get debugName => 'Alaska → Scandinavia';

  /// Arctic route: Alaska → Bering Strait → Arctic Ocean → Scandinavia
  @override
  List<Point> get path => [
    const Point(120, 90), // Bering Strait / Chukchi Sea
    const Point(280, 80), // Arctic Ocean
    const Point(420, 110), // North of Scandinavia approach
  ];

  @override
  PipeDot get start => AlaskaDot();

  @override
  PipeDot get end => ScandinaviaDot();
}

class EasternCanadaToWesternEuropePipe extends Pipe {
  @override
  String get debugName => 'Eastern Canada → Western Europe';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => EasternCanadaDot();

  @override
  PipeDot get end => WesternEuropeDot();
}

class GreenlandToScandinaviaPipe extends Pipe {
  @override
  String get debugName => 'Greenland → Scandinavia';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => GreenlandDot();

  @override
  PipeDot get end => ScandinaviaDot();
}

class NorthernSAToWesternAfricaPipe extends Pipe {
  @override
  String get debugName => 'Northern SA → Western Africa';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => NorthernSADot();

  @override
  PipeDot get end => WesternAfricaDot();
}

class SouthernSAToSouthernAfricaPipe extends Pipe {
  @override
  String get debugName => 'Southern SA → Southern Africa';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => SouthernSADot();

  @override
  PipeDot get end => SouthernAfricaDot();
}

class WesternEuropeToEasternCanadaPipe extends Pipe {
  @override
  String get debugName => 'Western Europe → Eastern Canada';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => WesternEuropeDot();

  @override
  PipeDot get end => EasternCanadaDot();
}

class ScandinaviaToGreenlandPipe extends Pipe {
  @override
  String get debugName => 'Scandinavia → Greenland';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => ScandinaviaDot();

  @override
  PipeDot get end => GreenlandDot();
}

class MediterraneanToWesternAfricaPipe extends Pipe {
  @override
  String get debugName => 'Mediterranean → Western Africa';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => MediterraneanDot();

  @override
  PipeDot get end => WesternAfricaDot();
}

class WesternAfricaToNorthernSAPipe extends Pipe {
  @override
  String get debugName => 'Western Africa → Northern SA';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => WesternAfricaDot();

  @override
  PipeDot get end => NorthernSADot();
}

class SouthernAfricaToSouthernSAPipe extends Pipe {
  @override
  String get debugName => 'Southern Africa → Southern SA';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => SouthernAfricaDot();

  @override
  PipeDot get end => SouthernSADot();
}

class MadagascarToIndiaPipe extends Pipe {
  @override
  String get debugName => 'Madagascar → India';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => MadagascarDot();

  @override
  PipeDot get end => IndiaDot();
}

class IndiaToIndonesiaPipe extends Pipe {
  @override
  String get debugName => 'India → Indonesia';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => IndiaDot();

  @override
  PipeDot get end => IndonesiaDot();
}

class SoutheastAsiaToIndonesiaPipe extends Pipe {
  @override
  String get debugName => 'Southeast Asia → Indonesia';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => SoutheastAsiaDot();

  @override
  PipeDot get end => IndonesiaDot();
}

class JapanToIndonesiaPipe extends Pipe {
  @override
  String get debugName => 'Japan → Indonesia';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => JapanDot();

  @override
  PipeDot get end => IndonesiaDot();
}

class IndonesiaToSoutheastAsiaPipe extends Pipe {
  @override
  String get debugName => 'Indonesia → Southeast Asia';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => IndonesiaDot();

  @override
  PipeDot get end => SoutheastAsiaDot();
}

class CentralAustraliaToIndiaPipe extends Pipe {
  @override
  String get debugName => 'Central Australia → India';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => CentralAustraliaDot();

  @override
  PipeDot get end => IndiaDot();
}

class SouthernAustraliaToSoutheastAsiaPipe extends Pipe {
  @override
  String get debugName => 'Southern Australia → Southeast Asia';

  @override
  List<Point> get path => [];

  @override
  PipeDot get start => SouthernAustraliaDot();

  @override
  PipeDot get end => SoutheastAsiaDot();
}
