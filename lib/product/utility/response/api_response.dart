import 'package:smartmetric_case/product/utility/constant/enums/status_code.dart';

/// [ApiResponse] is a generic class that is used to handle the response of the API.
final class ApiResponse<T> {
  /// Constructor for failure response
  ApiResponse.failure({
    required HttpResult result,
    T? data,
    String? error,
  })  : _data = data,
        _error = error,
        _result = result;

  /// Constructor for success response
  ApiResponse.success({
    T? data,
    String? error,
  })  : _data = data,
        _error = error,
        _result = HttpResult.success;
  final T? _data;
  final String? _error;
  final HttpResult? _result;

  /// [isSuccess] method is used to check if the response is successful.
  bool get isSuccess => _result == HttpResult.success;

  /// [data] method is used to get the data from the response.
  T? get data => _data;

  /// [error] method is used to get the error from the response.
  String? get error => _error;

  /// [result] method is used to get the result from the response.
  HttpResult? get result => _result;

  @override
  String toString() {
    if (isSuccess) {
      return 'Success: $_data';
    } else {
      return 'Error: $_error (Status Code: $_result)';
    }
  }
}
