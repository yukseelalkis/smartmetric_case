import 'package:common/common.dart';
import 'package:flutter/material.dart';

/// Custom theme configurations for specific widgets
@immutable
final class CustomWidgetThemes {
  const CustomWidgetThemes._();

  /// Elevated button specific theme
  static ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colorScheme) =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(colorScheme.tertiary),
          foregroundColor: WidgetStateProperty.all(colorScheme.onPrimary),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusManager.normalBorderRadius,
            ),
          ),
        ),
      );

  /// Outlined button specific theme
  static OutlinedButtonThemeData outlinedButtonTheme(ColorScheme colorScheme) =>
      OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(colorScheme.surface),
          foregroundColor: WidgetStateProperty.all(colorScheme.onSurface),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusManager.normalBorderRadius,
            ),
          ),
        ),
      );

  /// Text button specific theme
  static DrawerThemeData drawerTheme(ColorScheme colorScheme) =>
      DrawerThemeData(
        elevation: 0,
        shape: const RoundedRectangleBorder(),
        backgroundColor: colorScheme.surface,
      );

  /// Text button specific theme
  static ListTileThemeData listTileTheme(ColorScheme colorScheme) =>
      ListTileThemeData(
        selectedColor: colorScheme.primary,
        iconColor: colorScheme.primary,
        textColor: colorScheme.primary,
        style: ListTileStyle.drawer, // Added titleTextStyle
      );
}
