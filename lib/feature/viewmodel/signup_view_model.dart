import 'package:smartmetric_case/product/service/mock_service/mock_service.dart';
import 'package:smartmetric_case/product/state/base/base_cubit';
import 'package:smartmetric_case/product/state/sign_up_state.dart';
import 'package:smartmetric_case/product/utility/response/api_response.dart';
import 'package:smartmetric_case/product/utility/constant/enums/status_code.dart';
import 'package:gen/gen.dart';

final class SignUpViewModel extends BaseCubit<SignUpState> {
  SignUpViewModel() : super(const SignUpState());

  void _changeLoading() => emit(state.copyWith(isLoading: !state.isLoading));

  Future<ApiResponse<SignupResponse>> signup({
    required SignupRequest signupRequest,
  }) async {
    _changeLoading();
    try {
      final res = await MockHttpClient.I.post<SignupResponse>(
        assetPath: 'asset/mocks/signup_success.json',
        fromJson: (j) => SignupResponse.fromJson(j),
      );
      _changeLoading();
      return res;
    } catch (e) {
      _changeLoading();
      return ApiResponse.failure(
          error: e.toString(), result: HttpResult.unknown);
    }
  }
}
