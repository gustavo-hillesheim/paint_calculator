import 'package:equatable/equatable.dart';

import '../../../../core/usecase.dart';
import '../entities/paint_bucket.dart';
import '../entities/room.dart';

abstract class CalculatePaintNeededUseCase extends UseCase<Room, List<PaintBucketNeeded>> {}

class PaintBucketNeeded extends Equatable {
  final int quantity;
  final PaintBucket bucket;

  const PaintBucketNeeded({required this.quantity, required this.bucket});

  @override
  List<Object?> get props => [quantity, bucket];
}
