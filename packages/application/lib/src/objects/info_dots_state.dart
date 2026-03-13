// ignore_for_file: library_private_types_in_public_api

part of info_dots_og;

class InfoDotsState extends Equatable {
  const InfoDotsState();

  bool get hasVisibleDots => this is _VisibleDots;
  _VisibleDots? get asIfVisibleDots => switch (this) {
    final _VisibleDots state => state,
    _ => null,
  };

  @override
  List<Object?> get props => _$props;
}

class _VisibleDots extends InfoDotsState {
  const _VisibleDots({required this.dots});

  final List<InfoDot> dots;

  @override
  List<Object?> get props => _$props;
}
