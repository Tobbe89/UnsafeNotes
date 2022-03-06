import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:unsafenote/db/NoteDb.dart';
import 'package:unsafenote/main.dart';
import 'package:unsafenote/model/note_model.dart';
import 'package:unsafenote/provider/note_provider.dart';
import 'package:unsafenote/screens/first.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String? header;
  late String content;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void addSong(BuildContext context) {
    final note = NoteModel(
        header: header, content: content, createdTime: DateTime.now());

    context.read<NoteProvider>().addNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formkey,
            child: ListView(
              children: [
                TextFormField(
                  // validator: (value) {
                  //   if (value?.isEmpty ?? true) {
                  //     return "Skriv din header";
                  //   } else {
                  //     return null;
                  //   }
                  // },
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            if (!_formkey.currentState!.validate())
              {_formkey.currentState!.save()}
            else
              {
                addSong(context),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()))
              }
          },
        ));
  }
}