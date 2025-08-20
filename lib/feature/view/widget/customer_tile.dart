import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:smartmetric_case/feature/view/common/customer_detail_view.dart';

class CustomerTile extends StatelessWidget {
  const CustomerTile({super.key, required this.c});
  final Customer c;

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).cardColor;
    final border = Theme.of(context).dividerColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CustomerDetailView(
                customerName: c.name,
                customId: c.id,
                fallback: c,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(c.company,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 2),
                    Text(c.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.color
                                ?.withOpacity(0.7))),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _StatusPill(status: c.status),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});
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
