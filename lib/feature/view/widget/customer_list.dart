import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmetric_case/feature/view/widget/customer_tile.dart';
import 'package:smartmetric_case/feature/viewmodel/home_view_model.dart';
import 'package:smartmetric_case/product/state/home_state.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      buildWhen: (p, n) => p.items != n.items || p.error != n.error,
      builder: (context, state) {
        if (state.error != null) {
          return Center(child: Text('Error: ${state.error}'));
        }
        final items = state.items;
        if (items.isEmpty) {
          return const Center(child: Text('Kayıt bulunamadı'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) {
            final c = items[i];
            return CustomerTile(c: c);
          },
        );
      },
    );
  }
}
