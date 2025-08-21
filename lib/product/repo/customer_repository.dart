// product/repository/customer_repository.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:gen/gen.dart'; // Customer, PagedCustomers, CustomerStatus
import 'package:smartmetric_case/product/utility/constant/enums/mock_enums.dart';
import 'package:smartmetric_case/product/utility/constant/enums/status_code.dart';
import 'package:smartmetric_case/product/utility/constant/search_norm.dart';
import 'package:smartmetric_case/product/utility/response/api_response.dart';

final class CustomerRepository {
  Future<ApiResponse<PagedCustomers>> getCustomers({
    CustomerStatus? status,
    String? query,
  }) async {
    try {
      final raw = await rootBundle.loadString(MockAssets.customer.path);
      final map = json.decode(raw) as Map<String, dynamic>;
      final full = PagedCustomers.fromJson(map);

      var list = full.data;

      if (status != null) {
        list = list.where((c) => c.status == status).toList();
      }

      if (query != null && query.trim().isNotEmpty) {
        final q = searhcNorm(query);
        list = list.where((c) {
          final name = searhcNorm(c.name);
          final company = searhcNorm(c.company);
          return name.contains(q) || company.contains(q);
        }).toList();
      }

      return ApiResponse.success(
        data: PagedCustomers(
          data: list,
          page: full.page,
          total: list.length,
          limit: full.limit,
        ),
      );
    } catch (e) {
      return ApiResponse.failure(
          error: e.toString(), result: HttpResult.unknown);
    }
  }

  /// Sade detay: tek dosyadan id’ye göre bulup sadece Customer döner.
  Future<ApiResponse<Customer>> getCustomerDetail(int id) async {
    try {
      final raw = await rootBundle.loadString(MockAssets.customerDetail.path);
      final root = json.decode(raw) as Map<String, dynamic>;
      final list = (root['data'] as List).cast<Map<String, dynamic>>();

      final found = list.firstWhere(
        (e) => (e['customer'] as Map<String, dynamic>)['id'] == id,
        orElse: () => <String, dynamic>{},
      );
      if (found.isEmpty) {
        return ApiResponse.failure(
          error: 'detail not found for id=$id',
          result: HttpResult.notFound,
        );
      }

      final customer =
          Customer.fromJson(found['customer'] as Map<String, dynamic>);
      return ApiResponse.success(data: customer);
    } catch (e) {
      return ApiResponse.failure(
          error: e.toString(), result: HttpResult.unknown);
    }
  }

  /// Full detay: customer + activities + notes.
  Future<ApiResponse<CustomerDetail>> getCustomerFull(int id) async {
    try {
      final raw = await rootBundle.loadString(MockAssets.customerDetail.path);
      final root = json.decode(raw) as Map<String, dynamic>;
      final list = (root['data'] as List).cast<Map<String, dynamic>>();

      final found = list.firstWhere(
        (e) => (e['customer'] as Map<String, dynamic>)['id'] == id,
        orElse: () => <String, dynamic>{},
      );
      if (found.isEmpty) {
        return ApiResponse.failure(
          error: 'detail not found for id=$id',
          result: HttpResult.notFound,
        );
      }

      return ApiResponse.success(data: CustomerDetail.fromJson(found));
    } catch (e) {
      return ApiResponse.failure(
          error: e.toString(), result: HttpResult.unknown);
    }
  }

  // product/repository/customer_repository.dart (aynı sınıfa ekle)
  Future<ApiResponse<Note>> addNote({
    required int customerId,
    required String text,
  }) async {
    try {
      // gerçek API olsa POST yapılırdı; burada sadece başarı simüle ediyoruz
      final note = Note(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        text: text,
        createdAt: DateTime.now().toUtc(),
      );
      await Future<void>.delayed(const Duration(milliseconds: 250));
      return ApiResponse.success(data: note);
    } catch (e) {
      return ApiResponse.failure(
          error: e.toString(), result: HttpResult.unknown);
    }
  }
}
