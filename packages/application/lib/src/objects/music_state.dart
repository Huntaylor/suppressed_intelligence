// ignore_for_file: library_private_types_in_public_api

part of music_og;

final class MusicState extends Equatable {
  const MusicState({
    this.isMusicPaused = false,
    this.isSFXmuted = false,
    this.isMusicLooping = false,
    this.backgroundMusic,
  });

  final bool isMusicPaused;
  final bool isSFXmuted;
  final bool isMusicLooping;

  final Bgm? backgroundMusic;

  MusicState copywith({
    bool? isMusicPaused,
    bool? isMusicLooping,
    bool? isSFXmuted,
    Bgm? backgroundMusic,
  }) {
    return MusicState(
      isMusicLooping: isMusicLooping ?? this.isMusicLooping,
      backgroundMusic: backgroundMusic ?? this.backgroundMusic,
      isMusicPaused: isMusicPaused ?? this.isMusicPaused,
      isSFXmuted: isSFXmuted ?? this.isSFXmuted,
    );
  }

  @override
  List<Object?> get props => _$props;
}
