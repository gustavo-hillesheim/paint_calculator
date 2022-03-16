import 'package:paint_calculator/app/core/failure.dart';

class WallNotTallEnoughFailure extends Failure {
  @override
  final String message;
  final int identifier;
  final double minimumHeight;
  final double actualHeight;

  const WallNotTallEnoughFailure({
    required this.identifier,
    required this.minimumHeight,
    required this.actualHeight,
  }) : message =
            'A parede $identifier não é alta o suficiente para ter portas. Altura mínima: ${minimumHeight}m. Altura real: ${actualHeight}m';

  @override
  List<Object?> get props => [message, identifier, minimumHeight, actualHeight];
}
