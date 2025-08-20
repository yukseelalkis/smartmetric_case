// lib/feature/customer_detail/viewmodel/customer_detail_view_model.dart
import 'package:gen/gen.dart'; // Customer
import 'package:smartmetric_case/feature/repo/customer_repository.dart';
import 'package:smartmetric_case/product/state/base/base_cubit';
import 'package:smartmetric_case/product/state/customer_detail.dart';

final class CustomerDetailViewModel extends BaseCubit<CustomerDetailState> {
  CustomerDetailViewModel({CustomerRepository? repo})
      : _repo = repo ?? CustomerRepository(),
        super(const CustomerDetailState());

  final CustomerRepository _repo;

  void _toggleLoading() =>
      emit(state.copyWith(isLoading: !(state.isLoading ?? false)));

  Future<void> load({required int id, Customer? fallback}) async {
    if (fallback != null) {
      emit(state.copyWith(customer: fallback));
    }

    _toggleLoading();
    final res = await _repo.getCustomerFull(id);
    _toggleLoading();

    if (res.isSuccess && res.data != null) {
      final d = res.data!;
      emit(state.copyWith(
        customer: d.customer,
        activities: d.activities,
        notes: d.notes,
        error: null,
      ));
    } else {
      emit(state.copyWith(error: res.error ?? 'Detay yüklenemedi'));
    }
  }

  Future<void> addNote({required int id, required String text}) async {
    final t = text.trim();
    if (t.isEmpty) return;

    final res = await _repo.addNote(customerId: id, text: t);
    if (res.isSuccess && res.data != null) {
      emit(state.copyWith(notes: [...state.notes, res.data!], error: null));
    } else {
      emit(state.copyWith(error: res.error ?? 'Not eklenemedi'));
    }
  }
}
