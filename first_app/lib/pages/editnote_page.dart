import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/pages/notes_page.dart';
import 'package:first_app/services/notes_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notus/notus.dart';
import 'package:uuid/uuid.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen(this.title, this.notes, this.nid, {super.key});

  final String title;
  final String notes;
  final String nid;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  QuillController noteController = QuillController.basic();
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    noteController.document.insert(0, widget.notes);
    titleController.text = widget.title;
  }

  void CreateNote() async {
    const uuid = Uuid();
    final nid = widget.nid != '' ? widget.nid : uuid.v4();
    String res = await NotesService().addNewNote(
        uid: FirebaseAuth.instance.currentUser!.uid,
        nid: nid,
        notes: noteController.document.toPlainText(),
        title: titleController.text);
    if (res == 'success') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NotesScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: 'Title of your Note',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.all(0),
                height: 500,
                child: QuillProvider(
                  configurations: QuillConfigurations(
                    controller: noteController,
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('en'),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Card(
                          child: Padding(
                              padding: EdgeInsets.all(12),
                              child: QuillToolbar())),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: QuillEditor.basic(
                              configurations: const QuillEditorConfigurations(
                                readOnly: false,
                                autoFocus: true,
                                placeholder: 'Type here...',
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                  onPressed: () {
                    CreateNote();
                  },
                  child: const Text('Create Note'))
            ],
          ),
        ),
      ),
    );
  }
}
