class Parser {
  static int? integerNumber(String value) {
    return int.tryParse(value.replaceAll(',', '.'));
  }

  static double? decimalNumber(String value) {
    return double.tryParse(value.replaceAll(',', '.'));
  }
}
