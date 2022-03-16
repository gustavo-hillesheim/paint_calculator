import '../../../../core/failure.dart';

class WallTooSmallFailure extends Failure {
  @override
  final String message;
  final int identifier;
  final double minimumArea;
  final double actualArea;

  const WallTooSmallFailure({
    required this.identifier,
    required this.minimumArea,
    required this.actualArea,
  }) : message =
            'A parede $identifier é muito pequena. Tamanho mínimo: ${minimumArea}m³. Tamanho real: ${actualArea}m³';

  @override
  List<Object?> get props => [message, identifier, minimumArea, actualArea];
}
