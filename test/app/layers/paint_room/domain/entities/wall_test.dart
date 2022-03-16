import 'package:paint_calculator/app/layers/paint_room/domain/entities/wall.dart';
import 'package:test/test.dart';

void main() {
  test('area SHOULD be the product of the width and height', () {
    const wall = Wall(height: 3.5, width: 4, windowsQuantity: 0, doorsQuantity: 0);

    expect(wall.area, 14);
  });

  test('occupiedArea SHOULD be the sum of total doors area and total windows area', () {
    const wall = Wall(height: 2, width: 6, windowsQuantity: 2, doorsQuantity: 1);

    expect(wall.occupiedArea, 2 * kWindowArea + 1 * kDoorArea);
  });

  test('paintableArea SHOULD be area minus occupiedArea', () {
    const wall = Wall(height: 2, width: 10, windowsQuantity: 2, doorsQuantity: 1);

    expect(wall.paintableArea, 20 - (2 * kWindowArea + 1 * kDoorArea));
  });
}
