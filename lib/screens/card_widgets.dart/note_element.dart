import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:unsafenote/model/note_model.dart';
import 'package:unsafenote/provider/note_provider.dart';

class NoteElement extends StatelessWidget {
  const NoteElement({Key? key, required this.note}) : super(key: key);
  final NoteModel note;

  void deleteOnHold(BuildContext context) {
    context.read<NoteProvider>().deleteNote(note.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        deleteOnHold(context);
      },
      child: Card(
        child: ListTile(
          //leading: Icon(Icons.music_note),
          subtitle: Text(note.content),
        ),
        elevation: 8,
        shadowColor: Colors.black,
        margin: const EdgeInsets.all(20),
      ),
    );
  }
}
