import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../core/failure.dart';
import '../../domain/entities/room.dart';
import '../../domain/usecases/calculate_paint_needed_usecase.dart';

class PaintForRoomCalculationController {
  final _streamController = StreamController<Either<Failure, List<PaintBucketNeeded>>>.broadcast();

  final CalculatePaintNeededUseCase _calculatePaintNeededUseCase;

  PaintForRoomCalculationController(this._calculatePaintNeededUseCase);

  Stream<Either<Failure, List<PaintBucketNeeded>>> get stream => _streamController.stream;

  void close() {
    _streamController.close();
  }

  Future<Either<Failure, List<PaintBucketNeeded>>> calculate(Room room) async {
    final result = await _calculatePaintNeededUseCase(room);
    _streamController.sink.add(result);
    return result;
  }
}
