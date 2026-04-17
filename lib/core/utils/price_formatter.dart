class PriceFormatter {
  const PriceFormatter._();

  static String format(double value) {
    return '\$${value.toStringAsFixed(2)}';
  }
}
