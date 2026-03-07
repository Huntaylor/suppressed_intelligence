import 'dart:async';

import 'package:meta/meta.dart';

typedef Emitter<State> = void Function(State);

typedef EventHandler<Event, State> =
    FutureOr<void> Function(Event event, Emitter<State> emit);

abstract class Og<Event, State> {
  Og(this._state);

  // ignore: prefer_final_fields
  State _state;

  State get state => _state;

  final Map<Type, EventHandler<Event, State>> _eventHandlers = {};

  void on<T extends Event>(EventHandler<T, State> handler) {
    _eventHandlers[T] = (event, emit) => handler(event as T, emit);
  }

  @mustCallSuper
  void dispose() {}

  @internal
  void add(Event event) {
    if (_eventHandlers[event.runtimeType] case final handler?) {
      handler(event, _emitter);
    } else {
      throw UnimplementedError('No handler for event: ${event.runtimeType}');
    }
  }

  void _emitter(State newState) {
    if (newState == _state) return;

    _state = newState;
  }
}
