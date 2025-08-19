import 'package:gen/gen.dart';
import 'package:logger/logger.dart';
import 'package:smartmetric_case/product/init/cache/cache_manager.dart';
import 'package:smartmetric_case/product/service/common_service.dart';
import 'package:smartmetric_case/product/state/base/base_cubit';
import 'package:smartmetric_case/product/state/login_state.dart';
import 'package:smartmetric_case/product/utility/constant/enums/cache_allow_list.dart';
import 'package:smartmetric_case/product/utility/response/api_response.dart';

/// [LoginViewModel] is the view model for the login view.
final class LoginViewModel extends BaseCubit<LoginState> {
  /// Constructor
  LoginViewModel() : super(const LoginState());

  void _changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  Future<ApiResponse<LoginResponse>> login(
      {required LoginRequest loginRequest}) async {
    _changeLoading();
    try {
      var response =
          await CommonService.instance.postModel<LoginRequest, LoginResponse>(
        domain: DevEnv().postAuthLoginDomain,
        model: loginRequest,
        fromJson: (json) => LoginResponse.fromJson(json),
      );

      _changeLoading();

      return response;
    } catch (e) {
      Logger().e(e.toString());
      rethrow;
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
