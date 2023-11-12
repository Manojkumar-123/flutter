import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/model/notes.dart';
import 'package:first_app/pages/editnote_page.dart';
import 'package:first_app/services/notes_service.dart';
import 'package:first_app/widgets/note_item.dart';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;
  List<Notes> _userNotes = [];

  @override
  void initState() {
    super.initState();
  }

  void pushEditNotePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => const EditNoteScreen('', '', ''))));
  }

  Future<void> addNotes() async {
    const uuid = Uuid();
    String nid = uuid.v4();
    String res = await NotesService().addNewNote(
        uid: _user!.uid, nid: nid, notes: "notes", title: "My note");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
              onPressed: () {
                pushEditNotePage();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .collection('notes')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              padding: const EdgeInsets.all(12),
              child: NoteItem(
                notes: snapshot.data!.docs[index].data()['notes'],
                title: snapshot.data!.docs[index].data()['title'],
                nid: snapshot.data!.docs[index].data()['nid'],
                uid: _user!.uid,
              ),
            ),
          );
        },
      ),
    );
  }
}
