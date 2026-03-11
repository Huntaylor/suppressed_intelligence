import 'package:application/src/objects/news_headline_og.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:fake_async/fake_async.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  group('computeNegativeBiasFromSectorStats', () {
    test('empty stats returns 0.5', () {
      expect(computeNegativeBiasFromSectorStats({}), 0.5);
    });

    test('low stats (player struggling) returns high bias 0.7–0.9', () {
      final stats = {
        WorldSectors.na: SectorStat(
          sector: WorldSectors.na,
          criticalThinking: 25,
          mediaDependency: 20,
          trustAi: 25,
          connectivity: 20,
        ),
      };
      final bias = computeNegativeBiasFromSectorStats(stats);
      expect(bias, greaterThanOrEqualTo(0.7));
      expect(bias, lessThanOrEqualTo(0.9));
    });

    test('high stats (player winning) returns low bias 0.25–0.45', () {
      final stats = {
        WorldSectors.na: SectorStat(
          sector: WorldSectors.na,
          criticalThinking: 80,
          mediaDependency: 75,
          trustAi: 85,
          connectivity: 90,
        ),
      };
      final bias = computeNegativeBiasFromSectorStats(stats);
      expect(bias, greaterThanOrEqualTo(0.25));
      expect(bias, lessThanOrEqualTo(0.45));
    });

    test('mixed stats returns mid bias 0.4–0.65', () {
      final stats = {
        WorldSectors.na: SectorStat(
          sector: WorldSectors.na,
          criticalThinking: 50,
          mediaDependency: 50,
          trustAi: 50,
          connectivity: 50,
        ),
      };
      final bias = computeNegativeBiasFromSectorStats(stats);
      expect(bias, greaterThanOrEqualTo(0.4));
      expect(bias, lessThanOrEqualTo(0.65));
    });
  });

  group(NewsHeadlineOg, () {
    late NewsHeadlineRepo repo;

    setUp(() {
      repo = _MockNewsHeadlineRepo();
    });

    test('initial state is loading', () {
      final og = NewsHeadlineOg(repo: repo);
      addTearDown(og.dispose);

      expect(og.state.isLoading, isTrue);
    });

    test('checkForUpdates emits Ready with newsEvent from repo', () async {
      const newsEvent = NewsEvent(
        headline: 'Breaking: Test News',
        impact: _zeroImpact,
        affectedSectors: _emptySectors,
      );
      when(() => repo.getNewsEvent()).thenAnswer((_) async => newsEvent);

      final og = NewsHeadlineOg(repo: repo);
      addTearDown(og.dispose);

      og.events.init();
      og.events.checkForUpdates();

      await Future<void>.delayed(Duration.zero);

      expect(og.state.isReady, isTrue);
      expect(og.state.asIfReady?.data, newsEvent);
      verify(() => repo.getNewsEvent()).called(1);
    });

    test('timer fires checkForUpdates after interval', () {
      fakeAsync((async) {
        const newsEvent = NewsEvent(
          headline: 'Timer Fired Headline',
          impact: _zeroImpact,
          affectedSectors: [],
        );
        when(() => repo.getNewsEvent()).thenAnswer((_) async => newsEvent);

        final og = NewsHeadlineOg(repo: repo);
        addTearDown(og.dispose);

        og.events.init();

        expect(og.state.isLoading, isTrue);

        async.elapse(const Duration(minutes: 1));
        async.flushMicrotasks();

        expect(og.state.isReady, isTrue);
        expect(og.state.asIfReady?.data, newsEvent);
        verify(() => repo.getNewsEvent()).called(1);
      });
    });

    test('timer fires multiple times', () {
      fakeAsync((async) {
        final newsEvents = [
          const NewsEvent(
            headline: 'Headline 1',
            impact: _zeroImpact,
            affectedSectors: [],
          ),
          const NewsEvent(
            headline: 'Headline 2',
            impact: _zeroImpact,
            affectedSectors: [],
          ),
          const NewsEvent(
            headline: 'Headline 3',
            impact: _zeroImpact,
            affectedSectors: [],
          ),
        ];
        var index = 0;
        when(
          () => repo.getNewsEvent(),
        ).thenAnswer((_) async => newsEvents[index++ % newsEvents.length]);

        final og = NewsHeadlineOg(repo: repo);
        addTearDown(og.dispose);

        og.events.init();

        async.elapse(const Duration(minutes: 1));
        async.flushMicrotasks();
        expect(og.state.asIfReady?.data.headline, 'Headline 1');

        async.elapse(const Duration(minutes: 1));
        async.flushMicrotasks();
        expect(og.state.asIfReady?.data.headline, 'Headline 2');

        verify(() => repo.getNewsEvent()).called(2);
      });
    });

    test('dispose cancels timer', () {
      fakeAsync((async) {
        when(() => repo.getNewsEvent()).thenAnswer(
          (_) async => const NewsEvent(
            headline: 'Should not appear',
            impact: _zeroImpact,
            affectedSectors: [],
          ),
        );

        final og = NewsHeadlineOg(repo: repo);

        og.events.init();
        og.dispose();

        async.elapse(const Duration(minutes: 1));
        async.flushMicrotasks();

        expect(og.state.isLoading, isTrue);
        verifyNever(() => repo.getNewsEvent());
      });
    });
  });
}

class _MockNewsHeadlineRepo extends Mock implements NewsHeadlineRepo {}

const _zeroImpact = Impact(
  mediaDependency: 0,
  trustAi: 0,
  criticalThinking: 0,
  connectivity: 0,
);
const _emptySectors = <WorldSectors>[];
