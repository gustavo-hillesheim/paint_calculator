import 'package:equatable/equatable.dart';

class Wall extends Equatable {
  final double height;
  final double width;
  final int windowsQuantity;
  final int doorsQuantity;

  const Wall({
    required this.height,
    required this.width,
    required this.windowsQuantity,
    required this.doorsQuantity,
  });

  @override
  List<Object?> get props => [height, width, windowsQuantity, doorsQuantity];
}
