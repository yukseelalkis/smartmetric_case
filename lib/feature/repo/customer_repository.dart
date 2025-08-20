// product/repository/customer_repository.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:gen/gen.dart'; // Customer, PagedCustomers, CustomerStatus
import 'package:smartmetric_case/product/utility/constant/enums/status_code.dart';
import 'package:smartmetric_case/product/utility/response/api_response.dart';

final class CustomerRepository {
  // 👉 pubspec.yaml ile aynı olmalı
  static const String _listPath = 'asset/mocks/custommer.json';
  static const String _detailPathTpl =
      'asset/mocks/customer_detail_'; // + {id}.json

  /// Listeyi getirir. Opsiyonel:
  /// - [status]: CustomerStatus.active/inactive (null => filtre yok)
  /// - [query]: sadece **name** alanında arama yapar (case-insensitive)
  Future<ApiResponse<PagedCustomers>> getCustomers({
    CustomerStatus? status,
    String? query,
  }) async {
    try {
      final raw = await rootBundle.loadString(_listPath);
      final map = json.decode(raw) as Map<String, dynamic>;
      final full = PagedCustomers.fromJson(map);

      // filtrele
      var list = full.data;

      if (status != null) {
        list = list.where((c) => c.status == status).toList();
      }

      if (query != null && query.trim().isNotEmpty) {
        final q = query.toLowerCase().trim();
        // 🔎 sadece isme göre arama
        list = list.where((c) => c.name.toLowerCase().contains(q)).toList();
      }

      final result = PagedCustomers(
        data: list,
        page: full.page,
        total: list.length, // filtre sonrası toplam
        limit: full.limit,
      );

      return ApiResponse.success(data: result);
    } catch (e) {
      return ApiResponse.failure(
        error: e.toString(),
        result: HttpResult.unknown,
      );
    }
  }

  /// Detayı getirir: asset/mocks/customer_detail_{id}.json
  /// Beklenen format: { "data": { ...customer fields... } }
  Future<ApiResponse<Customer>> getCustomerDetail(int id) async {
    try {
      final raw = await rootBundle.loadString('$_detailPathTpl$id.json');
      final map = json.decode(raw) as Map<String, dynamic>;

      if (map['data'] is! Map<String, dynamic>) {
        return ApiResponse.failure(
          error: 'detail json invalid: data missing',
          result: HttpResult.unknown,
        );
      }

      final customer = Customer.fromJson(map['data'] as Map<String, dynamic>);
      return ApiResponse.success(data: customer);
    } catch (e) {
      return ApiResponse.failure(
        error: e.toString(),
        result: HttpResult.notFound,
      );
    }
  }
}
