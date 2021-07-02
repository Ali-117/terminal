import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notes_taking_app/helper/note_provider.dart';
import 'package:notes_taking_app/models/note.dart';
import 'package:notes_taking_app/utils/constants.dart';
import 'package:notes_taking_app/widget/delete_popup.dart';
import 'package:provider/provider.dart';

import 'note_edit_screen.dart';
class NoteViewScreen extends StatefulWidget {
  static const route='/note-view';
  @override
  _NoteViewScreenState createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {


  Note selectedNote;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context).settings.arguments;
    final provider = Provider.of<NoteProvider>(context);
    if (provider.getNote(id) != null) {
      selectedNote = provider.getNote(id);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(

        elevation: 0.7,
        backgroundColor: Color(0xFF1D1E33),
    leading: IconButton(
    icon: Icon(
    Icons.arrow_back,
    color: Colors.white,
    ),
    onPressed: () {
    Navigator.pop(context);
    },
    ),
    actions: [

    IconButton(
    icon: Icon(
    Icons.delete,
    color: Colors.white,
    ),
    onPressed: () => _showDialog(),
    ),
    ],
    ),
    body: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
    selectedNote?.title,
    style: viewTitleStyle,
    ),
    ),
    Row(
    children: [
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Icon(
    Icons.access_time,
    size: 18,
    ),
    ),
    Text('${selectedNote?.date}')
    ],
    ),
    if (selectedNote.imagePath != null)
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Image.file(File(selectedNote.imagePath)),
    ),
    Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
    selectedNote.content,
    style: viewContentStyle,
    ),
    ),
    ],
    ),
    ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF111828),
        onPressed: () {
          Navigator.pushNamed(context, NoteEditScreen.route,
              arguments: selectedNote.id);
        },
        child: Icon(Icons.edit),
      ),
    );
  }
  _showDialog() {
    showDialog(
        context: this.context,
        builder: (context) {
          return DeletePopUp(selectedNote: selectedNote);
        });
  }

}
