import 'dart:async';

import 'package:application/application.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class AudioComponent extends Component
    with HasGameReference<SuppressedIntelGame> {
  AudioComponent();

  bool _isMusicPlaying = true;
  bool _isSFXPlaying = true;

  late Bgm backgroundMusic;

  @override
  FutureOr<void> onLoad() async {
    FlameAudio.bgm.initialize();
    backgroundMusic = Bgm();

    musicOg.addListener((state) async {
      _isMusicPlaying = state.isMusicPaused;
      _isSFXPlaying = state.isSFXmuted;

      if (!_isMusicPlaying) {
        await toggleBgm();
      }
    });

    await backgroundMusic.play('audio/monsters_in_my_closet.wav');
    backgroundMusic.audioPlayer.setVolume(.7);
    if (!_isMusicPlaying) await backgroundMusic.pause();

    return super.onLoad();
  }

  Future<void> onButtonTapped() async {
    if (_isSFXPlaying) {
      await FlameAudio.play('explosion.wav', volume: 0.1);
    }
  }

  Future<void> onBubbleTapped() async {
    if (_isSFXPlaying) {
      await FlameAudio.play('explosion.wav', volume: 0.1);
    }
  }

  Future<void> toggleBgm() async {
    if (_isMusicPlaying) await backgroundMusic.resume();
    if (!_isMusicPlaying) await backgroundMusic.pause();
  }
}
