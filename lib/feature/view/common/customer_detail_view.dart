import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:smartmetric_case/feature/view/common/mixin/customer_detail_mixin.dart';
import 'package:smartmetric_case/feature/view/mixin/common_view_mixin.dart';
import 'package:smartmetric_case/feature/view/transparent_view.dart';
import 'package:smartmetric_case/feature/view/widget/activity_list.dart';
import 'package:smartmetric_case/feature/view/widget/add_note_detail.dart';
import 'package:smartmetric_case/feature/view/widget/custom_snackbar.dart';
import 'package:smartmetric_case/feature/view/widget/customer_info.dart';
import 'package:smartmetric_case/feature/view/widget/note_list.dart';
import 'package:smartmetric_case/feature/viewmodel/customer_detail_view_model.dart';
import 'package:smartmetric_case/product/state/customer_detail.dart';
import 'package:smartmetric_case/product/utility/constant/enums/response_type.dart';
@RoutePage()   
class CustomerDetailView extends StatefulWidget {
  const CustomerDetailView({
    super.key,
    required this.customerName,
    required this.customId,
    this.fallback,
  });
  final String customerName;
  final int customId;
  final Customer? fallback;

  @override
  State<CustomerDetailView> createState() => _CustomerDetailViewState();
}

class _CustomerDetailViewState extends State<CustomerDetailView>
    with CustomerDetailViewMixin, CommonViewMixin, DeviceSizeMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomerDetailViewModel()
        ..load(id: widget.customId, fallback: widget.fallback),
      child: GestureDetector(
        onTap: () => gestureOnTap(context),
        child: Scaffold(
          appBar: AppBar(centerTitle: true, title: Text(widget.customerName)),
          body: Stack(
            children: [
              BlocConsumer<CustomerDetailViewModel, CustomerDetailState>(
                listenWhen: (p, c) =>
                    p.error != c.error && (c.error?.isNotEmpty ?? false),
                listener: (context, state) {
                  CustomSnackbar.show(
                    context: context,
                    message: state.error!,
                    responseType: ResponseType.error,
                  );
                },
                builder: (context, state) {
                  final customer = state.customer;
                  if (customer == null) {
                    return const Center(child: Text('Detay bulunamadı'));
                  }

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      CustomerInfo(customer: customer),
                      const SizedBox(height: 24),

                      ActivityList(activities: state.activities),
                      const SizedBox(height: 16),

                      NoteList(notes: state.notes),
                      const SizedBox(height: 12),

                      // ---- ADD NOTE BUTTON ----
                      OutlinedButton(
                        onPressed: () async {
                          final text = await AddNoteSheet.show(context);
                          if (!mounted || text == null || text.isEmpty) return;
                          context.read<CustomerDetailViewModel>().addNote(
                                id: widget.customId,
                                text: text,
                              );
                        },
                        child: const Text('Add note'),
                      ),
                    ],
                  );
                },
              ),
              TransparentScreen<CustomerDetailViewModel, CustomerDetailState>(
                selector: (s) => s.isLoading,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
