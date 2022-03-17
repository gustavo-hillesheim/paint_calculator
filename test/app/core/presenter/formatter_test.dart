import 'package:paint_calculator/app/core/presenter/formatter.dart';
import 'package:test/test.dart';

void main() {
  group('simpleNumber', () {
    test('SHOULD format numbers correctly', () {
      expect(Formatter.simpleNumber(3), '3');
      expect(Formatter.simpleNumber(3.50), '3,5');
      expect(Formatter.simpleNumber(3.25), '3,25');
      expect(Formatter.simpleNumber(3.10002), '3,1');
    });
  });
}
