import 'package:domain/src/models/pipes.dart';
import 'package:equatable/equatable.dart';

part 'info_dot.g.dart';

class InfoDot extends Equatable {
  InfoDot({required this.dot, required this.pipe}) : id = _id++;

  static int _id = 0;

  final PipeDot dot;
  final Pipe pipe;
  final int id;

  @override
  List<Object?> get props => _$props;
}
