import 'package:flutter/widgets.dart';

import 'parser.dart';

class Validator {
  static FormFieldValidator<String> integerNumber({bool positive = false}) => (String? value) {
        if (value == null) {
          return 'O valor é obrigatório';
        }
        final asInt = Parser.integerNumber(value);
        if (asInt == null) {
          return 'O valor deve ser um número inteiro';
        }
        if (asInt < 0 && positive) {
          return 'O valor deve ser um número positivo';
        }
        return null;
      };

  static FormFieldValidator<String> decimalNumber({bool positive = false}) => (String? value) {
        if (value == null) {
          return 'O valor é obrigatório';
        }
        final asDouble = Parser.decimalNumber(value);
        if (asDouble == null) {
          return 'O valor deve ser um número decimal';
        }
        if (asDouble < 0 && positive) {
          return 'O valor deve ser um número positivo';
        }
        return null;
      };
}
