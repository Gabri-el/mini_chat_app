import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore database = FirebaseFirestore.instance;

  //current user
  String currentUsert() {
    return auth.currentUser!.uid;
  }

  //sign  an account
  Future<UserCredential> signInPasswordAndEmail(
      String password, String email) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      //adding the user  to database
      await database.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": userCredential.user!.email
      });
      return userCredential;
    } on FirebaseAuthException catch (error) {
      throw (error.code);
    }
  }

  //create an account
  Future<UserCredential> createAccountWithPasswordAndEmail(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //adding the user to database
      await database.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": userCredential.user!.email
      });
      return userCredential;
    } on FirebaseAuthException catch (error) {
      throw (error.code);
    }
  }

  //sign out
  static Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
