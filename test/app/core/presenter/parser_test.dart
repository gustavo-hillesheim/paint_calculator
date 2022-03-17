import 'package:paint_calculator/app/core/presenter/parser.dart';
import 'package:test/test.dart';

void main() {
  group('integerNumber', () {
    test('SHOULD parse numbers correctly', () {
      expect(Parser.integerNumber('10'), 10);
      expect(Parser.integerNumber('10,0'), null);
      expect(Parser.integerNumber('10.0'), null);
    });
  });
  group('decimalNumber', () {
    test('SHOULD parse numbers correctly', () {
      expect(Parser.decimalNumber('10'), 10.0);
      expect(Parser.decimalNumber('9,0'), 9.0);
      expect(Parser.decimalNumber('9,5'), 9.5);
      expect(Parser.decimalNumber('9.0'), 9.0);
    });
  });
}
