import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/authenticate/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/Customer.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Register register = Register();
  final GoogleSignIn googleSignIn = GoogleSignIn();

// ---------------------------- Register Function ----------------------------
  Future RegisterWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// ---------------------------- Login Function ----------------------------

  Future SignInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// ---------------------------- LogOut Function ----------------------------

  Future SignOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
