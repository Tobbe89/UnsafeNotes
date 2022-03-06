import 'package:flutter/widgets.dart';
import 'package:unsafenote/db/NoteDb.dart';
import 'package:unsafenote/model/note_model.dart';

class NoteProvider extends ChangeNotifier {
  late List<NoteModel> notes = [];

  NoteProvider() {
    getNotes;
  }

  Future<void> get getNotes async {
    notes = await NoteDb.instance.readAllNotes();
    notifyListeners();
  }

  void addNote(NoteModel note) async {
    await NoteDb.instance.createNote(note);
    getNotes;
  }

  void deleteNote(int id) {
    notes.removeWhere((element) => element.id == id);
    notifyListeners();
    NoteDb.instance.delete(id);
  }
}
