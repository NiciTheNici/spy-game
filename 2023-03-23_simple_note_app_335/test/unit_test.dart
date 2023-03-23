import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_note_app/form_controller.dart';
import 'package:simple_note_app/note.dart';

void main() {
  group('Controller tests', () {
    SharedPreferences.setMockInitialValues({}); // Mocking SharedPreferences

    test('loadNotes() returns an empty list when no notes are saved', () async {
      final FormController controller = FormController();
      final notes = await controller.loadNotes();
      expect(notes, []);
    });

    test('saveNotes() saves notes correctly', () async {
      final FormController _controller = FormController();
      final notes = [
        Note(title: "Title 1", content: "Content 1"),
        Note(title: "Title 2", content: "Content 2"),
        Note(title: "Title 3", content: "Content 3"),
      ];
      await _controller.saveNotes(notes);
      final savedNotes = await _controller.loadNotes();

      for (int i = 0; i < notes.length; i++) {
        expect(savedNotes[i].title, equals(notes[i].title));
        expect(savedNotes[i].content, equals(notes[i].content));
      }
    });

    test('loadNotes() returns saved notes correctly', () async {
      final FormController _controller = FormController();
      final notes = [
        Note(title: "Title 1", content: "Content 1"),
        Note(title: "Title 2", content: "Content 2"),
        Note(title: "Title 3", content: "Content 3"),
      ];
      await _controller.saveNotes(notes);
      final savedNotes = await _controller.loadNotes();
      for (int i = 0; i < notes.length; i++) {
        expect(savedNotes[i].title, equals(notes[i].title));
        expect(savedNotes[i].content, equals(notes[i].content));
      }
    });
  });
}
