import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'note.dart';

class FormController {
  static const String _notesKey = 'notes';

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = json.encode(notes.map((note) => note.toJson()).toList());
    await prefs.setString(_notesKey, notesJson);
  }

  Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getString(_notesKey);

    if (notesJson != null) {
      List<dynamic> notesList = json.decode(notesJson);
      return notesList.map((noteJson) => Note.fromJson(noteJson)).toList();
    } else {
      return [];
    }
  }

  String? titleValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  String? contentValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter content';
    }
    return null;
  }

  void submitForm(Note note) {
    print('Submitted: Title: ${note.title}, Content: ${note.content}');
  }
}
