import 'package:application/src/objects/news_headline_og.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:fake_async/fake_async.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
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
      expect(og.state.asIfReady?.newsEvent, newsEvent);
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
        expect(og.state.asIfReady?.newsEvent, newsEvent);
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
        expect(og.state.asIfReady?.newsEvent.headline, 'Headline 1');

        async.elapse(const Duration(minutes: 1));
        async.flushMicrotasks();
        expect(og.state.asIfReady?.newsEvent.headline, 'Headline 2');

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
