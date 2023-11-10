import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/model/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({required email, required password}) async {
    String res = "Something went Wrong";
    try {
      if (email != null && password != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.User user = model.User(
          uid: cred.user!.uid,
          email: email,
        );

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = "success";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> LoginUser({required email, required password}) async {
    String res = "Something went wrong";
    try {
      if (email != null && password != null) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
