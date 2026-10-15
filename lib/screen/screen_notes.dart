import 'package:flutter/material.dart';
import 'package:mynote/data/data.dart';
import 'package:mynote/models/data_notes.dart';
import 'package:mynote/screen/add_notes.dart';
import 'package:mynote/screen/edit_notes.dart';
import 'package:mynote/screen/note_card.dart';

class ScreenNotes extends StatefulWidget {
  const ScreenNotes({super.key});

  @override
  State<ScreenNotes> createState() => _ScreenNotesState();
}

class _ScreenNotesState extends State<ScreenNotes> {
  final Data data = Data();
  late List<DataNotes> filteredNotes;

  @override
  void initState() {
    super.initState();
    filteredNotes = List.from(data.notes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Notes',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${filteredNotes.length} Notes',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                final query = value.trim().toLowerCase();
                setState(() {
                  filteredNotes = data.notes.where((note) {
                    return note.title.toLowerCase().contains(query) ||
                        note.content.toLowerCase().contains(query);
                  }).toList();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search notes...',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF616E80),
                ),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF616E80)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return NoteCard(
                    note: filteredNotes[index],
                    onTap: () async {
                      final result = await Navigator.push<EditNoteResult>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditNotes(notes: filteredNotes[index]),
                        ),
                      );

                      if (!mounted || result == null) return;

                      final selectedNote = filteredNotes[index];
                      final originalIndex = data.notes.indexOf(selectedNote);

                      setState(() {
                        if (result.isDeleted) {
                          data.notes.removeAt(originalIndex);
                        } else if (result.note != null) {
                          data.notes[originalIndex] = result.note!;
                        }

                        filteredNotes = List.from(data.notes);
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: filteredNotes.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await Navigator.push<DataNotes>(
            context,
            MaterialPageRoute(builder: (context) => const AddNotes()),
          );
          if (!mounted || newNote == null) return;
          setState(() {
            data.notes.add(newNote);
            filteredNotes = List.from(data.notes);
          });
        },
        backgroundColor: const Color(0xFF6B4DDB),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
