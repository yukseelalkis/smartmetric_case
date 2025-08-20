// lib/feature/viewmodel/home_view_model.dart
import 'package:gen/gen.dart'; // PagedCustomers, CustomerStatus
import 'package:smartmetric_case/feature/repo/customer_repository.dart';
import 'package:smartmetric_case/product/state/base/base_cubit';
import 'package:smartmetric_case/product/state/home_state.dart';
import 'package:smartmetric_case/product/utility/constant/enums/status_filter.dart';
import 'package:smartmetric_case/product/utility/response/api_response.dart';

final class HomeViewModel extends BaseCubit<HomeState> {
  HomeViewModel({CustomerRepository? repo})
      : _repo = repo ?? CustomerRepository(),
        super(const HomeState());

  final CustomerRepository _repo;

  // 🔧 Toggle yerine net set
  void _setLoading(bool v) => emit(state.copyWith(isLoading: v));

  Future<void> initLoad() => _load();
  Future<void> refresh() => _load();

  Future<void> setQuery(String q) async {
    // (İstersen burada debounce da ekleyebiliriz)
    emit(state.copyWith(query: q));
    await _load();
  }

  Future<void> setStatus(StatusFilter f) async {
    emit(state.copyWith(status: f));
    await _load();
  }

  Future<void> _load() async {
    if (state.isLoading) return;

    _setLoading(true);
    try {
      final cs = _mapFilterToCustomerStatus(state.status);
      final ApiResponse<PagedCustomers> res = await _repo.getCustomers(
        status: cs,
        query: state.query.isEmpty ? null : state.query,
      );

      // ✅ Sadece 'data' alanını kullan
      final List<Customer> items = (res.data?.data ?? <Customer>[]);

      if (res.error != null) {
        emit(state.copyWith(
            isLoading: false, items: const [], error: res.error));
      } else {
        emit(state.copyWith(isLoading: false, items: items, error: null));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, items: const [], error: e.toString()));
    }
  }

  CustomerStatus? _mapFilterToCustomerStatus(StatusFilter f) {
    switch (f) {
      case StatusFilter.general:
        return null;
      case StatusFilter.active:
        return CustomerStatus.active;
      case StatusFilter.passive:
        return CustomerStatus.inactive;
    }
  }
}
