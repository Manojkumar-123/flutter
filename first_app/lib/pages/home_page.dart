import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/pages/document_page.dart';
import 'package:first_app/pages/notes_page.dart';
import 'package:first_app/widgets/home_note_item.dart';
import 'package:first_app/widgets/home_page_documents.dart';
import 'package:first_app/widgets/home_page_notes.dart';
import 'package:first_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void onSelectScreen(String identifier, BuildContext context) {
    Navigator.pop(context);
    if (identifier == "Notes") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NotesScreen()));
    } else if (identifier == "Documents") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DocumentsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("First App"),
        ),
        drawer: MainDrawer(
          onSelectScreen: onSelectScreen,
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [HomeScreenNotes(), HomeScreenDocuments()],
          ),
        ));
  }
}
