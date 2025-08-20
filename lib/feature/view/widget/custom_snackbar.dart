import 'package:flutter/material.dart';
import 'package:smartmetric_case/product/utility/constant/enums/duration.dart';
import 'package:smartmetric_case/product/utility/constant/enums/response_type.dart';

/// [CustomSnackbar] is a custom snackbar widget. it will be used as general
@immutable
final class CustomSnackbar {
  const CustomSnackbar();

  /// [show] method is used to show the snackbar.
  static void show({
    required BuildContext context,
    required String message,
    DurationSeconds second = DurationSeconds.short,
    ResponseType responseType = ResponseType.success,
  }) {
    final colors = _getSnackbarColors(context, responseType);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: second.value),
        content: Center(
          child: Text(
            message,
            style: TextStyle(
              color: colors.text,
            ),
          ),
        ),
        backgroundColor: colors.background,
      ),
    );
  }

  static _SnackbarColors _getSnackbarColors(
      BuildContext context, ResponseType type) {
    final theme = Theme.of(context);

    switch (type) {
      case ResponseType.success:
        return _SnackbarColors(
          background: Colors.green,
          text: theme.colorScheme.onSecondary,
        );
      case ResponseType.error:
        return _SnackbarColors(
          background: Colors.red,
          text: theme.colorScheme.onSecondary,
        );
      case ResponseType.warning:
        return _SnackbarColors(
          background: Colors.orange,
          text: theme.colorScheme.primary,
        );
      case ResponseType.info:
        return _SnackbarColors(
          background: Colors.blue,
          text: theme.colorScheme.primary,
        );
      default:
        return _SnackbarColors(
          background: Colors.grey,
          text: theme.colorScheme.primary,
        );
    }
  }
}

/// Class to hold snackbar colors
@immutable
final class _SnackbarColors {
  const _SnackbarColors({required this.background, required this.text});

  final Color background;
  final Color text;
}
