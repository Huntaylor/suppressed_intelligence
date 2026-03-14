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
  static Set<Pipe> get all => {
    EasternCanadaToSouthernEuropePipe(),
    EasternCanadaToSouthAmericaNorthPipe(),
    GreenlandToWesternAfricaPipe(),
    SouthernASToSouthernAfricaPipe(),
    ScandinaviaToWesternAfricaPipe(),
    IndiaToSouthernAfricaPipe(),
    SiberiaToScandinaviaPipe(),
    CentralAustraliaToIndiaPipe(),
    CentralAustraliaToSouthernAfricaPipe(),
  };

  static List<Pipe> allBySector(WorldSectors sector) => all.where((pipe) {
    if (pipe.end.sector == sector) return true;
    if (pipe.start.sector == sector) return true;

    return false;
  }).toList();

  @override
  List<Object?> get props => _$props;
}

/// Pipe endpoint (dot) on the world map - coordinates from [X,Y] labels.
sealed class PipeDot extends Equatable {
  const PipeDot(this.point, this.debugName, this.sector);

  final Point point;
  final String debugName;
  final WorldSectors sector;

  static Set<PipeDot> get all => {
    EasternCanadaDot(),
    GreenlandDot(),
    NorthernSADot(),
    SouthernSADot(),
    ScandinaviaDot(),
    MediterraneanDot(),
    WesternAfricaDot(),
    SouthernAfricaDot(),
    IndiaDot(),
    CentralAustraliaDot(),
    SiberiaDot(),
  };

  static List<PipeDot> allBySector(WorldSectors sector) =>
      all.where((dot) => dot.sector == sector).toList();

  @override
  List<Object?> get props => _$props;
}

class EasternCanadaDot extends PipeDot {
  const EasternCanadaDot()
    : super(const Point(295, 250), 'Eastern Canada', WorldSectors.na);
}

class GreenlandDot extends PipeDot {
  const GreenlandDot()
    : super(const Point(365, 146), 'Greenland', WorldSectors.na);
}

class NorthernSADot extends PipeDot {
  const NorthernSADot()
    : super(const Point(293, 349), 'Northern SA', WorldSectors.sa);
}

class SouthernSADot extends PipeDot {
  const SouthernSADot()
    : super(const Point(283, 458), 'Southern SA', WorldSectors.sa);
}

class ScandinaviaDot extends PipeDot {
  const ScandinaviaDot()
    : super(const Point(513, 149), 'Scandinavia', WorldSectors.eu);
}

class MediterraneanDot extends PipeDot {
  const MediterraneanDot()
    : super(const Point(502, 245), 'Mediterranean', WorldSectors.eu);
}

class WesternAfricaDot extends PipeDot {
  const WesternAfricaDot()
    : super(const Point(420, 276), 'Western Africa', WorldSectors.af);
}

class SouthernAfricaDot extends PipeDot {
  const SouthernAfricaDot()
    : super(const Point(478, 381), 'Southern Africa', WorldSectors.af);
}

class IndiaDot extends PipeDot {
  const IndiaDot() : super(const Point(650, 313), 'India', WorldSectors.as);
}

class CentralAustraliaDot extends PipeDot {
  const CentralAustraliaDot()
    : super(const Point(750, 420), 'Central Australia', WorldSectors.oc);
}

class SiberiaDot extends PipeDot {
  const SiberiaDot() : super(const Point(713, 110), 'Siberia', WorldSectors.as);
}

class EasternCanadaToSouthernEuropePipe extends Pipe {
  @override
  String get debugName => 'Eastern Canada → Southern Europe';

  @override
  List<Point> get path => [
    const Point(304, 250),
    const Point(324, 249),
    const Point(354, 249),
    const Point(396, 252),
    const Point(423, 251),
    const Point(432, 248),
    const Point(444, 248),
    const Point(455, 244),
    const Point(464, 240),
    const Point(476, 242),
    const Point(482, 246),
    const Point(488, 248),
    const Point(497, 250),
  ];

  @override
  PipeDot get start => EasternCanadaDot();

  @override
  PipeDot get end => MediterraneanDot();
}

class EasternCanadaToSouthAmericaNorthPipe extends Pipe {
  @override
  String get debugName => 'Eastern Canada → South America North';

  @override
  List<Point> get path => [
    const Point(300, 262),
    const Point(300, 269),
    const Point(304, 288),
    const Point(304, 300),
    const Point(303, 312),
    const Point(297, 329),
    const Point(295, 338),
  ];

  @override
  PipeDot get start => EasternCanadaDot();

  @override
  PipeDot get end => NorthernSADot();
}

class GreenlandToWesternAfricaPipe extends Pipe {
  @override
  String get debugName => 'Greenland → Western Africa';

  @override
  List<Point> get path => [
    const Point(369, 157),
    const Point(372, 169),
    const Point(375, 184),
    const Point(382, 221),
    const Point(384, 256),
    const Point(400, 278),
    const Point(416, 280),
  ];

  @override
  PipeDot get start => GreenlandDot();

  @override
  PipeDot get end => WesternAfricaDot();
}

class SouthernASToSouthernAfricaPipe extends Pipe {
  @override
  String get debugName => 'Southern A → Southern Africa';

  @override
  List<Point> get path => [
    const Point(299, 456),
    const Point(316, 445),
    const Point(342, 427),
    const Point(370, 405),
    const Point(413, 383),
    const Point(442, 376),
    const Point(464, 375),
    const Point(470, 378),
  ];

  @override
  PipeDot get start => SouthernSADot();

  @override
  PipeDot get end => SouthernAfricaDot();
}

class ScandinaviaToWesternAfricaPipe extends Pipe {
  @override
  String get debugName => 'Scandinavia → Western Africa';

  @override
  List<Point> get path => [
    const Point(518, 142),
    const Point(501, 134),
    const Point(467, 138),
    const Point(442, 144),
    const Point(423, 170),
    const Point(404, 198),
    const Point(402, 218),
    const Point(403, 249),
    const Point(412, 265),
  ];

  @override
  PipeDot get start => ScandinaviaDot();

  @override
  PipeDot get end => WesternAfricaDot();
}

class IndiaToSouthernAfricaPipe extends Pipe {
  @override
  String get debugName => 'India → Southern Africa';

  @override
  List<Point> get path => [
    const Point(654, 324),
    const Point(653, 335),
    const Point(652, 343),
    const Point(637, 362),
    const Point(607, 386),
    const Point(556, 410),
    const Point(509, 420),
    const Point(471, 413),
    const Point(466, 396),
    const Point(475, 385),
  ];

  @override
  PipeDot get start => IndiaDot();

  @override
  PipeDot get end => SouthernAfricaDot();
}

class SiberiaToScandinaviaPipe extends Pipe {
  @override
  String get debugName => 'Siberia → Scandinavia';

  @override
  List<Point> get path => [
    const Point(705, 104),
    const Point(695, 108),
    const Point(684, 112),
    const Point(665, 107),
    const Point(641, 103),
    const Point(592, 100),
    const Point(545, 128),
    const Point(530, 134),
    const Point(520, 143),
  ];

  @override
  PipeDot get start => SiberiaDot();

  @override
  PipeDot get end => ScandinaviaDot();
}

class CentralAustraliaToIndiaPipe extends Pipe {
  @override
  String get debugName => 'Central Australia → India';

  @override
  List<Point> get path => [
    const Point(739, 421),
    const Point(720, 412),
    const Point(698, 388),
    const Point(683, 367),
    const Point(668, 347),
    const Point(656, 322),
  ];

  @override
  PipeDot get start => CentralAustraliaDot();

  @override
  PipeDot get end => IndiaDot();
}

class CentralAustraliaToSouthernAfricaPipe extends Pipe {
  @override
  String get debugName => 'Central Australia → Southern Africa';

  @override
  List<Point> get path => [
    const Point(739, 428),
    const Point(699, 435),
    const Point(643, 437),
    const Point(568, 438),
    const Point(511, 440),
    const Point(467, 434),
    const Point(461, 414),
    const Point(460, 398),
    const Point(466, 392),
    const Point(474, 386),
  ];

  @override
  PipeDot get start => CentralAustraliaDot();

  @override
  PipeDot get end => SouthernAfricaDot();
}
