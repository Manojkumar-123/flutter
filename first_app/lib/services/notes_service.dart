import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/model/notes.dart';

class NotesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addNewNote(
      {required uid, required nid, required notes, required title}) async {
    String res = "Something went wrong";
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('notes')
          .doc(nid)
          .set(Notes(
                  nid: nid,
                  notes: notes,
                  title: title,
                  dateTime: DateTime.now())
              .toJson());
      res = "success";
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> deleteNote(String uid, String nid) async {
    String res = "Something went wrong";
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('notes')
          .doc(nid)
          .delete();
      res = "success";
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
