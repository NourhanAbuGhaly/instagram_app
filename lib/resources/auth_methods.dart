import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseStorage _firestore=FirebaseStorage.instance;
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // register user
   UserCredential cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
   // add user to our database
   print (cred.user?.displayName);
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
