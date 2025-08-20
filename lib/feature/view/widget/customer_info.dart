import 'package:flutter/material.dart';
import 'package:gen/gen.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, required this.customer});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          customer.name,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        Text(customer.company, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.mail_outline_rounded, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(customer.email)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.call_outlined, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(customer.phone)),
          ],
        ),
      ],
    );
  }
}
