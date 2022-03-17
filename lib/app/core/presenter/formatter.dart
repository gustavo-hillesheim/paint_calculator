class Formatter {
  static String simpleNumber(num number) {
    String asString = number.toStringAsFixed(2).replaceAll('.', ',');
    while (asString.endsWith('0')) {
      asString = asString.substring(0, asString.length - 1);
    }
    if (asString.endsWith(',')) {
      asString = asString.substring(0, asString.length - 1);
    }
    return asString;
  }
}
