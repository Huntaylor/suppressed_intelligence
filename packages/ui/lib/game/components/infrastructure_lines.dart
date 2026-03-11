import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/components/infrastructure_point.dart';

class InfrastructureLines extends PositionComponent with Snapshot {
  InfrastructureLines() : super(priority: 2);

  final Paint paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

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
  ];

  List<Vector2> get vectorNYToBrazil {
    final newYork = InfrastructureLocation.newYork.vector2;
    final brazila = InfrastructureLocation.brazil.vector2;
    return [
      newYork,
      Vector2(268, 270),
      Vector2(346, 360),
      Vector2(355, 384),
      Vector2(332, 412),
      brazila,
    ];
  }

  List<Vector2> get vectorNYToNigeria {
    final newYork = InfrastructureLocation.newYork.vector2;
    final nigeria = InfrastructureLocation.nigeria.vector2;
    return [
      newYork,
      Vector2(268, 270),
      Vector2(320, 281),
      Vector2(370, 311),
      Vector2(422.0, 331.0),
      nigeria,
    ];
  }

  List<Vector2> get vectorGreenlandToUK {
    final greenland = InfrastructureLocation.greenland.vector2;
    final unitedKingdom = InfrastructureLocation.unitedKingdom.vector2;
    return [
      greenland,
      Vector2(295, 207),
      Vector2(376, 215),
      Vector2(431, 204),
      unitedKingdom,
    ];
  }

  List<Vector2> get vectorBrazilToSouthAfrica {
    final southAfrica = InfrastructureLocation.southAfrica.vector2;
    final brazil = InfrastructureLocation.brazil.vector2;
    return [brazil, Vector2(332, 412), Vector2(498, 427), southAfrica];
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
      Vector2(332, 412),
      Vector2(355, 384),
      Vector2(391, 226),
      Vector2(431, 204),
      unitedKingdom,
    ];
  }

  List<Vector2> get vectorNigeriaToPortugal {
    final nigeria = InfrastructureLocation.nigeria.vector2;
    final portugal = InfrastructureLocation.portugal.vector2;
    return [
      nigeria,
      Vector2(422.0, 331.0),
      Vector2(395.0, 298.0),
      Vector2(405.0, 259.0),
      Vector2(414.0, 241.0),
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
}
