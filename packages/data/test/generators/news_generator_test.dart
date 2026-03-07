import 'dart:math';

import 'package:data/src/generators/news_generator.dart';
import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group(NewsGenerator, () {
    test('generates valid NewsEvent with non-empty headline', () {
      final generator = NewsGenerator(random: Random(42));

      final event = generator.generate();

      expect(event.headline, isNotEmpty);
      expect(event.headline, isNot(contains('[')));
      expect(event.headline, isNot(contains(']')));
      expect(event.impact, isNotNull);
      expect(event.affectedSectors, isNotEmpty);
    });

    test('generates varied headlines with different seeds', () {
      final events = <NewsEvent>{
        for (var i = 0; i < 20; i++) NewsGenerator(random: Random(i)).generate(),
      };

      final headlines = events.map((e) => e.headline).toSet();
      expect(headlines.length, greaterThan(1), reason: 'Should produce variety');
    });

    test('sentence start is capitalized', () {
      for (var seed = 0; seed < 50; seed++) {
        final event = NewsGenerator(random: Random(seed)).generate();
        expect(
          event.headline[0],
          event.headline[0].toUpperCase(),
          reason: 'Headline should start with uppercase (seed $seed): ${event.headline}',
        );
      }
    });

    test('headline matches template structure (no unfilled placeholders)', () {
      final generator = NewsGenerator(random: Random(123));

      for (var i = 0; i < 50; i++) {
        final event = generator.generate();
        expect(
          event.headline,
          isNot(contains('[')),
          reason: 'Headline should not contain unfilled placeholders',
        );
        expect(
          event.headline,
          isNot(contains(']')),
          reason: 'Headline should not contain unfilled placeholders',
        );
      }
    });

    test('negativeBias 0.0 produces only positive or neutral templates', () {
      final generator = NewsGenerator(random: Random(999));
      for (var i = 0; i < 100; i++) {
        final event = generator.generate(negativeBias: 0.0);
        expect(
          event.impact.trustAi,
          greaterThanOrEqualTo(0),
          reason: 'negativeBias 0.0 should never pick negative templates (trustAi >= 0)',
        );
      }
    });

    test('negativeBias 1.0 produces only negative or neutral templates', () {
      final generator = NewsGenerator(random: Random(888));
      for (var i = 0; i < 100; i++) {
        final event = generator.generate(negativeBias: 1.0);
        expect(
          event.impact.trustAi,
          lessThanOrEqualTo(0),
          reason: 'negativeBias 1.0 should never pick positive templates (trustAi <= 0)',
        );
      }
    });

    test('omit negativeBias uses default balanced behavior', () {
      final generator = NewsGenerator(random: Random(42));
      final event = generator.generate();
      expect(event.headline, isNotEmpty);
      expect(event.headline, isNot(contains('[')));
    });

    test('impactsSectorsOnly is set occasionally for sector-focused templates', () {
      // Use many seeds to find sector templates; with 30% chance some should hit.
      var sectorSpecificCount = 0;
      for (var seed = 0; seed < 200; seed++) {
        final event = NewsGenerator(random: Random(seed)).generate();
        if (event.impactsSectorsOnly) {
          sectorSpecificCount++;
          expect(event.affectedSectors, isNotEmpty);
        }
      }
      expect(sectorSpecificCount, greaterThan(0),
          reason: 'Some events should have sector-specific impact');
    });
  });
}
