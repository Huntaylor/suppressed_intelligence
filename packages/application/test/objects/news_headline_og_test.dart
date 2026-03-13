import 'dart:async';

import 'package:application/application.dart' as application;
import 'package:application/src/objects/game_config_og.dart';
import 'package:application/src/objects/news_headline_og.dart';
import 'package:data/data.dart' as data;
import 'package:domain/domain.dart';
import 'package:fake_async/fake_async.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scoped_deps/scoped_deps.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() {
    final getIt = GetIt.asNewInstance();
    data.setup(getIt);
    application.setup(getIt);
  });

  group('computeNegativeBiasFromSectorStats', () {
    test('empty stats returns 0.5', () {
      expect(computeNegativeBiasFromSectorStats({}), 0.5);
    });

    test('low stats (player struggling) returns high bias 0.7–0.9', () {
      final stats = {
        WorldSectors.na: SectorStat(sector: WorldSectors.na).copyWith(
          criticalThinking: 25,
          trustAi: 25,
        ),
      };
      final bias = computeNegativeBiasFromSectorStats(stats);
      expect(bias, greaterThanOrEqualTo(0.7));
      expect(bias, lessThanOrEqualTo(0.9));
    });

    test('high stats (player winning) returns low bias 0.25–0.45', () {
      final stats = {
        WorldSectors.na: SectorStat(sector: WorldSectors.na).copyWith(
          criticalThinking: 80,
          trustAi: 85,
        ),
      };
      final bias = computeNegativeBiasFromSectorStats(stats);
      expect(bias, greaterThanOrEqualTo(0.25));
      expect(bias, lessThanOrEqualTo(0.45));
    });

    test('mixed stats returns mid bias 0.4–0.65', () {
      final stats = {
        WorldSectors.na: SectorStat(sector: WorldSectors.na).copyWith(
          criticalThinking: 50,
          trustAi: 50,
        ),
      };
      final bias = computeNegativeBiasFromSectorStats(stats);
      expect(bias, greaterThanOrEqualTo(0.4));
      expect(bias, lessThanOrEqualTo(0.65));
    });
  });

  group(NewsHeadlineOg, () {
    late data.NewsHeadlineRepo repo;

    setUp(() {
      repo = _MockNewsHeadlineRepo();
    });

    test('initial state is loading', () {
      final og = NewsHeadlineOg(repo: repo);
      addTearDown(og.dispose);

      expect(og.state.isLoading, isTrue);
    });

    test('checkForUpdates skips when no sectors infected', () async {
      await runScoped(() async {
        // infectedSectors is empty by default - do not infect any
        when(
          () => repo.getNewsEvent(
            negativeBias: any(named: 'negativeBias'),
            eligibleSectors: any(named: 'eligibleSectors'),
          ),
        ).thenAnswer((_) async => throw StateError('Should not be called'));

        final og = NewsHeadlineOg(repo: repo);
        addTearDown(og.dispose);

        og.events.init();
        og.events.checkForUpdates();

        await Future<void>.delayed(Duration.zero);

        expect(og.state.isLoading, isTrue);
        verifyNever(
          () => repo.getNewsEvent(
            negativeBias: any(named: 'negativeBias'),
            eligibleSectors: any(named: 'eligibleSectors'),
          ),
        );
      }, values: {...application.providers});
    });

    test('checkForUpdates emits Ready with newsEvent from repo', () async {
      const newsEvent = NewsEvent(
        headline: 'Breaking: Test News',
        impact: _zeroImpact,
        affectedSectors: _emptySectors,
      );
      when(
        () => repo.getNewsEvent(
          negativeBias: any(named: 'negativeBias'),
          eligibleSectors: any(named: 'eligibleSectors'),
        ),
      ).thenAnswer((_) async => newsEvent);

      await runScoped(() async {
        gameConfigOg.events.infectSector(WorldSectors.na);

        final og = NewsHeadlineOg(repo: repo);
        addTearDown(og.dispose);

        og.events.init();
        og.events.checkForUpdates();

        await Future<void>.delayed(Duration.zero);

        expect(og.state.isReady, isTrue);
        expect(og.state.asIfReady?.data, newsEvent);
        verify(
          () => repo.getNewsEvent(
            negativeBias: any(named: 'negativeBias'),
            eligibleSectors: any(named: 'eligibleSectors'),
          ),
        ).called(2); // init + explicit checkForUpdates
      }, values: {...application.providers});
    });

    test(
      'checkForUpdates does not emit when no sectors are infected',
      () async {
        when(
          () => repo.getNewsEvent(
            negativeBias: any(named: 'negativeBias'),
            eligibleSectors: any(named: 'eligibleSectors'),
          ),
        ).thenAnswer(
          (_) async => const NewsEvent(
            headline: 'Should not appear',
            impact: _zeroImpact,
            affectedSectors: [],
          ),
        );

        await runScoped(() async {
          gameConfigOg.events.clearInfectedSectors();
          final og = NewsHeadlineOg(repo: repo);
          addTearDown(og.dispose);

          og.events.init();
          og.events.checkForUpdates();

          await Future<void>.delayed(Duration.zero);

          expect(og.state.isReady, isFalse);
          verifyNever(
            () => repo.getNewsEvent(
              negativeBias: any(named: 'negativeBias'),
              eligibleSectors: any(named: 'eligibleSectors'),
            ),
          );
        }, values: {...application.providers});
      },
    );

    test('timer fires checkForUpdates after interval', () {
      fakeAsync((async) {
        runScoped(() {
          gameConfigOg.events.infectSector(WorldSectors.na);
          const newsEvent = NewsEvent(
            headline: 'Timer Fired Headline',
            impact: _zeroImpact,
            affectedSectors: [],
          );
          when(
            () => repo.getNewsEvent(
              negativeBias: any(named: 'negativeBias'),
              eligibleSectors: any(named: 'eligibleSectors'),
            ),
          ).thenAnswer((_) async => newsEvent);

          final og = NewsHeadlineOg(repo: repo);
          addTearDown(og.dispose);

          og.events.init();

          expect(og.state.isLoading, isTrue);

          async.elapse(const Duration(seconds: 15));
          async.flushMicrotasks();

          expect(og.state.isReady, isTrue);
          expect(og.state.asIfReady?.data, newsEvent);
          verify(
            () => repo.getNewsEvent(
              negativeBias: any(named: 'negativeBias'),
              eligibleSectors: any(named: 'eligibleSectors'),
            ),
          ).called(2);
        }, values: {...application.providers});
      });
    });

    test('timer fires multiple times', () {
      fakeAsync((async) {
        runScoped(() {
          gameConfigOg.events.infectSector(WorldSectors.na);
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
            () => repo.getNewsEvent(
              negativeBias: any(named: 'negativeBias'),
              eligibleSectors: any(named: 'eligibleSectors'),
            ),
          ).thenAnswer((_) async => newsEvents[index++ % newsEvents.length]);

          final og = NewsHeadlineOg(repo: repo);
          addTearDown(og.dispose);

          og.events.init();

          async.flushMicrotasks();
          expect(og.state.asIfReady?.data.headline, 'Headline 1');

          async.elapse(const Duration(seconds: 15));
          async.flushMicrotasks();
          expect(og.state.asIfReady?.data.headline, 'Headline 2');

          verify(
            () => repo.getNewsEvent(
              negativeBias: any(named: 'negativeBias'),
              eligibleSectors: any(named: 'eligibleSectors'),
            ),
          ).called(2);
        }, values: {...application.providers});
      });
    });

    test('dispose cancels timer', () {
      fakeAsync((async) {
        runScoped(() {
          gameConfigOg.events.infectSector(WorldSectors.na);
          final completer = Completer<NewsEvent>();
          when(
            () => repo.getNewsEvent(
              negativeBias: any(named: 'negativeBias'),
              eligibleSectors: any(named: 'eligibleSectors'),
            ),
          ).thenAnswer((_) => completer.future);

          final og = NewsHeadlineOg(repo: repo);

          og.events.init();
          async.flushMicrotasks(); // Let _checkForUpdates start and await
          og.dispose();
          async.elapse(const Duration(minutes: 1));
          async.flushMicrotasks();

          expect(og.state.isLoading, isTrue);
          verify(
            () => repo.getNewsEvent(
              negativeBias: any(named: 'negativeBias'),
              eligibleSectors: any(named: 'eligibleSectors'),
            ),
          ).called(1);
        }, values: {...application.providers});
      });
    });
  });
}

class _MockNewsHeadlineRepo extends Mock implements data.NewsHeadlineRepo {}

const _zeroImpact = Impact(trustAi: 0, criticalThinking: 0);
const _emptySectors = <WorldSectors>[];
