import 'package:flutter/services.dart';
class USPhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Get only numbers from the new value
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Maximum 10 digits
    final limitedDigits =
    digits.length > 10 ? digits.substring(0, 10) : digits;

    String formatted = '';

    for (int i = 0; i < limitedDigits.length; i++) {
      if (i == 0) {
        formatted += '(';
      }

      formatted += limitedDigits[i];

      if (i == 2) {
        formatted += ') ';
      }

      if (i == 5) {
        formatted += '-';
      }
    }

    // Calculate cursor position
    int cursorPosition = newValue.selection.baseOffset;

    if (cursorPosition < 0) {
      cursorPosition = formatted.length;
    }

    final digitsBeforeCursor = newValue.text
        .substring(
      0,
      cursorPosition.clamp(0, newValue.text.length),
    )
        .replaceAll(RegExp(r'\D'), '')
        .length;

    int newCursorPosition = 0;
    int digitCount = 0;

    for (int i = 0; i < formatted.length; i++) {
      if (RegExp(r'\d').hasMatch(formatted[i])) {
        digitCount++;
      }

      newCursorPosition = i + 1;

      if (digitCount >= digitsBeforeCursor) {
        break;
      }
    }

    if (digitsBeforeCursor == 0) {
      newCursorPosition = 0;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: newCursorPosition.clamp(0, formatted.length),
      ),
    );
  }
}