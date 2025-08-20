import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmetric_case/feature/viewmodel/home_view_model.dart';

mixin HomeViewMixin<T extends StatefulWidget> on State<T> {
  final TextEditingController searchCtrl = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    // ✅ sadece debounce'lu arama — ilk yükleme HomeView'da create: ..initLoad()
    searchCtrl.addListener(() {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        context.read<HomeViewModel>().setQuery(searchCtrl.text.trim());
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchCtrl.dispose();
    super.dispose();
  }
}
