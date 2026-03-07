import 'package:flame/components.dart';

enum InfrastructureLocation {
  alaskaA(vectorLocation: (71.0, 206.0)),
  alaskaB(vectorLocation: (122.0, 208.0)),
  oregan(vectorLocation: (141.0, 259.0)),
  newYork(vectorLocation: (253.0, 263.0)),
  newfoundland(vectorLocation: (294.0, 247.0)),
  greenlandA(vectorLocation: (302.0, 188.0)),
  greenlandB(vectorLocation: (316.0, 198.0)),
  iceland(vectorLocation: (415.0, 156.0)),
  unitedKingdom(vectorLocation: (446.0, 196.0)),
  centralAmerica(vectorLocation: (214.0, 332.0)),
  brazilA(vectorLocation: (322.0, 370.0)),
  brazilB(vectorLocation: (316.0, 415.0)),
  chile(vectorLocation: (254.0, 445.0)),
  argentina(vectorLocation: (285.0, 451.0)),
  india(vectorLocation: (629.0, 282.0)),
  nigeria(vectorLocation: (465.0, 320.0)),
  southAfrica(vectorLocation: (498.0, 408.0)),
  mozambique(vectorLocation: (544.0, 347.0)),
  madagascar(vectorLocation: (559.0, 376.0)),
  turkey(vectorLocation: (541.0, 245.0)),
  newGuinea(vectorLocation: (850.0, 361.0)),
  australia(vectorLocation: (872.0, 453.0)),
  newZealand(vectorLocation: (930.0, 443.0)),
  japanA(vectorLocation: (821.0, 245.0)),
  japanB(vectorLocation: (814.0, 256.0)),
  germany(vectorLocation: (465.0, 201.0)),
  china(vectorLocation: (752.0, 275.0)),
  russia(vectorLocation: (805.0, 217.0)),
  portugal(vectorLocation: (432.0, 238.0))
  ;

  const InfrastructureLocation({required this.vectorLocation});

  final (double, double) vectorLocation;
}

class Infrastructure {
  const Infrastructure({
    required this.location,
    // required this.connectingPoints,
  });

  final InfrastructureLocation location;
  // final List<Infrastructure> connectingPoints;

  Vector2 get vector2 =>
      Vector2(location.vectorLocation.$1, location.vectorLocation.$2);
}
