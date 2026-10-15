import 'package:flutter/material.dart';
import 'package:mynote/models/data_notes.dart';

class NoteCard extends StatelessWidget {
  final DataNotes note;
  final VoidCallback onTap;
  const NoteCard({super.key, required this.note, required this.onTap});

  String formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return 'Today, $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 126,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const Icon(Icons.more_vert, color: Color(0xFF616E80)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              note.content,
              maxLines: 2,
              overflow: .ellipsis,
              style: TextStyle(fontSize: 14, color: Color(0xFF616E80)),
            ),
            const Spacer(),
            Text(
              formatTime(note.createdAt),
              style: TextStyle(fontSize: 12, color: Color(0xFF616E80)),
            ),
          ],
        ),
      ),
    );
  }
}
