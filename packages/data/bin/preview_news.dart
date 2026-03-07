// ignore_for_file: avoid_print

import 'dart:math';

import 'package:data/src/generators/news_generator.dart';

void main() {
  final generator = NewsGenerator(random: Random(42));

  void printSection(String title, double negativeBias) {
    print('\n${'=' * 60}');
    print(' $title (negativeBias: $negativeBias)');
    print('=' * 60);
  }

  /// Generates [count] events with [negativeBias], prints them, and reports duplicates.
  /// Set [avoidDuplicates] to false to measure natural duplicate rate (no retries).
  /// Uses template diversity (avoidTemplateIds) to reduce repetitive structure.
  void runBatch(
    String title,
    double negativeBias,
    int count, {
    bool avoidDuplicates = true,
  }) {
    printSection(title, negativeBias);
    final seen = <String>{};
    final duplicates = <String, int>{};
    final recentTemplateIds = <String>[];
    // Larger window for balanced mix (0.5) — negative + neutral + positive all in pool
    const recentWindow = 12;
    for (var i = 0; i < count; i++) {
      final avoidTemplates = recentTemplateIds.length >= recentWindow
          ? recentTemplateIds.take(recentWindow).toSet()
          : null;
      final event = generator.generate(
        negativeBias: negativeBias,
        avoidHeadlines: avoidDuplicates ? seen : null,
        avoidTemplateIds: avoidTemplates,
      );
      if (event.templateId != null) {
        recentTemplateIds.insert(0, event.templateId!);
        if (recentTemplateIds.length > recentWindow) {
          recentTemplateIds.removeLast();
        }
      }
      final h = event.headline;
      if (seen.contains(h)) {
        duplicates[h] = (duplicates[h] ?? 1) + 1;
      } else {
        seen.add(h);
      }
      print('${i + 1}. $h');
    }
    final uniqueCount = seen.length;
    final dupCount = count - uniqueCount;
    print('\n--- Summary: $uniqueCount unique, $dupCount duplicates ---');
    if (duplicates.isNotEmpty) {
      print('Duplicate headlines:');
      for (final e in duplicates.entries) {
        print('  x${e.value + 1}: ${e.key}');
      }
    }
  }

  // Set avoidDuplicates: false to measure natural duplicate rate
  // runBatch('100 NEGATIVE events', 1.0, 100, avoidDuplicates: true);
  // runBatch('100 NEUTRAL events', 0.5, 100, avoidDuplicates: true);
  runBatch('100 POSITIVE events', 0.0, 100, avoidDuplicates: true);

  print('\n');
}
