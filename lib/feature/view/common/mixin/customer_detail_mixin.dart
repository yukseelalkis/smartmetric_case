// lib/feature/customer_detail/view/mixin/customer_detail_view_mixin.dart
import 'package:flutter/material.dart';
import 'package:smartmetric_case/feature/view/common/customer_detail_view.dart';
import 'package:smartmetric_case/feature/viewmodel/customer_detail_view_model.dart';

mixin CustomerDetailViewMixin on State<CustomerDetailView> {
  late final CustomerDetailViewModel detailViewModel;
  final noteCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    detailViewModel = CustomerDetailViewModel()
      ..load(id: widget.customId, fallback: widget.fallback);
  }

  void addNote(String text) {
    detailViewModel.addNote(id: widget.customId, text: text);
  }
}
