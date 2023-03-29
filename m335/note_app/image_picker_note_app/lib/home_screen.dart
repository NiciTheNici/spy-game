import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'form_controller.dart';
import 'note.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Note> _notes = [];
  final FormController _controller = FormController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title = '';
  String _content = '';
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _controller.loadNotes();
    setState(() {
      _notes.addAll(notes);
    });
  }

  void _onTitleChanged(String value) {
    _title = value;
  }

  void _onContentChanged(String value) {
    _content = value;
  }

  void _onFormSubmitted(Note note) {
    setState(() {
      _notes.add(note);
    });
    _controller.saveNotes(_notes);
  }

  void _onDeletePressed(int index) {
    setState(() {
      _notes.removeAt(index);
    });
    _controller.saveNotes(_notes);
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = image != null ? File(image.path) : null;
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
                  SizedBox(height: 16),
                  if (_imageFile != null)
                    Image.file(
                      _imageFile!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  TextButton(
                    onPressed: _pickImage,
                    child: Text('Pick Image'),
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
                  final note = Note(
                    title: _title,
                    content: _content,
                    imagePath: _imageFile?.path,
                  );
                  _controller.submitForm(note);
                  _onFormSubmitted(note);
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
      appBar: AppBar(title: Text('Notes 24.März')),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_notes[index].title),
            subtitle: Text(_notes[index].content),
            leading: _notes[index].imagePath != null
                ? Image.file(
                    File(_notes[index].imagePath!),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : null,
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _onDeletePressed(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(context),
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }
}
