import 'package:first_app/pages/notes_page.dart';
import 'package:first_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void onSelectScreen(String identifier, BuildContext context) {
    Navigator.pop(context);
    if (identifier == "Notes") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NotesScreen()));
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
      body: const Center(child: Text('Home Page')),
    );
  }
}
