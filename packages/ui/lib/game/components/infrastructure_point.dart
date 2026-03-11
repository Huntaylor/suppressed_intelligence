import 'package:flame/components.dart';

enum InfrastructureLocation {
  /// NA
  newYork(vectorLocation: (250.0, 260.0)),
  greenland(vectorLocation: (302.0, 188.0)),

  /// SA
  brazil(vectorLocation: (314.0, 412.0)),

  /// EU
  unitedKingdom(vectorLocation: (446.0, 196.0)),
  portugal(vectorLocation: (432.0, 238.0)),

  /// Asia
  turkey(vectorLocation: (541.0, 245.0)),
  // japan(vectorLocation: (812.0, 256.0)),
  china(vectorLocation: (750.0, 272.0)),
  india(vectorLocation: (629.0, 282.0)),

  /// AF
  southAfrica(vectorLocation: (498.0, 405.0)),
  nigeria(vectorLocation: (462.0, 316.0)),

  /// AU
  australia(vectorLocation: (869.0, 452.0));

  const InfrastructureLocation({required this.vectorLocation});

  final (double, double) vectorLocation;
  Vector2 get vector2 => Vector2(vectorLocation.$1, vectorLocation.$2);
}
