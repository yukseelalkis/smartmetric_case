import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartmetric_case/feature/view/auth/login_view.dart';
import 'package:smartmetric_case/feature/viewmodel/login_view_model.dart';

/// [LoginViewMixin] is a [State] mixin that contains the login view logic.
mixin LoginViewMixin on State<LoginView> {
  /// [_loginFormKey] is the key for the login form.
  late final GlobalKey<FormState> _loginFormKey;

  /// [loginFormKey] is the key for the login form.
  GlobalKey<FormState> get loginFormKey => _loginFormKey;

  /// [_loginViewModel] is the view model for the login view.
  late final LoginViewModel _loginViewModel;

  /// [loginViewModel] is the view model for the login view.
  LoginViewModel get loginViewModel => _loginViewModel;

  @override
  void initState() {
    super.initState();
    _loginFormKey = GlobalKey<FormState>();
    _loginViewModel = LoginViewModel();
  }

  @override
  void dispose() {
    _loginFormKey.currentState?.dispose();
    super.dispose();
  }
}
