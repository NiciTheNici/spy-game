import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'note.dart';

class FormController {
  static const String _notesCountKey = 'notesCount';

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_notesCountKey, notes.length);

    for (int i = 0; i < notes.length; i++) {
      await prefs.setString('noteTitle_$i', notes[i].title);
      await prefs.setString('noteContent_$i', notes[i].content);
      await prefs.setString('noteImagePath_$i', notes[i].imagePath ?? '');
    }
  }

  Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesCount = prefs.getInt(_notesCountKey) ?? 0;

    List<Note> notes = [];

    for (int i = 0; i < notesCount; i++) {
      String? title = prefs.getString('noteTitle_$i');
      String? content = prefs.getString('noteContent_$i');
      String? imagePath = prefs.getString('noteImagePath_$i');

      if (title != null && content != null) {
        notes.add(Note(title: title, content: content, imagePath: imagePath));
      }
    }

    return notes;
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
