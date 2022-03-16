import 'package:equatable/equatable.dart';

const kDoorWidth = 0.8;
const kDoorHeight = 1.9;
const kDoorArea = kDoorWidth * kDoorHeight;
const kWindowWidth = 2.0;
const kWindowHeight = 1.2;
const kWindowArea = kWindowWidth * kWindowHeight;

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

  double get area => height * width;

  double get occupiedArea => doorsQuantity * kDoorArea + windowsQuantity * kWindowArea;

  double get paintableArea => area - occupiedArea;

  @override
  List<Object?> get props => [height, width, windowsQuantity, doorsQuantity];
}
