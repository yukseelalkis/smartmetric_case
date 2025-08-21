import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:common/common.dart';
import 'package:smartmetric_case/feature/view/auth/sign_up_view.dart';
import 'package:smartmetric_case/feature/viewmodel/signup_view_model.dart';
import 'package:smartmetric_case/product/init/language/locale_keys.g.dart';

/// [SignUpViewMixin] is a [State] mixin that contains the login view logic.
mixin SignUpViewMixin on State<SignUpView> {
  /// [_signupFormKey] is the key for the login form.
  late final GlobalKey<FormState> _signupFormKey;

  /// [_signUpViewModel] is the view model for the sign up view.
  late final SignUpViewModel _signUpViewModel;

  /// [_fullnameController] is the controller for the fullname text field.
  late final TextEditingController _fullnameController;

  /// [_confirmPasswordController] is the controller for the password text field.
  late final TextEditingController _confirmPasswordController;

  /// [signupFormKey] is the key for the login form.
  GlobalKey<FormState> get signupFormKey => _signupFormKey;

  /// [signupViewModel] is the view model for the sign up view.
  SignUpViewModel get signupViewModel => _signUpViewModel;

  /// [fullnameController] is the controller for the fullname text field.
  TextEditingController get fullnameController => _fullnameController;

  /// [confirmPasswordController] is the controller for the password text field.
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _signupFormKey = GlobalKey<FormState>();
    _signUpViewModel = SignUpViewModel();
    _fullnameController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  

  @override
  void dispose() {
    _fullnameController.dispose();
    _confirmPasswordController.dispose();
    _signupFormKey.currentState?.dispose();
    super.dispose();
  }

  /// [fullnameValidator] is validator for fullname field
  String? fullnameValidator(String? value) =>
      !value.isBlank ? null : LocaleKeys.auth_fullname_required.tr();

  /// [confirmPasswordValidator] is validator for confirm password field
  String? confirmPasswordValidator(String? value, String password) =>
      value.isBlank
          ? LocaleKeys.auth_password_required.tr()
          : value == password
              ? null
              : LocaleKeys.auth_the_passwords_do_not_match.tr();
}
