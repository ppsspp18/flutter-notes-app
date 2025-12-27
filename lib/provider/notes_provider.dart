import 'package:flutter/cupertino.dart';
import 'package:frontend/models/notes.dart';

class NotesProvider with ChangeNotifier{
  List<Note> notes = [];

  void addNote(Note note){
    notes.add(note);
    notifyListeners();
  }

}