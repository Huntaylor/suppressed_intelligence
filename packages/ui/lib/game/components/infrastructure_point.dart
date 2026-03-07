import 'package:flame/components.dart';

enum InfrastructureLocation {
  alaskaA(vectorLocation: (71.0, 204.0)),
  alaskaB(vectorLocation: (122.0, 208.0)),
  oregan(vectorLocation: (141.0, 259.0)),
  newYork(vectorLocation: (250.0, 260.0)),
  newfoundland(vectorLocation: (290.0, 244.0)),
  greenlandA(vectorLocation: (302.0, 188.0)),
  greenlandB(vectorLocation: (312.0, 196.0)),
  iceland(vectorLocation: (412.0, 152.0)),
  unitedKingdom(vectorLocation: (446.0, 196.0)),
  centralAmerica(vectorLocation: (214.0, 330.0)),
  brazilA(vectorLocation: (322.0, 370.0)),
  brazilB(vectorLocation: (314.0, 412.0)),
  chile(vectorLocation: (254.0, 445.0)),
  argentina(vectorLocation: (280.0, 451.0)),
  india(vectorLocation: (629.0, 282.0)),
  nigeria(vectorLocation: (462.0, 316.0)),
  southAfricaA(vectorLocation: (498.0, 405.0)),
  southAfricaB(vectorLocation: (520.0, 391.0)),
  mozambique(vectorLocation: (541.0, 347.0)),
  madagascar(vectorLocation: (559.0, 376.0)),
  turkey(vectorLocation: (541.0, 245.0)),
  newGuinea(vectorLocation: (850.0, 361.0)),
  australiaA(vectorLocation: (869.0, 452.0)),
  australiaB(vectorLocation: (760.0, 452.0)),
  newZealand(vectorLocation: (930.0, 446.0)),
  japanA(vectorLocation: (821.0, 245.0)),
  japanB(vectorLocation: (812.0, 256.0)),
  netherlands(vectorLocation: (465.0, 201.0)),
  china(vectorLocation: (750.0, 272.0)),
  russia(vectorLocation: (802.0, 214.0)),
  portugal(vectorLocation: (432.0, 238.0));

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
