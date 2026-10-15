import 'package:flutter/material.dart';
import 'package:mynote/models/data_notes.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

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
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'New Note',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      final title = titleController.text.trim();
                      final note = noteController.text.trim();

                      if (title.isEmpty || note.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please fill in both title and note.',
                            ),
                          ),
                        );
                        return;
                      }

                      final newNote = DataNotes(
                        title: title,
                        content: note,
                        createdAt: DateTime.now(),
                        id: '',
                      );
                      Navigator.pop(context, newNote);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B4DDB),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              const Text(
                "Title",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF616E80),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Note",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF616E80),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 280,
                width: double.infinity,
                child: TextField(
                  controller: noteController,
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    hintText: "Enter Note",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
