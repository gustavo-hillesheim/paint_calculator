import 'package:fpdart/fpdart.dart';

import 'calculate_paint_needed_usecase.dart';
import '../entities/paint_bucket.dart';
import '../entities/wall.dart';
import '../failures/too_much_occupied_area_failure.dart';
import '../entities/room.dart';
import '../failures/wall_not_tall_enough_failure.dart';
import '../failures/wall_too_big_failure.dart';
import '../failures/wall_too_small_failure.dart';
import '../../../../core/failure.dart';

const kMinimumArea = 1.0;
const kMaximumArea = 15.0;
const kMinimumVerticalPaddingForDoors = 0.3;
const kAreaCoveredByPaintLiter = 5;
const kAvailablePaintBuckets = [
  PaintBucket(liters: 18),
  PaintBucket(liters: 3.6),
  PaintBucket(liters: 2.5),
  PaintBucket(liters: 0.5),
];

class CalculatePaintNeededUseCaseImpl implements CalculatePaintNeededUseCase {
  @override
  Future<Either<Failure, List<PaintBucketNeeded>>> call(Room room) async {
    return _validate(room).bind((_) => Right(_calculatePaintBucketsNeeded(room)));
  }

  Either<Failure, void> _validate(Room room) {
    for (int i = 0; i < room.walls.length; i++) {
      final wall = room.walls[i];
      final wallIdentifier = i + 1;
      final wallArea = wall.area;
      if (wallArea < kMinimumArea) {
        return Left(WallTooSmallFailure(
          identifier: wallIdentifier,
          minimumArea: kMinimumArea,
          actualArea: wallArea,
        ));
      }
      if (wallArea > kMaximumArea) {
        return Left(WallTooBigFailure(
          identifier: wallIdentifier,
          maximumArea: kMaximumArea,
          actualArea: wallArea,
        ));
      }
      final maximumOccupiedArea = wallArea / 2;
      if (wall.occupiedArea > maximumOccupiedArea) {
        return Left(TooMuchOccupiedAreaFailure(
          identifier: wallIdentifier,
          maximumArea: maximumOccupiedArea,
          actualArea: wall.occupiedArea,
        ));
      }
      if (wall.doorsQuantity > 0 && wall.height < kDoorHeight + kMinimumVerticalPaddingForDoors) {
        return Left(WallNotTallEnoughFailure(
          identifier: wallIdentifier,
          minimumHeight: kDoorHeight + kMinimumVerticalPaddingForDoors,
          actualHeight: wall.height,
        ));
      }
    }
    return const Right(null);
  }

  List<PaintBucketNeeded> _calculatePaintBucketsNeeded(Room room) {
    final result = <PaintBucketNeeded>[];
    var remainingAreaToPaint = room.paintableArea;

    for (int i = 0; i < kAvailablePaintBuckets.length; i++) {
      final paintBucket = kAvailablePaintBuckets[i];
      final areaCoveredByBucket = paintBucket.liters * kAreaCoveredByPaintLiter;
      var bucketsUsed = remainingAreaToPaint ~/ areaCoveredByBucket;

      if (bucketsUsed > 0) {
        remainingAreaToPaint -= bucketsUsed * areaCoveredByBucket;
        _addBuckets(paintBucket, bucketsUsed, result);
      }
    }
    if (remainingAreaToPaint > 0) {
      final smallestPaintBucket = kAvailablePaintBuckets.last;
      _addBuckets(smallestPaintBucket, 1, result);
    }

    return _groupSmallerBucketsInBiggerOnes(result);
  }

  void _addBuckets(PaintBucket bucket, int quantity, List<PaintBucketNeeded> bucketList) {
    final containsBucket = bucketList.any((pbn) => pbn.bucket == bucket);
    if (containsBucket) {
      final existingBucketsNeededIndex = bucketList.indexWhere((pbn) => pbn.bucket == bucket);
      final existingBucketsNeeded = bucketList[existingBucketsNeededIndex];
      bucketList[existingBucketsNeededIndex] = PaintBucketNeeded(
        quantity: existingBucketsNeeded.quantity + quantity,
        bucket: bucket,
      );
    } else {
      bucketList.add(PaintBucketNeeded(quantity: quantity, bucket: bucket));
    }
  }

  List<PaintBucketNeeded> _groupSmallerBucketsInBiggerOnes(List<PaintBucketNeeded> bucketList) {
    final result = <PaintBucketNeeded>[];

    bucketList.sort(_smallToBigBucketSorter);
    for (final bucketsNeeded in bucketList) {
      final totalLitersNeeded = bucketsNeeded.quantity * bucketsNeeded.bucket.liters;
      bool foundReplacement = false;
      for (final availableBucket in kAvailablePaintBuckets) {
        if (bucketsNeeded.bucket.liters >= availableBucket.liters) {
          continue;
        }
        final fillsBiggerBucketCompletely = totalLitersNeeded % availableBucket.liters == 0;
        if (fillsBiggerBucketCompletely) {
          foundReplacement = true;
          _addBuckets(availableBucket, 1, result);
          break;
        }
      }
      if (!foundReplacement) {
        _addBuckets(bucketsNeeded.bucket, bucketsNeeded.quantity, result);
      }
    }

    return result..sort(_bigToSmallBucketSorter);
  }

  int _smallToBigBucketSorter(PaintBucketNeeded pbn1, PaintBucketNeeded pbn2) =>
      pbn1.bucket.liters < pbn2.bucket.liters ? -1 : 1;

  int _bigToSmallBucketSorter(PaintBucketNeeded pbn1, PaintBucketNeeded pbn2) =>
      pbn1.bucket.liters < pbn2.bucket.liters ? 1 : -1;
}
