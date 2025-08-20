import 'package:flutter/material.dart';
import 'package:smartmetric_case/product/utility/constant/enums/status_filter.dart';

class StatusMenu extends StatelessWidget {
  const StatusMenu({super.key, required this.value, required this.onSelected});
  final StatusFilter value;
  final ValueChanged<StatusFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    final border = Theme.of(context).dividerColor;
    return PopupMenuButton<StatusFilter>(
      initialValue: value,
      onSelected: onSelected,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (ctx) => const [
        PopupMenuItem(value: StatusFilter.general, child: Text('general')),
        PopupMenuItem(value: StatusFilter.active, child: Text('active')),
        PopupMenuItem(value: StatusFilter.passive, child: Text('passive')),
      ],
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.keyboard_arrow_down_rounded, size: 18),
            SizedBox(width: 6),
            Text('status', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
