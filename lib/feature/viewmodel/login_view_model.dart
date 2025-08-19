import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gen/gen.dart';
import 'package:logger/logger.dart';
import 'package:smartmetric_case/feature/view/auth/auth_repository.dart';
import 'package:smartmetric_case/product/init/cache/cache_manager.dart';
import 'package:smartmetric_case/product/service/mock_service/mock_service.dart';
import 'package:smartmetric_case/product/state/base/base_cubit';
import 'package:smartmetric_case/product/state/login_state.dart';
import 'package:smartmetric_case/product/utility/constant/enums/cache_allow_list.dart';
import 'package:smartmetric_case/product/utility/constant/enums/status_code.dart';
import 'package:smartmetric_case/product/utility/response/api_response.dart';

/// [LoginViewModel] is the view model for the login view.
final class LoginViewModel extends BaseCubit<LoginState> {
  /// Constructor
  LoginViewModel() : super(const LoginState());

  void _changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  final _repo = const AuthRepository();

  Future<ApiResponse<LoginResponse>> login({
    required LoginRequest loginRequest,
  }) async {
    _changeLoading();
    try {
      final res = await _repo.login(loginRequest);
      _changeLoading();
      return res;
    } catch (e) {
      _changeLoading();
      return ApiResponse.failure(
          error: e.toString(), result: HttpResult.unknown);
    }
  }

  Future<void> setRememberMeToSP({required bool rememberMe}) async {
    await CacheManager.instance
        .setBool(CacheAllowListEnum.rememberMe.name, value: rememberMe);
  }

  Future<void> setTokenToSP({required String token}) async {
    await CacheManager.instance
        .setString(CacheAllowListEnum.token.name, value: token);
  }
}
