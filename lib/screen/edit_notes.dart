import 'package:flutter/material.dart';
import 'package:mynote/models/data_notes.dart';

class EditNotes extends StatefulWidget {
  final DataNotes notes;
  const EditNotes({super.key, required this.notes});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  late final TextEditingController titleController;
  late final TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.notes.title);
    noteController = TextEditingController(text: widget.notes.content);
  }

  void saveChanges() {
    final title = titleController.text.trim();
    final content = noteController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and note cannot be empty')),
      );
      return;
    }

    final updateNotes = DataNotes(
      title: title,
      content: content,
      createdAt: widget.notes.createdAt,
      id: widget.notes.id,
    );
    Navigator.pop(context, EditNoteResult.updated(updateNotes));
  }

  Future<void> deleteNote() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      Navigator.pop(context, const EditNoteResult.deleted());
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Text(
                    'Edit Note',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: saveChanges,
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Color(0xFF6B4DDB),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text('Title'),
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter title',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Note'),
              const SizedBox(height: 8),
              SizedBox(
                height: 280,
                child: TextField(
                  controller: noteController,
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    hintText: 'Enter note',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: deleteNote,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFEDE7FF),
                    foregroundColor: const Color(0xFFDB3842),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Delete note'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditNoteResult {
  final DataNotes? note;
  final bool isDeleted;
  const EditNoteResult.updated(this.note) : isDeleted = false;
  const EditNoteResult.deleted() : note = null, isDeleted = true;
}
