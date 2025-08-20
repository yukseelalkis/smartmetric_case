import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smartmetric_case/feature/view/home/mixin/home_mixin.dart';
import 'package:smartmetric_case/feature/view/widget/customer_list.dart';
import 'package:smartmetric_case/feature/view/widget/search_field.dart';
import 'package:smartmetric_case/feature/view/widget/status_menu.dart';
import 'package:smartmetric_case/feature/viewmodel/home_view_model.dart';
import 'package:smartmetric_case/product/state/home_state.dart';
import 'package:smartmetric_case/product/utility/constant/enums/status_filter.dart';
import 'package:smartmetric_case/feature/view/transparent_view.dart';
import 'package:smartmetric_case/feature/view/mixin/common_view_mixin.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with HomeViewMixin, CommonViewMixin, DeviceSizeMixin {
  StatusFilter _filter = StatusFilter.general;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // ✅ İlk yükleme burada. Mixin’de initLoad ÇAĞRILMAYACAK.
      create: (_) => HomeViewModel()..initLoad(),
      child: GestureDetector(
        onTap: () => gestureOnTap(context),
        child: Scaffold(
          appBar: AppBar(centerTitle: true, title: const Text('Smartmetrics')),
          body: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(16, deviceHeight * 0.015, 16, 8),
                    child: Row(
                      children: [
                        StatusMenu(
                          value: _filter,
                          onSelected: (f) {
                            setState(() => _filter = f);
                            context.read<HomeViewModel>().setStatus(f);
                          },
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: SearchField(controller: searchCtrl)),
                      ],
                    ),
                  ),
                  const Expanded(child: CustomerList()),
                ],
              ),
              TransparentScreen<HomeViewModel, HomeState>(
                selector: (s) => s.isLoading,
                child:
                    const Center(child: CircularProgressIndicator.adaptive()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
