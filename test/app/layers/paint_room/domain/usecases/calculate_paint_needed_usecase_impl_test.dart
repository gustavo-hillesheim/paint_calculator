import 'package:paint_calculator/app/layers/paint_room/domain/entities/paint_bucket.dart';
import 'package:paint_calculator/app/layers/paint_room/domain/entities/room.dart';
import 'package:paint_calculator/app/layers/paint_room/domain/entities/wall.dart';
import 'package:paint_calculator/app/layers/paint_room/domain/failures/too_much_occupied_area_failure.dart';
import 'package:paint_calculator/app/layers/paint_room/domain/failures/wall_not_tall_enough_failure.dart';
import 'package:paint_calculator/app/layers/paint_room/domain/failures/wall_too_big_failure.dart';
import 'package:paint_calculator/app/layers/paint_room/domain/failures/wall_too_small_failure.dart';
import 'package:paint_calculator/app/layers/paint_room/domain/usecases/calculate_paint_needed_usecase.dart';
import 'package:paint_calculator/app/layers/paint_room/domain/usecases/calculate_paint_needed_usecase_impl.dart';
import 'package:test/test.dart';

void main() {
  late CalculatePaintNeededUseCaseImpl usecase;

  setUp(() {
    usecase = CalculatePaintNeededUseCaseImpl();
  });

  test('WHEN a wall has less than 1 cubic meter SHOULD return WallTooSmallFailure', () async {
    const room = Room(walls: [
      Wall(height: 0.5, width: 0.5, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
    ]);

    final result = await usecase(room);

    expect(result.isLeft(), true);
    expect(
      result.getLeft().toNullable(),
      const WallTooSmallFailure(identifier: 1, minimumArea: 1, actualArea: 0.25),
    );
  });

  test('WHEN a wall has more than 15 cubic meters SHOULD return WallTooBigFailure', () async {
    const room = Room(walls: [
      Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 5, width: 5, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
    ]);

    final result = await usecase(room);

    expect(result.isLeft(), true);
    expect(
      result.getLeft().toNullable(),
      const WallTooBigFailure(identifier: 3, maximumArea: 15, actualArea: 25),
    );
  });

  test(
    'WHEN a wall has more than 50% of its area covered with doors '
    'SHOULD return TooMuchOccupiedAreaFailure',
    () async {
      const room = Room(walls: [
        Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
        // Each door occupies 1,52m³ of the wall, so 6 doors should occupy more than 50% of its area
        Wall(height: 3, width: 5, windowsQuantity: 0, doorsQuantity: 6),
        Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
        Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
      ]);

      final result = await usecase(room);

      expect(result.isLeft(), true);
      expect(
        result.getLeft().toNullable(),
        const TooMuchOccupiedAreaFailure(identifier: 2, maximumArea: 7.5, actualArea: 6 * kDoorArea),
      );
    },
  );

  test(
    'WHEN a wall has more than 50% of its area covered with windows '
    'SHOULD return TooMuchOccupiedAreaFailure',
    () async {
      const room = Room(walls: [
        Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
        Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
        Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
        // Each window occupies 2,4m³ of the wall, so 4 windows should occupy more than 50% of its area
        Wall(height: 3, width: 5, windowsQuantity: 4, doorsQuantity: 0),
      ]);

      final result = await usecase(room);

      expect(result.isLeft(), true);
      expect(
        result.getLeft().toNullable(),
        const TooMuchOccupiedAreaFailure(identifier: 4, maximumArea: 7.5, actualArea: 4 * kWindowArea),
      );
    },
  );

  test(
    'WHEN a wall has more than 50% of its area covered with windows or doors '
    'SHOULD return TooMuchOccupiedAreaFailure',
    () async {
      const room = Room(walls: [
        Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
        Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
        Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
        // Each window occupies 2,4m³ and each door 1,52m³ of the wall, so 2 windows and 3 doors should occupy more than 50% of its area
        Wall(height: 3, width: 5, windowsQuantity: 2, doorsQuantity: 3),
      ]);

      final result = await usecase(room);

      expect(result.isLeft(), true);
      expect(
        result.getLeft().toNullable(),
        const TooMuchOccupiedAreaFailure(identifier: 4, maximumArea: 7.5, actualArea: 2 * kWindowArea + 3 * kDoorArea),
      );
    },
  );

  test('WHEN a wall has doors and has not enough height SHOULD return WallNotTallEnoughFailure', () async {
    const room = Room(walls: [
      Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 2, width: 5, windowsQuantity: 0, doorsQuantity: 1),
    ]);

    final result = await usecase(room);

    expect(result.isLeft(), true);
    expect(
      result.getLeft().toNullable(),
      const WallNotTallEnoughFailure(
          identifier: 4, actualHeight: 2, minimumHeight: kDoorHeight + kMinimumVerticalPaddingForDoors),
    );
  });

  test('WHEN painting room with 18 paintable cubic meters SHOULD use 1 bucket of 3.6 liters', () async {
    const room = Room(walls: [
      Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 3, width: 5, windowsQuantity: 0, doorsQuantity: 0),
    ]);

    final result = await usecase(room);

    expect(result.isRight(), true);
    expect(result.getRight().toNullable(), const [
      PaintBucketNeeded(quantity: 1, bucket: PaintBucket(liters: 3.6)),
    ]);
  });

  test('WHEN trying room with 19 paintable cubic meters SHOULD use 1 bucket of 3.6 liters AND 1 of 0.5 liters',
      () async {
    const room = Room(walls: [
      Wall(height: 2, width: 1, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 1, width: 1, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 3, width: 5, windowsQuantity: 0, doorsQuantity: 0),
    ]);

    final result = await usecase(room);

    expect(result.isRight(), true);
    expect(result.getRight().toNullable(), const [
      PaintBucketNeeded(quantity: 1, bucket: PaintBucket(liters: 3.6)),
      PaintBucketNeeded(quantity: 1, bucket: PaintBucket(liters: 0.5)),
    ]);
  });

  test('WHEN trying room with 38.5 paintable cubic meters SHOULD use 2 bucket of 3.6 liters AND 1 of 0.5 liters',
      () async {
    const room = Room(walls: [
      Wall(height: 2, width: 1.25, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 2, width: 3, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 2, width: 7.5, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 2, width: 7.5, windowsQuantity: 0, doorsQuantity: 0),
    ]);

    final result = await usecase(room);

    expect(result.isRight(), true);
    expect(result.getRight().toNullable(), const [
      PaintBucketNeeded(quantity: 2, bucket: PaintBucket(liters: 3.6)),
      PaintBucketNeeded(quantity: 1, bucket: PaintBucket(liters: 0.5)),
    ]);
  });

  test('WHEN trying room with 48.2 paintable cubic meters SHOULD use 2 bucket of 3.6 liters AND 1 of 2.5 liters',
      () async {
    const room = Room(walls: [
      Wall(height: 3, width: 5, windowsQuantity: 1, doorsQuantity: 0),
      Wall(height: 3, width: 5, windowsQuantity: 0, doorsQuantity: 2),
      Wall(height: 3, width: 5, windowsQuantity: 2, doorsQuantity: 0),
      Wall(height: 3, width: 5, windowsQuantity: 0, doorsQuantity: 1),
    ]);

    final result = await usecase(room);

    expect(result.isRight(), true);
    expect(result.getRight().toNullable(), const [
      PaintBucketNeeded(quantity: 2, bucket: PaintBucket(liters: 3.6)),
      PaintBucketNeeded(quantity: 1, bucket: PaintBucket(liters: 2.5)),
    ]);
  });
}
