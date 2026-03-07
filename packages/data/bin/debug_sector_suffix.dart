// ignore_for_file: avoid_print

import 'dart:math';

import 'package:data/src/generators/news_generator.dart';

void main() {
  final generator = NewsGenerator(random: Random(42));
  const sectorSuffixTemplates = {'warning_authority', 'ai_direct_warning', 'positive_study_a'};

  print('Generating 100 NEGATIVE events (negativeBias: 1.0) - looking for sectorSuffix templates:\n');
  for (var i = 0; i < 100; i++) {
    final event = generator.generate(negativeBias: 1.0);
    if (event.templateId != null && sectorSuffixTemplates.contains(event.templateId)) {
      final hasSuffix = RegExp(r' in (North America|South America|Europe|Asia|Africa|Oceania)\.$')
          .hasMatch(event.headline);
      print('${event.templateId}: ${event.headline}');
      print('  -> suffix present: $hasSuffix\n');
    }
  }
}
