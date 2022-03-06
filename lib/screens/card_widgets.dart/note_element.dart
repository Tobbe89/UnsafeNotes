import 'package:flutter/material.dart';
import 'package:unsafenote/model/note_model.dart';

class NoteElement extends StatelessWidget {
  const NoteElement({Key? key, required this.note}) : super(key: key);
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Text(note.content)],
      ),
    );
  }
}
