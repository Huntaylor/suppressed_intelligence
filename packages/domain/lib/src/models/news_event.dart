import 'package:domain/src/enums/world_sectors.dart';
import 'package:domain/src/models/impact.dart';
import 'package:equatable/equatable.dart';

part 'news_event.g.dart';

/// Represents a news event with a headline.
class NewsEvent extends Equatable {
  const NewsEvent({
    required this.headline,
    required this.impact,
    required this.affectedSectors,
    this.templateId,
  });

  final String headline;
  final Impact impact;
  final List<WorldSectors> affectedSectors;

  /// Template ID used to generate this headline. Use with [NewsGenerator]'s
  /// [avoidTemplateIds] to reduce structural repetition in batches.
  final String? templateId;

  @override
  List<Object?> get props => _$props;
}
