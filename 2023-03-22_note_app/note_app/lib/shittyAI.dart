import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotesPage(title: 'Notes'),
    );
  }
}

class NotesPage extends StatefulWidget {
  NotesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<String> _notes = [];

  TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notes = prefs.getStringList('notes') ?? [];
    });
  }

  Future<void> _saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notes', _notes);
  }

  void _addNote() {
    setState(() {
      _notes.add(_noteController.text);
      _noteController.clear();
      _saveNotes();
    });
  }

  void _editNoteAtIndex(int index) async {
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: TextField(
            controller: TextEditingController(text: _notes[index]),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('SAVE'),
              onPressed: () {
                Navigator.pop(context, _noteController.text);
              },
            ),
          ],
        );
      },
    );
    if (result != null) {
      setState(() {
        _notes[index] = result;
        _saveNotes();
      });
    }
  }

  void _deleteNoteAtIndex(int index) {
    setState(() {
      _notes.removeAt(index);
      _saveNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: _notes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_notes[index]),
              onTap: () => _editNoteAtIndex(index),
              onLongPress: () => _deleteNoteAtIndex(index),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Add Note'),
            content: TextField(
              controller: _noteController,
              autofocus: true,
            ),
            actions: <Widget>[
        TextButton(
        child: Text('CANCEL'),
    onPressed: () {
    Navigator.pop(context);
    },
    ),
    TextButton(
    child: Text('SAVE'),
    onPressed: () {

      _addNote();
      Navigator.pop(context);
    },
    ),
            ],
        );
          },
      );
        },
          tooltip: 'Add Note',
          child: Icon(Icons.add),
        ),
    );
  }
}