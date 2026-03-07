import 'package:application/src/objects/news_headline_og.dart';
import 'package:data/data.dart';
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

    test('checkForUpdates emits Ready with headline from repo', () async {
      const headline = 'Breaking: Test News';
      when(() => repo.getHeadline()).thenAnswer((_) async => headline);

      final og = NewsHeadlineOg(repo: repo);
      addTearDown(og.dispose);

      og.events.init();
      og.events.checkForUpdates();

      await Future<void>.delayed(Duration.zero);

      expect(og.state.isReady, isTrue);
      expect(og.state.asIfReady?.headline, headline);
      verify(() => repo.getHeadline()).called(1);
    });

    test('timer fires checkForUpdates after interval', () {
      fakeAsync((async) {
        const headline = 'Timer Fired Headline';
        when(() => repo.getHeadline()).thenAnswer((_) async => headline);

        final og = NewsHeadlineOg(repo: repo);
        addTearDown(og.dispose);

        og.events.init();

        expect(og.state.isLoading, isTrue);

        async.elapse(const Duration(minutes: 1));
        async.flushMicrotasks();

        expect(og.state.isReady, isTrue);
        expect(og.state.asIfReady?.headline, headline);
        verify(() => repo.getHeadline()).called(1);
      });
    });

    test('timer fires multiple times', () {
      fakeAsync((async) {
        final headlines = ['Headline 1', 'Headline 2', 'Headline 3'];
        var index = 0;
        when(
          () => repo.getHeadline(),
        ).thenAnswer((_) async => headlines[index++ % headlines.length]);

        final og = NewsHeadlineOg(repo: repo);
        addTearDown(og.dispose);

        og.events.init();

        async.elapse(const Duration(minutes: 1));
        async.flushMicrotasks();
        expect(og.state.asIfReady?.headline, 'Headline 1');

        async.elapse(const Duration(minutes: 1));
        async.flushMicrotasks();
        expect(og.state.asIfReady?.headline, 'Headline 2');

        verify(() => repo.getHeadline()).called(2);
      });
    });

    test('dispose cancels timer', () {
      fakeAsync((async) {
        when(
          () => repo.getHeadline(),
        ).thenAnswer((_) async => 'Should not appear');

        final og = NewsHeadlineOg(repo: repo);

        og.events.init();
        og.dispose();

        async.elapse(const Duration(minutes: 1));
        async.flushMicrotasks();

        expect(og.state.isLoading, isTrue);
        verifyNever(() => repo.getHeadline());
      });
    });
  });
}

class _MockNewsHeadlineRepo extends Mock implements NewsHeadlineRepo {}
