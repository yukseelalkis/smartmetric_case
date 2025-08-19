import 'package:common/common.dart';
import 'package:flutter/material.dart';

/// [CommonViewMixin] is a [State] mixin that contains the common view logic
mixin CommonViewMixin<T extends StatefulWidget> on State<T> {
  /// [gestureOnTap] is a method that removes the focus from
  /// the current focus node.
  void gestureOnTap(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  /// [isFormValid] is a method that checks if the login form is valid.
  bool isFormValid(GlobalKey<FormState> formKey) {
    if (formKey.hasValue && formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }
}
