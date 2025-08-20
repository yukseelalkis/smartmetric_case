// lib/feature/customer_detail/state/customer_detail_state.dart
import 'package:gen/gen.dart'; // Customer, Activity, Note
import 'package:smartmetric_case/product/state/base/base_state.dart';

final class CustomerDetailState extends BaseState {
  const CustomerDetailState({
    super.isLoading = false,
    this.customer,
    this.activities = const <Activity>[],
    this.notes = const <Note>[],
    this.error,
  });

  final Customer? customer;
  final List<Activity> activities;
  final List<Note> notes;
  final String? error;

  @override
  List<Object?> get props =>
      super.props..addAll([customer, activities, notes, error]);

  @override
  CustomerDetailState copyWith({
    bool? isLoading,
    Customer? customer,
    List<Activity>? activities,
    List<Note>? notes,
    String? error,
  }) {
    return CustomerDetailState(
      isLoading: isLoading ?? this.isLoading,
      customer: customer ?? this.customer,
      activities: activities ?? this.activities,
      notes: notes ?? this.notes,
      error: error,
    );
  }
}
