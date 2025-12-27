import 'package:flutter/cupertino.dart';
import 'package:frontend/models/notes.dart';
import 'package:frontend/services/api_service.dart';

class NotesProvider with ChangeNotifier{
  List<Note> notes = [];
  bool isLoading = true;

  NotesProvider(){
    fetchNotes();
  }

  void sortNotes(){
    notes.sort((a,b) => b.dateadded!.compareTo(a.dateadded!));
  }

  void addNote(Note note){
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }
  void updateNote(Note note){
    int index = notes.indexWhere((n) => n.id == note.id);
    if(index == -1) return;
    notes[index] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }
  void deleteNote(Note note){
    int index = notes.indexWhere((n) => n.id == note.id);
    if(index == -1) return;
    notes.removeAt(index);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async{
    notes = await ApiService.fetchNotes("psp61");
    sortNotes();
    isLoading = false;
    notifyListeners();
  }

}