import 'package:change_case/change_case.dart';

/// Slot types for news template placeholders.
/// Use [NewsSlotType.placeholder] to get the template string, e.g. "[authority]".
enum NewsSlotType {
  // Warning / authority templates
  authority,
  threat,
  negativeOutcome,
  aiRecommendation,
  sector,
  aiSystem,

  // Study / positive templates (structured variability)
  studySource,
  studySourceAttribution, // For "according to X" (scientists, researchers)
  studySourceFinds, // For "[X] finds" (A new study finds, Global analysis finds)
  behavior,
  benefitVerb,
  outcome,
  aiGuidance,
  optionalReason,
  tonePrefix,

  // Shared
  percent,
  percentFormat;

  /// Placeholder string used in templates, e.g. "[authority]".
  String get placeholder => '[$templateKey]';

  /// Converts enum name to template format (e.g. negativeOutcome → "negative_outcome").
  String get templateKey => name.toSnakeCase();
}
