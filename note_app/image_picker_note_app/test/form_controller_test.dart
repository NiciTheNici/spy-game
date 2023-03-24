import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_note_app/form_controller.dart';
import 'package:simple_note_app/note.dart';

void main() {
  final FormController formController = FormController();

  group('FormController', () {
    test('submitForm should print note information', () {
      // Capture the print statement
      List<String> log = [];
      var spec = ZoneSpecification(print: (_, __, ___, String msg) {
        log.add(msg);
      });
      Zone zone = Zone.current.fork(specification: spec);

      zone.run(() {
        formController
            .submitForm(Note(title: 'Test Title', content: 'Test Content'));
      });

      // Verify the print statement
      expect(log.length, 1);
      expect(log.first, 'Submitted: Title: Test Title, Content: Test Content');
    });

    test('validateTitle should return null when title is not empty', () {
      expect(formController.titleValidator('Test Title'), null);
    });

    test('validateTitle should return an error message when title is empty',
        () {
      expect(formController.titleValidator(''), 'Please enter a title');
    });

    test('validateContent should return null when content is not empty', () {
      expect(formController.contentValidator('Test Content'), null);
    });

    test('validateContent should return an error message when content is empty',
        () {
      expect(formController.contentValidator(''), 'Please enter content');
    });
  });
}
