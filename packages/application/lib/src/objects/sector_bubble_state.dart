// ignore_for_file: library_private_types_in_public_api

part of sector_bubble_og;

final class SectorBubbleState extends Equatable {
  const SectorBubbleState({this.bubbles = const []});

  final List<SectorBubble> bubbles;

  _RemovedBubble? get asIfRemovedBubble => switch (this) {
    final _RemovedBubble state => state,
    _ => null,
  };

  @override
  List<Object?> get props => _$props;
}

final class _RemovedBubble extends SectorBubbleState {
  const _RemovedBubble(this.bubble);

  final SectorBubble bubble;

  @override
  List<Object?> get props => _$props;
}
