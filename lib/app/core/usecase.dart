import 'package:fpdart/fpdart.dart';

import 'failure.dart';

abstract class UseCase<Input, Output> {
  Future<Either<Failure, Output>> call(Input input);
}

/// Used when a [UseCase] receives no input.
class NoParams {
  const NoParams();
}
