import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_app/models/posts.dart';
import 'package:instagram_app/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploade(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "some error  occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("posts", file, true);
      String postId = const Uuid().v1();
      Posts post = Posts(
          description: description,
          uid: uid,
          postId: postId,
          username: username,
          datePublish: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);
      _firestore.collection("posts").doc(postId).set(post.toJson());
      res="success";
    } catch (err) {
      res =err.toString();
    }
    return res;
  }
}
