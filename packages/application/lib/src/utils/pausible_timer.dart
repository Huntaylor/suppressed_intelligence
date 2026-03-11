import 'dart:async';

class PausableTimer {
  PausableTimer(this.interval, this.onTick) : _remaining = interval;

  final Duration interval;
  final void Function() onTick;

  Timer? _timer;
  final Stopwatch _stopwatch = Stopwatch();
  Duration _remaining;

  bool _running = false;

  void start() {
    if (_running) return;
    _running = true;

    _stopwatch.start();
    _timer = Timer(_remaining, _tick);
  }

  void _tick() {
    _stopwatch.reset();
    onTick();

    if (!_running) return;

    _remaining = interval;
    _timer = Timer(interval, _tick);
  }

  void pause() {
    if (!_running) return;

    _timer?.cancel();
    _stopwatch.stop();

    _remaining -= _stopwatch.elapsed;
    _stopwatch.reset();

    _running = false;
  }

  void resume() {
    if (_running) return;

    _running = true;
    _stopwatch.start();
    _timer = Timer(_remaining, _tick);
  }

  void cancel() {
    _timer?.cancel();
    _stopwatch.stop();
    _stopwatch.reset();
    _remaining = interval;
    _running = false;
  }

  bool get isPaused => !isRunning;
  bool get isRunning => _running;
}
