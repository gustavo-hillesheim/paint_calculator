import '../../../../core/failure.dart';

class TooMuchOccupiedAreaFailure extends Failure {
  @override
  final String message;
  final int identifier;
  final double maximumArea;
  final double actualArea;

  const TooMuchOccupiedAreaFailure({
    required this.identifier,
    required this.maximumArea,
    required this.actualArea,
  }) : message =
            'A parede $identifier está muito ocupada por portas ou janelas. Área máxima que pode ser ocupada: ${maximumArea}m³. Área ocupada: ${actualArea}m³';

  @override
  List<Object?> get props => [message, identifier, maximumArea, actualArea];
}
