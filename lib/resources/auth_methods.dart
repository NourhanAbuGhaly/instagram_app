import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
   //  required Uint8List file
      }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty
     //     || file != null
      ) {
        // register user

        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
   // add user to our database
   print (cred.user!.displayName);
   print (cred.user!.uid);
   // first way add user to firestore

   await _firestore.collection('users').doc(cred.user!.uid).set({
     'username':username,
     'uid':cred.user!.uid,
     'email':email,
     'bio':bio,
     'followers':[],
     'following':[]

   });
   // second way add user to firestore

   // await _firestore.collection('users').add({
   //   'username':username,
   //   'uid':cred.user!.uid,
   //   'email':email,
   //   'bio':bio,
   //   'followers':[],
   //   'follwing':[]
   //
   // });
   res="success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
