import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/resources/storage_method.dart';
import 'package:instagram_app/models/user.dart' as models;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
Future <models.User> getUserDetails()async{
  User current =_auth.currentUser!;
  DocumentSnapshot snap =await _firestore.collection("users").doc(current.uid!).get();
  return models.User.fromSnap(snap);
}
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

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // add user to our database
        print(cred.user!.displayName);
        print(cred.user!.uid);
        // first way add user to firestore
        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);
        models.User user = models.User(
            username: username,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoUrl);
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
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
        res = "success";
      }
    }
    // on FirebaseAuthException catch (err) {
    //   if (err.code == "invalid-email") {
    //     res = "The email is badly formatted";
    //   } else if (err.code == "weak-password") {
    //     res = "Password should be at least 6 characters ";
    //   }
    //}
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "please enter all the fields";
      }
    }

    // on FirebaseAuthException catch (err) {
    //   if (err.code == "invalid-email") {
    //     res = "The email is badly formatted";
    //   } else if (err.code == "weak-password") {
    //     res = "Password should be at least 6 characters ";
    //   }
    //}
    catch (err) {
      res = err.toString();
    }
    return res;
  }
}
