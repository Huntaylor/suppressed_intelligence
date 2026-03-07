library game_object;

import 'package:scoped_deps/scoped_deps.dart';

part 'game_event.dart';
part 'game_state.dart';

final gameObjectProvider = create(GameObject.new);
GameObject get gameObject => read(gameObjectProvider);

class GameObject extends OG<GameEvent, GameState> {
  GameObject() : super(const _Loading());

  late final events = _Events(this);

  void _load(_Load event, Emitter<GameState> emit) {
    emit(const _Ready(score: 0));
  }
}

typedef Emitter<T> = void Function(T);

abstract class OG<Event, State> {
  OG(this._state);

  // ignore: prefer_final_fields
  State _state;

  State get state => _state;

  void _emitter(State state) {
    _state = state;
  }
}
