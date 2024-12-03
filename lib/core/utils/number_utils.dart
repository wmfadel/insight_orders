class NumberUtils {
  static double removeFormatting(String formattedNumber) {
    // Remove the currency symbol (e.g., "$")
    String cleanedString = formattedNumber.replaceAll(RegExp(r'[^\d.]'), '');

    // Convert the cleaned string to a double
    return double.tryParse(cleanedString) ?? 0.0; // Return 0.0 if parsing fails
  }
}
