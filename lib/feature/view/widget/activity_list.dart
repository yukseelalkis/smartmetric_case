import 'package:flutter/material.dart';
import 'package:gen/gen.dart';

class ActivityList extends StatelessWidget {
  const ActivityList({super.key, required this.activities});
  final List<Activity> activities;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activities',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        if (activities.isEmpty)
          Text(
            'No activities',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).hintColor),
          )
        else
          ...activities.map(
            (a) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event_note_rounded),
              title: Text(a.title),
              subtitle: Text(a.when.toString()),
            ),
          ),
      ],
    );
  }
}
