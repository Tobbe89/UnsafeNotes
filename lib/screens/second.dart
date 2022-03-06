import 'package:flutter/material.dart';
import 'package:unsafenote/db/NoteDb.dart';
import 'package:unsafenote/model/note_model.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String header;
  late String content;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future addSong() async {
    final note = NoteModel(
        header: header, content: content, createdTime: DateTime.now());

    await NoteDb.instance.createNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: ListView(
        children: [
          TextFormField(
            onChanged: (value) => {setState(() => header = value)},
          ),
          TextFormField(
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Skriv din note";
              } else {
                return null;
              }
            },
            onChanged: (value) => {setState(() => content = value)},
          )
        ],
      )),
    );
  }
}
