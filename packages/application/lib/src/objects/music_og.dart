library music_og;

import 'dart:async' show FutureOr;

import 'package:application/src/og.dart';
import 'package:application/src/setup/setup.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:meta/meta.dart';
import 'package:scoped_deps/scoped_deps.dart';

part 'music_event.dart';
part 'music_og.g.dart';
part 'music_state.dart';

MusicOg get musicOg => read(MusicOg.provider);

class MusicOg extends Og<MusicEvent, MusicState> {
  MusicOg() : super(const MusicState()) {
    on<_StartSounds>(_startSounds);
    on<_ToggleMusic>(_toggleMusic);
    on<_ToggleSFX>(_toggleSFX);
    on<_PlaySFX>(_playSfx);
  }

  static ScopedRef<MusicOg>? _provider;
  @internal
  static ScopedRef<MusicOg> get provider =>
      _provider ??= create<MusicOg>((getIt.call));

  late final events = _Events(this);

  FutureOr<void> _playSfx(_PlaySFX event, Emitter<MusicState> emit) async {
    final isMuted = state.isSFXmuted;
    if (!isMuted) {
      String sfxPath = '';
      switch (event.sfxType) {
        case SfxType.click:
          sfxPath = 'blipSelect.wav';

        case SfxType.upgrade:
          sfxPath = 'powerUp.wav';
        case SfxType.oiBubble:
          sfxPath = 'explosion.wav';
        case SfxType.aiBubble:
          sfxPath = 'select_bubble_hit.wav';
      }
      await FlameAudio.play(sfxPath);
    }
  }

  FutureOr<void> _toggleSFX(_ToggleSFX event, Emitter<MusicState> emit) {
    final playSfx = !state.isSFXmuted;

    emit(state.copywith(isSFXmuted: playSfx));
  }

  FutureOr<void> _startSounds(
    _StartSounds event,
    Emitter<MusicState> emit,
  ) async {
    Bgm backgroundMusic = Bgm();

    await FlameAudio.bgm.initialize();

    await FlameAudio.audioCache.loadAll([
      'blipSelect.wav',
      'click.wav',
      'powerUp.wav',
      'explosion.wav',
      'select_bubble_hit.wav',
      'select_bubble.wav',
      'monsters_in_my_closet_loop.wav',
      'monsters_in_my_closet.wav',
    ]);

    await backgroundMusic.play('audio/monsters_in_my_closet.wav');
    backgroundMusic.audioPlayer.setVolume(.7);

    backgroundMusic.audioPlayer.onPositionChanged.listen((duration) async {
      if (state.isMusicLooping) return;
      if (duration >= Duration(minutes: 2, seconds: 33, milliseconds: 600)) {
        await backgroundMusic.play('audio/monsters_in_my_closet_loop.wav');
        emit(state.copywith(isMusicLooping: true));
      }
    });

    emit(state.copywith(backgroundMusic: backgroundMusic));
  }

  FutureOr<void> _toggleMusic(_ToggleMusic event, Emitter<MusicState> emit) {
    final isPaused = state.isMusicPaused;
    final backgroundMusic = state.backgroundMusic;
    if (backgroundMusic != null) {
      if (isPaused) {
        backgroundMusic.resume();
      } else {
        backgroundMusic.pause();

        emit(
          state.copywith(
            isMusicPaused: !isPaused,
            backgroundMusic: backgroundMusic,
          ),
        );
      }
      emit(
        state.copywith(
          isMusicPaused: !isPaused,
          backgroundMusic: backgroundMusic,
        ),
      );
    }
  }
}
