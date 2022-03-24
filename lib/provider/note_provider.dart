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

  Future<NoteModel> addNote(NoteModel note) async {
    NoteModel _note = await NoteDb.instance.createNote(note);
    getNotes;
    return _note;
  }

  List<NoteModel> getNoteList() {
    return notes.toList();
  }

  void deleteNote(int? id) {
    notes.removeWhere((element) => element.id == id);
    notifyListeners();
    NoteDb.instance.delete(id);
  }
}
