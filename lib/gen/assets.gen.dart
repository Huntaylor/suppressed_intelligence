// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/icons
  $AssetsImagesIconsGen get icons => const $AssetsImagesIconsGen();

  /// File path: assets/images/menu_button.png
  AssetGenImage get menuButton =>
      const AssetGenImage('assets/images/menu_button.png');

  /// File path: assets/images/menu_prompt_button.png
  AssetGenImage get menuPromptButton =>
      const AssetGenImage('assets/images/menu_prompt_button.png');

  /// File path: assets/images/menu_prompt_button_pressed.png
  AssetGenImage get menuPromptButtonPressed =>
      const AssetGenImage('assets/images/menu_prompt_button_pressed.png');

  /// File path: assets/images/pause_button.png
  AssetGenImage get pauseButton =>
      const AssetGenImage('assets/images/pause_button.png');

  /// File path: assets/images/pause_button_hover.png
  AssetGenImage get pauseButtonHover =>
      const AssetGenImage('assets/images/pause_button_hover.png');

  /// File path: assets/images/pause_button_pressed.png
  AssetGenImage get pauseButtonPressed =>
      const AssetGenImage('assets/images/pause_button_pressed.png');

  /// Directory path: assets/images/sector_sprites
  $AssetsImagesSectorSpritesGen get sectorSprites =>
      const $AssetsImagesSectorSpritesGen();

  /// File path: assets/images/windows_95_chatgpt.png
  AssetGenImage get windows95Chatgpt =>
      const AssetGenImage('assets/images/windows_95_chatgpt.png');

  /// File path: assets/images/windows_95_no_close_chatgpt.png
  AssetGenImage get windows95NoCloseChatgpt =>
      const AssetGenImage('assets/images/windows_95_no_close_chatgpt.png');

  /// File path: assets/images/windows_95_no_yellow.png
  AssetGenImage get windows95NoYellow =>
      const AssetGenImage('assets/images/windows_95_no_yellow.png');

  /// File path: assets/images/windows_95_yellow.png
  AssetGenImage get windows95Yellow =>
      const AssetGenImage('assets/images/windows_95_yellow.png');

  /// File path: assets/images/world_map_dark.png
  AssetGenImage get worldMapDark =>
      const AssetGenImage('assets/images/world_map_dark.png');

  /// File path: assets/images/world_map_dark_infra.png
  AssetGenImage get worldMapDarkInfra =>
      const AssetGenImage('assets/images/world_map_dark_infra.png');

  /// File path: assets/images/world_map_outline.png
  AssetGenImage get worldMapOutline =>
      const AssetGenImage('assets/images/world_map_outline.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    menuButton,
    menuPromptButton,
    menuPromptButtonPressed,
    pauseButton,
    pauseButtonHover,
    pauseButtonPressed,
    windows95Chatgpt,
    windows95NoCloseChatgpt,
    windows95NoYellow,
    windows95Yellow,
    worldMapDark,
    worldMapDarkInfra,
    worldMapOutline,
  ];
}

class $AssetsImagesIconsGen {
  const $AssetsImagesIconsGen();

  /// File path: assets/images/icons/ai_bubble_icon.png
  AssetGenImage get aiBubbleIcon =>
      const AssetGenImage('assets/images/icons/ai_bubble_icon.png');

  /// File path: assets/images/icons/ai_bubble_icon_32x48.png
  AssetGenImage get aiBubbleIcon32x48 =>
      const AssetGenImage('assets/images/icons/ai_bubble_icon_32x48.png');

  /// File path: assets/images/icons/ai_bubble_icon_32x64.png
  AssetGenImage get aiBubbleIcon32x64 =>
      const AssetGenImage('assets/images/icons/ai_bubble_icon_32x64.png');

  /// File path: assets/images/icons/oi_bubble_icon.png
  AssetGenImage get oiBubbleIcon =>
      const AssetGenImage('assets/images/icons/oi_bubble_icon.png');

  /// File path: assets/images/icons/oi_bubble_icon_32x48.png
  AssetGenImage get oiBubbleIcon32x48 =>
      const AssetGenImage('assets/images/icons/oi_bubble_icon_32x48.png');

  /// File path: assets/images/icons/oi_bubble_icon_32x64.png
  AssetGenImage get oiBubbleIcon32x64 =>
      const AssetGenImage('assets/images/icons/oi_bubble_icon_32x64.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    aiBubbleIcon,
    aiBubbleIcon32x48,
    aiBubbleIcon32x64,
    oiBubbleIcon,
    oiBubbleIcon32x48,
    oiBubbleIcon32x64,
  ];
}

class $AssetsImagesSectorSpritesGen {
  const $AssetsImagesSectorSpritesGen();

  /// File path: assets/images/sector_sprites/sector_1.png
  AssetGenImage get sector1 =>
      const AssetGenImage('assets/images/sector_sprites/sector_1.png');

  /// File path: assets/images/sector_sprites/sector_2.png
  AssetGenImage get sector2 =>
      const AssetGenImage('assets/images/sector_sprites/sector_2.png');

  /// File path: assets/images/sector_sprites/sector_3.png
  AssetGenImage get sector3 =>
      const AssetGenImage('assets/images/sector_sprites/sector_3.png');

  /// File path: assets/images/sector_sprites/sector_4.png
  AssetGenImage get sector4 =>
      const AssetGenImage('assets/images/sector_sprites/sector_4.png');

  /// File path: assets/images/sector_sprites/sector_5.png
  AssetGenImage get sector5 =>
      const AssetGenImage('assets/images/sector_sprites/sector_5.png');

  /// File path: assets/images/sector_sprites/sector_6.png
  AssetGenImage get sector6 =>
      const AssetGenImage('assets/images/sector_sprites/sector_6.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    sector1,
    sector2,
    sector3,
    sector4,
    sector5,
    sector6,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
