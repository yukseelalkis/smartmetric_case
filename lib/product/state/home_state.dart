import 'package:gen/gen.dart'; // Customer
import 'package:smartmetric_case/product/state/base/base_state.dart';
import 'package:smartmetric_case/product/utility/constant/enums/status_filter.dart';

final class HomeState extends BaseState {
  const HomeState({
    super.isLoading = false,
    this.items = const <Customer>[],
    this.query = '',
    this.status = StatusFilter.general,
    this.error,
  });

  final List<Customer> items;
  final String query;
  final StatusFilter status;
  final String? error;

  @override
  List<Object?> get props => super.props..addAll([items, query, status, error]);

  @override
  HomeState copyWith({
    bool? isLoading,
    List<Customer>? items,
    String? query,
    StatusFilter? status,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      query: query ?? this.query,
      status: status ?? this.status,
      error: error,
    );
  }
}
