import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:unsafenote/model/note_model.dart';
import 'package:unsafenote/provider/note_provider.dart';
import 'package:unsafenote/screens/card_widgets.dart/dialog.dart';

class NoteElement extends StatelessWidget {
  const NoteElement({Key? key, required this.note}) : super(key: key);
  final NoteModel note;

  void deleteOnHold(BuildContext context) {
    context.read<NoteProvider>().deleteNote(note.id);
  }

  _onDelteDialogButton(BuildContext context) {
    ValidateOnDelete validate = ValidateOnDelete(
        title: "Delete?",
        onYes: () async {
          deleteOnHold(context);
        },
        onNo: () {});

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return validate;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _onDelteDialogButton(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          constraints: const BoxConstraints(minHeight: 50, minWidth: 50),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.0, 2.0))
              ]),
          child: ListTile(
            //leading: Icon(Icons.music_note),
            subtitle: Text(note.content),
          ),
          margin: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
