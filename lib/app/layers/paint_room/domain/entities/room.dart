import 'package:equatable/equatable.dart';

import 'wall.dart';

class Room extends Equatable {
  final List<Wall> walls;

  const Room({required this.walls});

  double get paintableArea => walls.map((w) => w.paintableArea).fold(0, (acc, n) => acc + n);

  @override
  List<Object?> get props => [walls];
}
