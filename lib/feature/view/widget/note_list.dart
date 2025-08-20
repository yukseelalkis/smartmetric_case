import 'package:flutter/material.dart';
import 'package:gen/gen.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key, required this.notes});
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        if (notes.isEmpty)
          Text(
            'No notes',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).hintColor),
          )
        else
          ...notes.map(
            (n) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.sticky_note_2_outlined),
              title: Text(n.text),
              subtitle: Text(n.createdAt.toString()),
            ),
          ),
      ],
    );
  }
}
