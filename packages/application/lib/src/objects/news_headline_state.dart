// ignore_for_file: library_private_types_in_public_api

part of news_headline_og;

sealed class NewsHeadlineState extends Equatable {
  const NewsHeadlineState();

  bool get isLoading => this is _Loading;
  _Loading? get asIfLoading => switch (this) {
    final _Loading state => state,
    _ => null,
  };

  bool get isReady => this is _Ready;
  _Ready? get asIfReady => switch (this) {
    final _Ready state => state,
    _ => null,
  };

  @override
  List<Object?> get props => [];
}

class _Loading extends NewsHeadlineState {
  const _Loading();
}

class _Ready extends NewsHeadlineState {
  const _Ready({required this.data});

  final NewsEvent data;

  @override
  List<Object?> get props => _$props;
}
