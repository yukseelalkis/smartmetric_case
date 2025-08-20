import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:gen/gen.dart';
import 'package:smartmetric_case/product/service/mock_service/mock_service.dart';
import 'package:smartmetric_case/product/utility/response/api_response.dart';
import 'package:smartmetric_case/product/utility/constant/enums/status_code.dart';

final class AuthRepository {
  const AuthRepository();

  Future<ApiResponse<LoginResponse>> login(LoginRequest req) async {
    // 1) Dosyayı bir kere oku, credential check yap
    final jsonString = await rootBundle.loadString('asset/mocks/login.json');
    final root = json.decode(jsonString) as Map<String, dynamic>;
    final data = root['data'] as Map<String, dynamic>;
    final user = data['user'] as Map<String, dynamic>;
    final email = user['email'] as String?;
    final password = user['password'] as String?;

    if (email == null || password == null) {
      return ApiResponse.failure(
        error: "Mock user missing email/password",
        result: HttpResult.unknown,
      );
    }

    if (req.email != email || req.password != password) {
      return ApiResponse.failure(
        error: "Invalid credentials",
        result: HttpResult.unauthorized,
      );
    }

    // 2) Tipli dönüş için aynı dosyayı MockHttpClient ile parse et
    return MockHttpClient.I.post<LoginResponse>(
      assetPath: 'asset/mocks/login.json',
      fromJson: LoginResponse.fromJson,
      validate: loginJsonValidator,
    );
  }

  void loginJsonValidator(Map<String, dynamic> j) {
    final data = j['data'];
    if (data is! Map<String, dynamic>) throw 'data missing';
    if (data['token'] is! String) throw 'data.token missing';
    if (data['user'] is! Map<String, dynamic>) throw 'data.user missing';
  }
}
