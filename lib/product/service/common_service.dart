import 'dart:developer';
import 'dart:io';

import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gen/gen.dart';
import 'package:http_parser/http_parser.dart';

import 'package:logger/logger.dart';
import 'package:smartmetric_case/product/init/cache/cache_manager.dart';
import 'package:smartmetric_case/product/init/language/locale_keys.g.dart';
import 'package:smartmetric_case/product/service/mixin/common_service_mixin.dart';
import 'package:smartmetric_case/product/utility/constant/enums/cache_allow_list.dart';
import 'package:smartmetric_case/product/utility/constant/enums/status_code.dart';
import 'package:smartmetric_case/product/utility/response/api_response.dart';

/// [CommonService] is a common service class that contains common methods
/// that can be used in multiple places.
/// Like `CRUD` processes, `API` calls, etc.
final class CommonService with CommonServiceMixin {
  CommonService._() {
    _baseUrl = DevEnv().baseUrl;
    _token = CacheManager.instance.getString(CacheAllowListEnum.token.name);

    log('token: $_token');

    final baseOptions = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      validateStatus: (status) =>
          status.hasValue &&
          ((status! >= 200 && status <= 399) ||
              status == 401 ||
              status == 404 ||
              status == 409),
    );

    _dio = Dio(baseOptions);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_token.hasValue) {
            options.headers['Authorization'] = _token;
          }
          return handler.next(options);
        },
      ),
    );
  }

  /// The line is creating a static instance of the application.
  static CommonService instance = CommonService._();

  String? _token;
  late String _baseUrl;
  late Dio _dio;

  Future<ApiResponse<T>> getModel<T>({
    required String domain,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        '$_baseUrl$domain',
        queryParameters: queryParameters,
      );
      final responseCode = HttpResult.fromStatusCode(response.statusCode ?? -1);
      final responseBody = response.data;

      switch (responseCode) {
        case HttpResult.success:
          if (responseBody is List) {
            final data = responseBody
                .map<T>((e) => fromJson(e as Map<String, dynamic>))
                .toList();
            return ApiResponse<T>.success(data: data as T);
          } else if (responseBody is Map) {
            final data = fromJson(responseBody.cast<String, dynamic>());
            return ApiResponse<T>.success(data: data);
          }

          return ApiResponse.failure(
            data: responseBody,
            result: HttpResult.unknown,
            error: LocaleKeys.error_unknown_response_type.tr(),
          );

        default:
          return ApiResponse.failure(data: responseBody, result: responseCode);
      }
    } catch (e) {
      Logger().e(e);
      return ApiResponse.failure(
        error: e.toString(),
        result: HttpResult.unknown,
      );
    }
  }

  /// [postModel] method is a generic method that is used to send data to the API.
  /// [ApiResponse] is returned based on the response.
  Future<ApiResponse<TResponse>>
      postModel<TRequest extends BaseModel, TResponse>({
    required String domain,
    required TRequest model,
    required TResponse Function(Map<String, dynamic>) fromJson,
    bool isList = false,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        '$_baseUrl$domain',
        data: model.toJson(),
      );
      final responseCode = HttpResult.fromStatusCode(response.statusCode ?? -1);
      final responseBody = response.data;

      switch (responseCode) {
        case HttpResult.success:
          if (responseBody is Map && !isList) {
            final data = fromJson(responseBody.cast<String, dynamic>());
            return ApiResponse<TResponse>.success(data: data);
          } else if (responseBody is List && isList) {
            final data = responseBody
                .map<TResponse>((e) => fromJson(e as Map<String, dynamic>))
                .toList();
            return ApiResponse<TResponse>.success(data: data as TResponse);
          }
          return ApiResponse.failure(
            data: responseBody,
            result: HttpResult.unknown,
            error: LocaleKeys.error_unknown_response_type.tr(),
          );

        case HttpResult.conflict:
          return ApiResponse.failure(
            data: responseBody,
            result: responseCode,
          );

        default:
          return ApiResponse.failure(
            data: responseBody,
            result: responseCode,
            error: LocaleKeys.error_unknown_response_type.tr(),
          );
      }
    } catch (e) {
      Logger().e(e);
      return ApiResponse.failure(
        error: e.toString(),
        result: HttpResult.unknown,
      );
    }
  }

  /// [postWithoutModel] method is a generic method that is
  /// used to send a POST request to the API **without a body/model**,
  /// but expects a parsed response of type [T].
  Future<ApiResponse<T>> postWithoutModel<T>({
    required String domain,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        '$_baseUrl$domain',
      );
      final responseCode = HttpResult.fromStatusCode(response.statusCode ?? -1);
      final responseBody = response.data;

      switch (responseCode) {
        case HttpResult.success:
          if (responseBody is Map) {
            final data = fromJson(responseBody.cast<String, dynamic>());
            return ApiResponse<T>.success(data: data);
          }
          return ApiResponse.failure(
            data: responseBody,
            result: HttpResult.unknown,
            error: LocaleKeys.error_unknown_response_type.tr(),
          );

        default:
          return ApiResponse.failure(
            data: responseBody,
            result: responseCode,
            error: LocaleKeys.error_unknown_response_type.tr(),
          );
      }
    } catch (e) {
      Logger().e(e);
      return ApiResponse.failure(
        error: e.toString(),
        result: HttpResult.unknown,
      );
    }
  }

  /// [delete] method is a generic method that is
  /// used to delete data from the API.
  Future<ApiResponse<dynamic>> delete({
    required String domain,
    required String id,
  }) async {
    try {
      final response = await _dio.delete<dynamic>(
        '$_baseUrl$domain/$id',
      );
      final responseCode = HttpResult.fromStatusCode(response.statusCode ?? -1);
      final responseBody = response.data;

      switch (responseCode) {
        case HttpResult.success:
          return ApiResponse<dynamic>.success(data: responseBody);

        default:
          return ApiResponse.failure(
            data: responseBody,
            result: responseCode,
            error: LocaleKeys.error_unknown_response_type.tr(),
          );
      }
    } catch (e) {
      Logger().e(e);
      return ApiResponse.failure(
        error: e.toString(),
        result: HttpResult.unknown,
      );
    }
  }

  /// [putModel] method is a generic method that is
  /// used to update data to the API.
  Future<ApiResponse<dynamic>> putModel<T extends BaseModel<T>>({
    required String domain,
    required T model,
    required String id,
  }) async {
    try {
      final response = await _dio.put<dynamic>(
        '$_baseUrl$domain/$id',
        data: model.toJson(),
      );
      final responseCode = HttpResult.fromStatusCode(response.statusCode ?? -1);
      final responseBody = response.data;

      switch (responseCode) {
        case HttpResult.success:
          return ApiResponse<dynamic>.success(data: responseBody);

        default:
          return ApiResponse.failure(
            data: responseBody,
            result: responseCode,
            error: LocaleKeys.error_unknown_response_type.tr(),
          );
      }
    } catch (e) {
      Logger().e(e);
      return ApiResponse.failure(
        error: e.toString(),
        result: HttpResult.unknown,
      );
    }
  }

  Future<ApiResponse<T>> uploadFile<T>({
    required String domain,
    required File file,
    required String fileKey,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final fileName = file.path.split('/').last;

      final formData = FormData.fromMap({
        fileKey: await MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: MediaType(
            'image',
            'jpeg',
          ),
        ),
      });

      final response = await _dio.post<dynamic>(
        '$_baseUrl$domain',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      final responseCode = HttpResult.fromStatusCode(response.statusCode ?? -1);
      final responseBody = response.data;

      switch (responseCode) {
        case HttpResult.success:
          if (fromJson != null && responseBody is Map<String, dynamic>) {
            return ApiResponse.success(data: fromJson(responseBody));
          } else {
            return ApiResponse.success(data: responseBody);
          }

        default:
          return ApiResponse.failure(
            data: responseBody,
            result: responseCode,
            error: LocaleKeys.error_unknown_response_type.tr(),
          );
      }
    } catch (e) {
      Logger().e(e);
      return ApiResponse.failure(
        error: e.toString(),
        result: HttpResult.unknown,
      );
    }
  }
}
