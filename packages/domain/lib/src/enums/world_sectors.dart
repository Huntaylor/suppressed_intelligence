enum WorldSectors {
  /// North America
  na('53-4E41'),
  //Size [338.0,344.0]
  //Position [216.0,177.0]

  /// South America
  sa('53-5341'),
  //Size [102.0,172.0]
  //Position [283.0, 423.0]

  /// Europe
  eu('53-4555'),
  //Size [215.0, 133.0]
  //Position [507.5, 182.5]

  /// Asia
  as('53-4153'),
  //Size [401.0, 304.0]
  //Position [705.5, 219.0]

  /// Africa
  af('53-4146'),
  //Size [160.0,172.0]
  //Position [497.0, 327.0]

  /// Oceania
  oc('53-4F43');
  //Size [196.0, 157.0]
  //Position [847.0, 420.5]

  const WorldSectors(this.codeName);

  final String codeName;

  /// Display name for headlines, e.g. "North America", "Europe".
  String get displayName => switch (this) {
    WorldSectors.na => 'North America',
    WorldSectors.sa => 'South America',
    WorldSectors.eu => 'Europe',
    WorldSectors.as => 'Asia',
    WorldSectors.af => 'Africa',
    WorldSectors.oc => 'Oceania',
  };

  String get imagePath => switch (this) {
    WorldSectors.na => 'sector_sprites/sector_1.png',
    WorldSectors.sa => 'sector_sprites/sector_2.png',
    WorldSectors.eu => 'sector_sprites/sector_5.png',
    WorldSectors.as => 'sector_sprites/sector_6.png',
    WorldSectors.af => 'sector_sprites/sector_3.png',
    WorldSectors.oc => 'sector_sprites/sector_4.png',
  };
  String get darkImagePath => switch (this) {
    WorldSectors.na => 'sector_sprites/dark_version/sector_1_dark.png',
    WorldSectors.sa => 'sector_sprites/dark_version/sector_2_dark.png',
    WorldSectors.eu => 'sector_sprites/dark_version/sector_5_dark.png',
    WorldSectors.as => 'sector_sprites/dark_version/sector_6_dark.png',
    WorldSectors.af => 'sector_sprites/dark_version/sector_3_dark.png',
    WorldSectors.oc => 'sector_sprites/dark_version/sector_4_dark.png',
  };

  ({double x, double y}) get position => switch (this) {
    WorldSectors.na => (x: 216.0, y: 177.0),
    WorldSectors.sa => (x: 283.0, y: 423.0),
    WorldSectors.eu => (x: 507.5, y: 182.5),
    WorldSectors.as => (x: 705.5, y: 219.0),
    WorldSectors.af => (x: 497.0, y: 327.0),
    WorldSectors.oc => (x: 847.0, y: 420.5),
  };

  ({double width, double height}) get size => switch (this) {
    WorldSectors.na => (width: 338.0, height: 344.0),
    WorldSectors.sa => (width: 102.0, height: 172.0),
    WorldSectors.eu => (width: 215.0, height: 133.0),
    WorldSectors.as => (width: 401.0, height: 304.0),
    WorldSectors.af => (width: 160.0, height: 172.0),
    WorldSectors.oc => (width: 196.0, height: 157.0),
  };
}
