import 'package:equatable/equatable.dart';

class PaintBucket extends Equatable {
  final double liters;

  const PaintBucket({required this.liters});

  @override
  List<Object?> get props => [liters];
}
