import 'package:flutter/widgets.dart';
import 'package:paint_calculator/app/core/presenter/validator.dart';
import 'package:test/test.dart';

void main() {
  group('integerNumber', () {
    late FormFieldValidator<String> validator;

    setUp(() {
      validator = Validator.integerNumber();
    });

    test('SHOULD not accepted null values', () {
      expect(validator(null), isNotNull);
    });

    test('SHOULD not accepted non integer numbers', () {
      expect(validator('1,0'), isNotNull);
    });
    test('WHEN positive is true SHOULD not accepted less than 0', () {
      final validator = Validator.integerNumber(positive: true);
      expect(validator('-1'), isNotNull);
    });
    test('SHOULD accepted integer numbers', () {
      expect(validator('1'), isNull);
    });
  });
  group('decimalNumber', () {
    late FormFieldValidator<String> validator;

    setUp(() {
      validator = Validator.decimalNumber();
    });

    test('SHOULD not accepted null values', () {
      expect(validator(null), isNotNull);
    });

    test('SHOULD not accepted non decimal numbers', () {
      expect(validator('a'), isNotNull);
    });
    test('WHEN positive is true SHOULD not accepted less than 0', () {
      final validator = Validator.decimalNumber(positive: true);
      expect(validator('-1'), isNotNull);
    });
    test('SHOULD accepted decimal numbers', () {
      expect(validator('1,5'), isNull);
    });
  });
}
