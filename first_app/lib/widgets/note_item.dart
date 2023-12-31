import 'package:first_app/pages/editnote_page.dart';
import 'package:first_app/services/notes_service.dart';
import 'package:flutter/material.dart';

class NoteItem extends StatelessWidget {
  const NoteItem(
      {super.key,
      required this.title,
      required this.notes,
      required this.nid,
      required this.uid});

  final String title;
  final String notes;
  final String nid;
  final String uid;

  void onItemTapped(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditNoteScreen(title, notes, nid)));
  }

  void DeleteNote() async {
    await NotesService().deleteNote(uid, nid);
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete $title"),
          content: const Text("Are you sure you need to delete this note"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                DeleteNote();
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDeleteDialog(context);
      },
      child: InkWell(
        onTap: () {
          onItemTapped(context);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
        ),
      ),
    );
  }
}
