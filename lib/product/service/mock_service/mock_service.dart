import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:logger/logger.dart';
import 'package:smartmetric_case/product/utility/constant/enums/status_code.dart';
import 'package:smartmetric_case/product/utility/response/api_response.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);
typedef JsonValidator = void Function(Map<String, dynamic> json);

final class MockHttpClient {
  MockHttpClient._();
  static final MockHttpClient I = MockHttpClient._();

  Future<ApiResponse<T>> request<T>({
    required String assetPath,
    required FromJson<T> fromJson,
    JsonValidator? validate,
    Duration delay = const Duration(milliseconds: 250),
    bool simulateError = false,
    HttpResult errorType = HttpResult.unknown,
  }) async {
    try {
      if (delay.inMilliseconds > 0) {
        await Future<void>.delayed(delay);
      }

      if (simulateError) {
        return ApiResponse.failure(
          error: "Simulated error",
          result: errorType,
        );
      }

      final jsonString = await rootBundle.loadString(assetPath);
      final decoded = json.decode(jsonString);

      if (decoded is! Map<String, dynamic>) {
        return ApiResponse.failure(
          data: decoded,
          error: "Unexpected JSON root type (expected Map)",
          result: HttpResult.unknown,
        );
      }

      validate?.call(decoded);
      final data = fromJson(decoded);
      return ApiResponse.success(data: data);
    } catch (e, s) {
      Logger().e("MockHttpClient error", error: e, stackTrace: s);
      return ApiResponse.failure(
          error: e.toString(), result: HttpResult.unknown);
    }
  }

  // Kolaylaştırıcılar
  Future<ApiResponse<T>> get<T>({
    required String assetPath,
    required FromJson<T> fromJson,
    JsonValidator? validate,
    Duration delay = const Duration(milliseconds: 250),
  }) =>
      request(
        assetPath: assetPath,
        fromJson: fromJson,
        validate: validate,
        delay: delay,
      );

  Future<ApiResponse<T>> post<T>({
    required String assetPath,
    required FromJson<T> fromJson,
    JsonValidator? validate,
    Duration delay = const Duration(milliseconds: 250),
  }) =>
      request(
        assetPath: assetPath,
        fromJson: fromJson,
        validate: validate,
        delay: delay,
      );
}
