import '../../../../core/failure.dart';

class WallTooBigFailure extends Failure {
  @override
  final String message;
  final int identifier;
  final double maximumArea;
  final double actualArea;

  const WallTooBigFailure({
    required this.identifier,
    required this.maximumArea,
    required this.actualArea,
  }) : message = 'A parede $identifier é muito grande. Tamanho máximo: ${maximumArea}m³. Tamanho real: ${actualArea}m³';

  @override
  List<Object?> get props => [message, identifier, maximumArea, actualArea];
}
