import 'package:flame/components.dart';

enum InfrastructureLocation {
  /// NA
  newYork(vectorLocation: (250.0, 260.0)),
  california(vectorLocation: (142.0, 267.0)),
  greenland(vectorLocation: (302.0, 188.0)),
  alaskaSouthwest(vectorLocation: (72.0, 211.0)),
  gulfOfAmerica(vectorLocation: (213.0, 300.0)),

  /// Americas west coast
  mexico(vectorLocation: (182.0, 318.0)),
  peru(vectorLocation: (250.0, 398.0)),

  /// SA
  brazil(vectorLocation: (314.0, 412.0)),
  chile(vectorLocation: (265.0, 465.0)),
  southAmericaWest(vectorLocation: (245.0, 485.0)),

  /// EU
  unitedKingdom(vectorLocation: (446.0, 196.0)),
  portugal(vectorLocation: (432.0, 238.0)),
  greenlandEast(vectorLocation: (370.0, 95.0)),

  /// Asia
  turkey(vectorLocation: (541.0, 245.0)),
  asiaNorth(vectorLocation: (560.0, 159.0)),
  russiaNorth(vectorLocation: (703.0, 114.0)),
  japan(vectorLocation: (812.0, 256.0)),
  china(vectorLocation: (750.0, 272.0)),
  india(vectorLocation: (629.0, 282.0)),
  singapore(vectorLocation: (755.0, 355.0)),

  /// AF
  southAfrica(vectorLocation: (498.0, 405.0)),
  nigeria(vectorLocation: (462.0, 316.0)),

  /// AU
  australia(vectorLocation: (869.0, 452.0)),
  australiaWest(vectorLocation: (755.0, 434.0)),
  islandOffAustralia(vectorLocation: (916.0, 481.0));

  const InfrastructureLocation({required this.vectorLocation});

  final (double, double) vectorLocation;
  Vector2 get vector2 => Vector2(vectorLocation.$1, vectorLocation.$2);
}
