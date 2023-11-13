import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/widgets/home_note_item.dart';
import 'package:flutter/material.dart';

class HomeScreenNotes extends StatelessWidget {
  const HomeScreenNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('notes')
            .orderBy('date', descending: true)
            .limit(3)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(16.0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Notes',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(0),
                              height: 250,
                              child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (ctx, index) => Container(
                                  padding: const EdgeInsets.all(12),
                                  child: HomeNoteItem(
                                    notes: snapshot.data!.docs[index]
                                        .data()['notes'],
                                    title: snapshot.data!.docs[index]
                                        .data()['title'],
                                    nid: snapshot.data!.docs[index]
                                        .data()['nid'],
                                    uid: FirebaseAuth.instance.currentUser!.uid,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ));
        });
  }
}
