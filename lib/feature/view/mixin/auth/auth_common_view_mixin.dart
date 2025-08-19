import 'package:common/common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartmetric_case/product/init/language/locale_keys.g.dart';
import 'package:smartmetric_case/product/utility/constant/lawai_regexp.dart';


/// [AuthCommonViewMixin] is a [State] mixin that contains the login view logic.
mixin AuthCommonViewMixin<T extends StatefulWidget> on State<T> {
  /// [_emailController] is the controller for the email text field.
  late final TextEditingController _emailController;

  /// [_passwordController] is the controller for the password text field.
  late final TextEditingController _passwordController;

  /// [emailController] is the controller for the email text field.
  TextEditingController get emailController => _emailController;

  /// [passwordController] is the controller for the password text field.
  TextEditingController get passwordController => _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// [emailValidator] is validator for email field
  String? emailValidator(String? value) => value.isBlank
      ? LocaleKeys.auth_email_required.tr()
      : NodeLabsCaseRegExp().emailRegexp.hasMatch(value!)
          ? null
          : LocaleKeys.auth_valid_email.tr();

  /// [passwordValidator] is validator for password field
  String? passwordValidator(String? value) => value.isBlank
      ? LocaleKeys.auth_password_required.tr()
      : NodeLabsCaseRegExp().passwordRegexp.hasMatch(value!)
          ? null
          : LocaleKeys.auth_valid_password.tr();
}