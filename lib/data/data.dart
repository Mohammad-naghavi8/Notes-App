import 'package:mynote/models/data_notes.dart';

class Data {
  final List<DataNotes> notes = [
    DataNotes(
      id: '1',
      title: 'Flutter Navigator',
      content: 'Practice push and pop between screens.',
      createdAt: DateTime.now(),
    ),
    DataNotes(
      id: '2',
      title: 'Clean Code',
      content: 'Move validation logic out of the UI.',
      createdAt: DateTime.now(),
    ),
    DataNotes(
      id: '3',
      title: 'State practice',
      content: 'Add, edit and delete notes with setState.',
      createdAt: DateTime.now(),
    ),
  ];
}
