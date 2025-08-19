import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// [CustomTextTheme] is a class that provides the text theme of the application.
final class CustomTextTheme {
  const CustomTextTheme._();

  /// [createTextTheme] is a function that creates the text theme of the application.
  static TextTheme createTextTheme(
    BuildContext context,
    String bodyFontString,
    String displayFontString,
  ) {
    final baseTextTheme = Theme.of(context).textTheme;

    final bodyTextTheme =
        GoogleFonts.getTextTheme(bodyFontString, baseTextTheme); // Body
    final displayTextTheme =
        GoogleFonts.getTextTheme(displayFontString, baseTextTheme); // Header
    final textTheme = displayTextTheme.copyWith(
      bodyLarge: bodyTextTheme.bodyLarge,
      bodyMedium: bodyTextTheme.bodyMedium,
      bodySmall: bodyTextTheme.bodySmall,
      labelLarge: bodyTextTheme.labelLarge,
      labelMedium: bodyTextTheme.labelMedium,
      labelSmall: bodyTextTheme.labelSmall,
    );
    return textTheme;
  }
}
