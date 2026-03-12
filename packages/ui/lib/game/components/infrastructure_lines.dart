import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/components/infrastructure_point.dart';

class InfrastructureLines extends PositionComponent with Snapshot {
  InfrastructureLines() : super(priority: 2);

  /// Soft glow underneath the main line for depth
  final Paint _glowPaint = Paint()
    ..color = const Color(0x15FFFFFF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 8
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  /// Main line - slightly softer white, round caps for polished look
  final Paint paint = Paint()
    ..color = const Color(0xE6FFFFFF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  bool isDrawn = false;

  Path path = Path();

  late List<Path> dataPaths;

  @override
  FutureOr<void> onLoad() {
    dataPaths = getLocationPaths();
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    if (!isDrawn) {
      for (var path in dataPaths) {
        canvas.drawPath(path, _glowPaint);
        canvas.drawPath(path, paint);
      }
      canvas.save();

      isDrawn = true;
      takeSnapshot();
    }

    super.render(canvas);
  }

  List<Path> getLocationPaths() {
    List<Path> paths = [];
    final vectorPaths = InfrastructureLines().vector2Connections();

    for (var vectorPath in vectorPaths) {
      final tempPath = Path();

      final p = _createPath(vectorPath, tempPath);

      paths.add(p);
    }

    return paths;
  }

  Path _createPath(List<Vector2> vectors, Path path) {
    path.moveTo(vectors.first.x, vectors.first.y);

    for (var i = 0; i < vectors.length - 1; i++) {
      path.quadraticBezierTo(
        vectors[i].x,
        vectors[i].y,
        (vectors[i].x + vectors[i + 1].x) / 2,
        (vectors[i].y + vectors[i + 1].y) / 2,
      );
    }

    path.lineTo(vectors.last.x, vectors.last.y);

    return path;
  }

  List<List<Vector2>> vector2Connections() => [
    vectorBrazilToUK,
    vectorNYToBrazil,
    vectorBrazilToSouthAfrica,
    vectorNYToNigeria,
    vectorGreenlandToUK,
    vectorAustraliaToChina,
    vectorNigeriaToPortugal,
    vectorIndiaToSouthAfrica,
    vectorPortugalToTurkey,
    vectorPortugalToBrazil,
    vectorChinaToIndia,
    vectorUKToNewYork,
    vectorNigeriaToSouthAfrica,
    vectorTurkeyToIndia,
    // Long-distance pipes for vast global coverage
    vectorCaliforniaToNewYork,
    vectorJapanToAustralia,
    vectorJapanToSingapore,
    vectorSingaporeToAustralia,
    vectorSingaporeToIndia,
    vectorChileToBrazil,
    vectorChileToSouthAfrica,
    vectorGreenlandToNewYork,
    // Trans-Pacific segments (gap in center—cable goes "around the back")
    vectorUSAOffScreenWest, // -----O (ends at US west coast)
    vectorAsiaOffScreenEast, // O-------- (starts at Asia east coast)
    // West coast Americas
    vectorCaliforniaToMexico,
    vectorMexicoToPeru,
    vectorPeruToChile,
    // New points: Alaska, Gulf, South America west, Greenland east, Asia north, Russia north, Australia west, Island off Australia
    vectorAlaskaSouthwestToCalifornia,
    vectorChileToSouthAmericaWest,
    vectorPeruToSouthAmericaWest,
    vectorGreenlandToGreenlandEast,
    vectorGreenlandEastToUK,
    vectorAsiaNorthToJapan,
    vectorAsiaNorthToTurkey,
    vectorRussiaNorthToJapan,
    vectorRussiaNorthToAsiaNorth,
    vectorAustraliaWestToAustralia,
    vectorAustraliaWestToSingapore,
    vectorIslandOffAustraliaToAustralia,
    vectorGulfOfAmericaToNewYork,
    vectorGulfOfAmericaToMexico,
    vectorGulfOfAmericaToBrazil,
  ];

  List<Vector2> get vectorNYToBrazil {
    final newYork = InfrastructureLocation.newYork.vector2;
    final brazila = InfrastructureLocation.brazil.vector2;
    return [
      newYork,
      Vector2(262, 268),
      Vector2(295, 295),
      Vector2(325, 345),
      Vector2(342, 378),
      Vector2(328, 408),
      brazila,
    ];
  }

  List<Vector2> get vectorNYToNigeria {
    final newYork = InfrastructureLocation.newYork.vector2;
    final nigeria = InfrastructureLocation.nigeria.vector2;
    return [
      newYork,
      Vector2(258, 268),
      Vector2(295, 278),
      Vector2(348, 295),
      Vector2(398, 312),
      Vector2(435, 318),
      nigeria,
    ];
  }

  List<Vector2> get vectorGreenlandToUK {
    final greenland = InfrastructureLocation.greenland.vector2;
    final unitedKingdom = InfrastructureLocation.unitedKingdom.vector2;
    return [
      greenland,
      Vector2(312, 195),
      Vector2(355, 200),
      Vector2(398, 198),
      Vector2(425, 200),
      unitedKingdom,
    ];
  }

  List<Vector2> get vectorBrazilToSouthAfrica {
    final southAfrica = InfrastructureLocation.southAfrica.vector2;
    final brazil = InfrastructureLocation.brazil.vector2;
    return [
      brazil,
      Vector2(340, 418),
      Vector2(400, 425),
      Vector2(455, 422),
      Vector2(498, 427),
      southAfrica,
    ];
  }

  List<Vector2> get vectorIndiaToSouthAfrica {
    final southAfrica = InfrastructureLocation.southAfrica.vector2;
    final india = InfrastructureLocation.india.vector2;
    return [
      india,
      Vector2(618, 285),
      Vector2(584, 290),
      Vector2(557, 326),
      Vector2(543, 387),
      Vector2(530, 420),
      Vector2(498, 427),
      southAfrica,
    ];
  }

  List<Vector2> get vectorBrazilToUK {
    final unitedKingdom = InfrastructureLocation.unitedKingdom.vector2;
    final brazil = InfrastructureLocation.brazil.vector2;
    return [
      brazil,
      Vector2(338, 408),
      Vector2(358, 378),
      Vector2(378, 318),
      Vector2(398, 248),
      Vector2(420, 212),
      unitedKingdom,
    ];
  }

  List<Vector2> get vectorNigeriaToPortugal {
    final nigeria = InfrastructureLocation.nigeria.vector2;
    final portugal = InfrastructureLocation.portugal.vector2;
    return [
      nigeria,
      Vector2(438, 325),
      Vector2(418, 305),
      Vector2(408, 275),
      Vector2(418, 252),
      Vector2(425, 242),
      portugal,
    ];
  }

  List<Vector2> get vectorAustraliaToChina {
    final china = InfrastructureLocation.china.vector2;
    final australia = InfrastructureLocation.australia.vector2;
    return [
      australia,
      Vector2(886, 457),
      Vector2(903, 409),
      Vector2(867, 327),
      Vector2(812, 273),
      Vector2(783, 266),
      Vector2(770, 265),
      Vector2(760, 277),
      china,
    ];
  }

  List<Vector2> get vectorPortugalToTurkey {
    final portugal = InfrastructureLocation.portugal.vector2;
    final turkey = InfrastructureLocation.turkey.vector2;
    return [
      portugal,
      Vector2(425.0, 240.0),
      Vector2(429, 247),
      Vector2(438, 245),
      Vector2(447, 245),
      Vector2(453, 240),
      Vector2(461, 237),
      Vector2(468, 239),
      Vector2(477, 240),
      Vector2(506, 251),
      Vector2(532, 252),
      turkey,
    ];
  }

  List<Vector2> get vectorPortugalToBrazil {
    final portugal = InfrastructureLocation.portugal.vector2;
    final brazil = InfrastructureLocation.brazil.vector2;
    return [
      portugal,
      Vector2(428, 258),
      Vector2(400, 295),
      Vector2(368, 345),
      Vector2(348, 378),
      Vector2(328, 405),
      brazil,
    ];
  }

  List<Vector2> get vectorChinaToIndia {
    final china = InfrastructureLocation.china.vector2;
    final india = InfrastructureLocation.india.vector2;
    return [
      china,
      Vector2(720, 272),
      Vector2(690, 278),
      Vector2(655, 280),
      india,
    ];
  }

  List<Vector2> get vectorUKToNewYork {
    final unitedKingdom = InfrastructureLocation.unitedKingdom.vector2;
    final newYork = InfrastructureLocation.newYork.vector2;
    return [
      unitedKingdom,
      Vector2(400, 198),
      Vector2(355, 212),
      Vector2(305, 232),
      Vector2(268, 248),
      newYork,
    ];
  }

  List<Vector2> get vectorNigeriaToSouthAfrica {
    final nigeria = InfrastructureLocation.nigeria.vector2;
    final southAfrica = InfrastructureLocation.southAfrica.vector2;
    return [
      nigeria,
      Vector2(478, 345),
      Vector2(488, 365),
      Vector2(492, 390),
      southAfrica,
    ];
  }

  List<Vector2> get vectorTurkeyToIndia {
    final turkey = InfrastructureLocation.turkey.vector2;
    final india = InfrastructureLocation.india.vector2;
    return [
      turkey,
      Vector2(548, 255),
      Vector2(575, 262),
      Vector2(602, 275),
      Vector2(618, 280),
      india,
    ];
  }

  // Long-distance pipes for vast global coverage

  /// Cross-continental North America
  List<Vector2> get vectorCaliforniaToNewYork {
    final california = InfrastructureLocation.california.vector2;
    final newYork = InfrastructureLocation.newYork.vector2;
    return [
      california,
      Vector2(190, 268),
      Vector2(215, 262),
      Vector2(238, 260),
      newYork,
    ];
  }

  /// Pacific ring: Far East to Oceania
  List<Vector2> get vectorJapanToAustralia {
    final japan = InfrastructureLocation.japan.vector2;
    final australia = InfrastructureLocation.australia.vector2;
    return [
      japan,
      Vector2(818, 278),
      Vector2(838, 325),
      Vector2(852, 375),
      Vector2(858, 410),
      australia,
    ];
  }

  /// Asia-Pacific corridor
  List<Vector2> get vectorJapanToSingapore {
    final japan = InfrastructureLocation.japan.vector2;
    final singapore = InfrastructureLocation.singapore.vector2;
    return [
      japan,
      Vector2(798, 272),
      Vector2(778, 295),
      Vector2(765, 325),
      singapore,
    ];
  }

  /// Southeast Asia to Oceania
  List<Vector2> get vectorSingaporeToAustralia {
    final singapore = InfrastructureLocation.singapore.vector2;
    final australia = InfrastructureLocation.australia.vector2;
    return [
      singapore,
      Vector2(785, 372),
      Vector2(818, 405),
      Vector2(848, 438),
      australia,
    ];
  }

  /// Indian Ocean corridor
  List<Vector2> get vectorSingaporeToIndia {
    final singapore = InfrastructureLocation.singapore.vector2;
    final india = InfrastructureLocation.india.vector2;
    return [
      singapore,
      Vector2(725, 342),
      Vector2(695, 318),
      Vector2(658, 288),
      india,
    ];
  }

  /// South American backbone
  List<Vector2> get vectorChileToBrazil {
    final chile = InfrastructureLocation.chile.vector2;
    final brazil = InfrastructureLocation.brazil.vector2;
    return [
      chile,
      Vector2(272, 455),
      Vector2(285, 442),
      Vector2(302, 428),
      brazil,
    ];
  }

  /// South Atlantic: bottom-left to center
  List<Vector2> get vectorChileToSouthAfrica {
    final chile = InfrastructureLocation.chile.vector2;
    final southAfrica = InfrastructureLocation.southAfrica.vector2;
    return [
      chile,
      Vector2(320, 458),
      Vector2(375, 448),
      Vector2(430, 435),
      Vector2(475, 418),
      southAfrica,
    ];
  }

  /// North Atlantic: Arctic to Americas
  List<Vector2> get vectorGreenlandToNewYork {
    final greenland = InfrastructureLocation.greenland.vector2;
    final newYork = InfrastructureLocation.newYork.vector2;
    return [
      greenland,
      Vector2(288, 208),
      Vector2(272, 232),
      Vector2(258, 250),
      newYork,
    ];
  }

  /// West coast US: off-screen left -----O (ends at California)
  List<Vector2> get vectorUSAOffScreenWest => [
    Vector2(50, 268),
    Vector2(85, 262),
    Vector2(110, 255),
    Vector2(142, 262),
    InfrastructureLocation.california.vector2,
  ];

  /// East coast Asia: O-------- (starts at Japan, extends off right)
  List<Vector2> get vectorAsiaOffScreenEast => [
    InfrastructureLocation.japan.vector2,
    Vector2(848, 248),
    Vector2(898, 255),
    Vector2(950, 258),
  ];

  /// West coast Americas: California → Mexico → Peru → Chile
  List<Vector2> get vectorCaliforniaToMexico => [
    InfrastructureLocation.california.vector2,
    Vector2(172, 288),
    Vector2(176, 305),
    Vector2(180, 315),
    InfrastructureLocation.mexico.vector2,
  ];

  List<Vector2> get vectorMexicoToPeru => [
    InfrastructureLocation.mexico.vector2,
    Vector2(195, 335),
    Vector2(218, 365),
    Vector2(238, 385),
    InfrastructureLocation.peru.vector2,
  ];

  List<Vector2> get vectorPeruToChile => [
    InfrastructureLocation.peru.vector2,
    Vector2(256, 418),
    Vector2(262, 445),
    InfrastructureLocation.chile.vector2,
  ];

  // New points: Alaska, Gulf, South America west, Greenland east, Asia north, Russia north, Australia west, Island off Australia
  List<Vector2> get vectorAlaskaSouthwestToCalifornia => [
    InfrastructureLocation.alaskaSouthwest.vector2,
    Vector2(95, 232),
    Vector2(118, 252),
    InfrastructureLocation.california.vector2,
  ];

  List<Vector2> get vectorAlaskaSouthwestToGreenlandEast => [
    InfrastructureLocation.alaskaSouthwest.vector2,
    Vector2(180, 165),
    Vector2(275, 125),
    InfrastructureLocation.greenlandEast.vector2,
  ];

  List<Vector2> get vectorChileToSouthAmericaWest => [
    InfrastructureLocation.chile.vector2,
    Vector2(255, 478),
    InfrastructureLocation.southAmericaWest.vector2,
  ];

  List<Vector2> get vectorPeruToSouthAmericaWest => [
    InfrastructureLocation.peru.vector2,
    Vector2(248, 442),
    Vector2(246, 468),
    InfrastructureLocation.southAmericaWest.vector2,
  ];

  List<Vector2> get vectorGreenlandToGreenlandEast => [
    InfrastructureLocation.greenland.vector2,
    Vector2(335, 142),
    InfrastructureLocation.greenlandEast.vector2,
  ];

  List<Vector2> get vectorGreenlandEastToUK => [
    InfrastructureLocation.greenlandEast.vector2,
    Vector2(398, 148),
    Vector2(420, 172),
    InfrastructureLocation.unitedKingdom.vector2,
  ];

  List<Vector2> get vectorAsiaNorthToJapan => [
    InfrastructureLocation.asiaNorth.vector2,
    Vector2(640, 195),
    Vector2(730, 218),
    Vector2(775, 242),
    InfrastructureLocation.japan.vector2,
  ];

  List<Vector2> get vectorAsiaNorthToTurkey => [
    InfrastructureLocation.asiaNorth.vector2,
    Vector2(552, 208),
    Vector2(548, 228),
    InfrastructureLocation.turkey.vector2,
  ];

  List<Vector2> get vectorRussiaNorthToJapan => [
    InfrastructureLocation.russiaNorth.vector2,
    Vector2(745, 168),
    Vector2(785, 212),
    InfrastructureLocation.japan.vector2,
  ];

  List<Vector2> get vectorRussiaNorthToAsiaNorth => [
    InfrastructureLocation.russiaNorth.vector2,
    Vector2(638, 138),
    InfrastructureLocation.asiaNorth.vector2,
  ];

  List<Vector2> get vectorAustraliaWestToAustralia => [
    InfrastructureLocation.australiaWest.vector2,
    Vector2(798, 438),
    Vector2(835, 448),
    InfrastructureLocation.australia.vector2,
  ];

  List<Vector2> get vectorAustraliaWestToSingapore => [
    InfrastructureLocation.australiaWest.vector2,
    Vector2(748, 385),
    Vector2(752, 368),
    InfrastructureLocation.singapore.vector2,
  ];

  List<Vector2> get vectorIslandOffAustraliaToAustralia => [
    InfrastructureLocation.islandOffAustralia.vector2,
    Vector2(898, 472),
    Vector2(882, 460),
    InfrastructureLocation.australia.vector2,
  ];

  List<Vector2> get vectorGulfOfAmericaToNewYork => [
    InfrastructureLocation.gulfOfAmerica.vector2,
    Vector2(228, 278),
    Vector2(242, 268),
    InfrastructureLocation.newYork.vector2,
  ];

  List<Vector2> get vectorGulfOfAmericaToMexico => [
    InfrastructureLocation.gulfOfAmerica.vector2,
    Vector2(198, 312),
    InfrastructureLocation.mexico.vector2,
  ];

  List<Vector2> get vectorGulfOfAmericaToBrazil => [
    InfrastructureLocation.gulfOfAmerica.vector2,
    Vector2(238, 348),
    Vector2(278, 382),
    Vector2(298, 405),
    InfrastructureLocation.brazil.vector2,
  ];
}
