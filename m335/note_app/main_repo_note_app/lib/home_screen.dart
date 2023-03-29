import 'package:flutter/material.dart';
import 'form_controller.dart';
import 'note.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FormController _controller = FormController();
  Note _note = Note(title: '', content: '');
  List<Note> _notes = [];


  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final loadedNotes = await _controller.loadNotes();
    setState(() {
      _notes = loadedNotes;
    });
  }

  void _onTitleChanged(String value) {
    _note = Note(title: value, content: _note.content);
  }

  void _onContentChanged(String value) {
    _note = Note(title: _note.title, content: value);
  }

  void _onFormSubmitted(Note note) {
    setState(() {
      _notes.add(note);
      _controller.saveNotes(_notes);
      _clearNote();
    });
    _formKey.currentState!.reset();
  }

  void _clearNote() {
    _note = Note(title: '', content: '');
  }

  void _onNoteEdit(Note newNote, int i) {
    setState(() {
      _notes[i] = newNote;
      _controller.saveNotes(_notes);
      _clearNote();
    });
  }

  void _onDeletePressed(int index) {
    setState(() {
      _notes.removeAt(index);
      _controller.saveNotes(_notes);
    });
  }

  void _editNote(int i) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          _note = _notes[i];
          return AlertDialog(
            title: Text("Edit"),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Title'),
                      onChanged: _onTitleChanged,
                      controller: TextEditingController(text: _notes[i].title),
                      validator: (value) => _controller.titleValidator(value!),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Content'),
                      onChanged: _onContentChanged,
                      controller: TextEditingController(
                          text: _notes[i].content),
                      validator: (value) =>
                          _controller.contentValidator(value!),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("submitted!");
                    print(_note);
                    _controller.submitForm(_note);
                    _onNoteEdit(_note, i);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Note Edited')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],


          );
        });
  }

  Future<void> _showFormDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title'),
                    onChanged: _onTitleChanged,
                    validator: (value) => _controller.titleValidator(value!),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Content'),
                    onChanged: _onContentChanged,
                    validator: (value) => _controller.contentValidator(value!),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _controller.submitForm(_note);
                  _onFormSubmitted(_note);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Note Added')),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(_notes[index].title),
              subtitle: Text(_notes[index].content),
              onTap: () => _editNote(index),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _onDeletePressed(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
