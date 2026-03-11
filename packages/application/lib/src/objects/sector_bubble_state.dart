// ignore_for_file: library_private_types_in_public_api

part of sector_bubble_og;

final class SectorBubbleState extends Equatable {
  const SectorBubbleState({this.bubbles = const []});

  final List<SectorBubble> bubbles;

  @override
  List<Object?> get props => _$props;
}
