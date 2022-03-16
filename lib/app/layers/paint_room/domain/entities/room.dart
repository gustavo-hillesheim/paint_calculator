import 'package:equatable/equatable.dart';

import 'wall.dart';

class Room extends Equatable {
  final List<Wall> walls;

  const Room({required this.walls});

  @override
  List<Object?> get props => [walls];
}
