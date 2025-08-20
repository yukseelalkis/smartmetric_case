// -------------------- DETAIL VIEW --------------------
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:smartmetric_case/feature/repo/customer_repository.dart';
import 'package:smartmetric_case/product/utility/response/api_response.dart';

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

class _CustomerDetailViewState extends State<CustomerDetailView> {
  final _repo = CustomerRepository();
  late Future<ApiResponse<CustomerDetail>> _future;

  // anında ekleme için elde tutalım
  CustomerDetail? _detail;
  final _noteCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _future = _repo.getCustomerFull(widget.customId);
  }

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(widget.customerName)),
      body: FutureBuilder<ApiResponse<CustomerDetail>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting &&
              widget.fallback != null &&
              _detail == null) {
            return _DetailBody(
              customer: widget.fallback!,
              activities: const [],
              notes: const [],
              onAddNote: _onAddNote,
            );
          }

          if (snap.hasData && snap.data!.data != null && _detail == null) {
            _detail = snap.data!.data!;
          }

          if (_detail == null) {
            return Center(
              child: Text(
                  'Detay yüklenemedi: ${snap.data?.error ?? 'bilinmiyor'}'),
            );
          }

          return _DetailBody(
            customer: _detail!.customer,
            activities: _detail!.activities,
            notes: _detail!.notes,
            onAddNote: _onAddNote,
          );
        },
      ),
    );
  }

  Future<void> _onAddNote() async {
    final text = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _noteCtrl,
                autofocus: true,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  hintText: 'Write a note…',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () =>
                          Navigator.pop(ctx, _noteCtrl.text.trim()),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    if (!mounted || text == null || text.isEmpty) return;

    final res = await _repo.addNote(customerId: widget.customId, text: text);
    if (!mounted) return;

    if (res.data != null) {
      // anında ekrana ekle
      final newNotes = [..._detail!.notes, res.data!];
      setState(() {
        _detail = CustomerDetail(
          customer: _detail!.customer,
          activities: _detail!.activities,
          notes: newNotes,
        );
        _noteCtrl.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Not eklenemedi: ${res.error}')));
    }
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({
    required this.customer,
    required this.activities,
    required this.notes,
    required this.onAddNote,
  });

  final Customer customer;
  final List<Activity> activities;
  final List<Note> notes;
  final VoidCallback onAddNote;

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).cardColor;
    final border = Theme.of(context).dividerColor;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(customer.name,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  )),
                      const SizedBox(height: 4),
                      Text(customer.company,
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
                _StatusChip(status: customer.status),
              ],
            ),
            const SizedBox(height: 12),
            _IconRow(icon: Icons.mail_outline_rounded, text: customer.email),
            const SizedBox(height: 8),
            _IconRow(icon: Icons.call_outlined, text: customer.phone),
            const SizedBox(height: 24),
            Text('Activities',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            if (activities.isEmpty)
              _EmptyHint('No activities')
            else
              ...activities.map((a) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(_activityIcon(a.type)),
                    title: Text(a.title),
                    trailing: Text(_shortDate(a.when)),
                  )),
            const SizedBox(height: 16),
            Text('Notes',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            if (notes.isEmpty)
              _EmptyHint('No notes')
            else
              ...notes.map((n) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.sticky_note_2_outlined),
                    title: Text(n.text),
                    subtitle: Text(_shortDate(n.createdAt)),
                  )),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: onAddNote, child: const Text('Add note')),
          ],
        ),
      ),
    );
  }
}

class _IconRow extends StatelessWidget {
  const _IconRow({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 20),
      const SizedBox(width: 8),
      Expanded(child: Text(text)),
    ]);
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Theme.of(context).hintColor));
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final CustomerStatus status;
  @override
  Widget build(BuildContext context) {
    late Color fg;
    late String label;
    switch (status) {
      case CustomerStatus.active:
        fg = Colors.green.shade700;
        label = 'active';
        break;
      case CustomerStatus.lead:
        fg = Colors.orange.shade700;
        label = 'lead';
        break;
      case CustomerStatus.inactive:
        fg = Colors.grey.shade700;
        label = 'inactive';
        break;
    }
    final bg = fg.withOpacity(0.12);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: fg.withOpacity(0.25)),
      ),
      child:
          Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.w600)),
    );
  }
}

IconData _activityIcon(ActivityType t) {
  switch (t) {
    case ActivityType.call:
      return Icons.phone_in_talk_rounded;
    case ActivityType.meeting:
      return Icons.event_available_rounded;
    case ActivityType.email:
      return Icons.mail_outline_rounded;
  }
}

String _shortDate(DateTime dt) {
  const m = [
    'Jan.',
    'Feb.',
    'Mar.',
    'Apr.',
    'May',
    'Jun.',
    'Jul.',
    'Aug.',
    'Sep.',
    'Oct.',
    'Nov.',
    'Dec.'
  ];
  return '${m[dt.month - 1]} ${dt.day}, ${dt.year}';
}
