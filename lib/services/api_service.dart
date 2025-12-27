import 'package:frontend/models/notes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';

class ApiService {
  static final String _baseUrl = "";
  static Future<void> addNote(Note note) async{
    Uri requestUri = Uri.parse("$_baseUrl/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }
  static Future<void> deleteNote(Note note) async{
    Uri requestUri = Uri.parse("$_baseUrl/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }
  static Future<List<Note>> fetchNotes(String userid) async{
    Uri requestUri = Uri.parse("$_baseUrl/lists");
    var response = await http.post(requestUri, body: {"userid" : userid});
    var decoded = jsonDecode(response.body);
    List<Note> notes =[];
    for(var noteMap in decoded){
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }
    return notes;
  }

}