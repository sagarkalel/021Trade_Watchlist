abstract class NumberFormatter {
  /// Formating with commas (e.g. 1,47,625.00)
  static String formatWithCommas(double value) {
    final bool isNegative = value < 0;
    final List<String> parts = value.abs().toStringAsFixed(2).split('.');
    String integerPart = parts[0];
    final String decimalPart = parts[1];

    if (integerPart.length <= 3) {
      return '${isNegative ? '-' : ''}$integerPart.$decimalPart';
    }

    final String lastThree = integerPart.substring(integerPart.length - 3);
    final String remaining = integerPart.substring(0, integerPart.length - 3);

    final StringBuffer buf = StringBuffer();
    for (int i = 0; i < remaining.length; i++) {
      if (i > 0 && (remaining.length - i) % 2 == 0) buf.write(',');
      buf.write(remaining[i]);
    }
    buf.write(',$lastThree.$decimalPart');

    return '${isNegative ? '-' : ''}${buf.toString()}';
  }

  /// Returns "+12.50 (0.09%)" or "4.50 (-0.33%)"
  static String formatChange(double change, double changePct) {
    final String pctSign = changePct >= 0 ? '' : '-';
    final String absChange = change.abs().toStringAsFixed(2);
    final String absPct = changePct.abs().toStringAsFixed(2);
    return '$absChange ($pctSign$absPct%)';
  }
}
