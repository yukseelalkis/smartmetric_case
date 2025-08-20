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

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewMixin {
  StatusFilter _filter = StatusFilter.general;

  late final HomeViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = HomeViewModel()..initLoad(); // ✅ ilk açılışta veriyi çek
    // Eğer SearchField dinleyicisi mixin’de yoksa:
    // searchCtrl.addListener(() => vm.setQuery(searchCtrl.text));
  }

  @override
  void dispose() {
    // searchCtrl listener eklediysen kaldırmayı unutma
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: vm, // ✅ aynı VM; rebuild’de yenisi oluşmaz
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('Smartmetrics')),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Row(
                    children: [
                      StatusMenu(
                        value: _filter,
                        onSelected: (f) {
                          setState(() => _filter = f);
                          vm.setStatus(f); // ✅ context.read yerine aynı vm
                        },
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SearchField(
                          controller: searchCtrl,
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: CustomerList()),
              ],
            ),

            // Loading overlay
            TransparentScreen<HomeViewModel, HomeState>(
              selector: (s) => s.isLoading,
              child: const Center(child: CircularProgressIndicator.adaptive()),
            ),

            // Opsiyonel: Hata mesajı (SnackBar kullanmak istersen BlocListener ekle)
            // BlocListener<HomeViewModel, HomeState>(
            //   listenWhen: (p, c) => p.error != c.error && c.error != null,
            //   listener: (ctx, state) {
            //     ScaffoldMessenger.of(ctx).showSnackBar(
            //       SnackBar(content: Text(state.error!)),
            //     );
            //   },
            //   child: const SizedBox.shrink(),
            // ),
          ],
        ),
      ),
    );
  }
}
