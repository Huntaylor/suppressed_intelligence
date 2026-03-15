part of music_og;

sealed class MusicEvent {
  const MusicEvent();
}

class _ToggleSFX extends MusicEvent {
  const _ToggleSFX();
}

class _PlaySFX extends MusicEvent {
  final SfxType sfxType;
  const _PlaySFX({required this.sfxType});
}

class _ToggleMusic extends MusicEvent {
  const _ToggleMusic();
}

class _StartSounds extends MusicEvent {
  const _StartSounds();
}

class _Events {
  _Events(this._object);

  final MusicOg _object;

  void playSfx(SfxType sfxType) {
    _object.add(_PlaySFX(sfxType: sfxType));
  }

  void toggleMusic() {
    _object.add(_ToggleMusic());
  }

  void toggleSfx() {
    _object.add(_ToggleSFX());
  }

  void startSounds() {
    _object.add(_StartSounds());
  }
}
