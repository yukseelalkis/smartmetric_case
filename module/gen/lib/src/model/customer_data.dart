// product/model/customer/customer.dart

/// Geçici mock çözümü için müşteri modelimiz.
/// Daha sonra API entegrasyonu geldiğinde ayrıştırılabilir.

enum CustomerStatus { active, lead, inactive }

extension CustomerStatusX on CustomerStatus {
  static CustomerStatus fromString(String s) {
    switch (s.toLowerCase()) {
      case 'active':
        return CustomerStatus.active;
      case 'lead':
        return CustomerStatus.lead;
      default:
        return CustomerStatus.inactive;
    }
  }

  String toValue() {
    switch (this) {
      case CustomerStatus.active:
        return 'active';
      case CustomerStatus.lead:
        return 'lead';
      case CustomerStatus.inactive:
        return 'inactive';
    }
  }
}

class Customer {
  final int id;
  final String name;
  final String company;
  final String email;
  final String phone;
  final CustomerStatus status;

  Customer({
    required this.id,
    required this.name,
    required this.company,
    required this.email,
    required this.phone,
    required this.status,
  });

  factory Customer.fromJson(Map<String, dynamic> j) => Customer(
        id: j['id'] as int,
        name: j['name'] as String,
        company: j['company'] as String,
        email: j['email'] as String,
        phone: j['phone'] as String,
        status: CustomerStatusX.fromString(j['status'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'company': company,
        'email': email,
        'phone': phone,
        'status': status.toValue(),
      };
}

class PagedCustomers {
  final List<Customer> data;
  final int page;
  final int total;
  final int limit;

  PagedCustomers({
    required this.data,
    required this.page,
    required this.total,
    required this.limit,
  });

  factory PagedCustomers.fromJson(Map<String, dynamic> j) {
    final list = (j['data'] as List).cast<Map<String, dynamic>>();
    return PagedCustomers(
      data: list.map((e) => Customer.fromJson(e)).toList(),
      page: j['page'] as int,
      total: j['total'] as int,
      limit: j['limit'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data.map((e) => e.toJson()).toList(),
        'page': page,
        'total': total,
        'limit': limit,
      };
}
