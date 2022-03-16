import 'package:paint_calculator/app/layers/paint_room/domain/entities/room.dart';
import 'package:paint_calculator/app/layers/paint_room/domain/entities/wall.dart';
import 'package:test/test.dart';

void main() {
  test('paintableArea SHOULD be the sum of paintable area of the walls', () {
    const room = Room(walls: [
      Wall(height: 2, width: 2, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 2, width: 3, windowsQuantity: 0, doorsQuantity: 0),
      Wall(height: 2, width: 4, windowsQuantity: 0, doorsQuantity: 0),
    ]);

    expect(room.paintableArea, 18);
  });
}
