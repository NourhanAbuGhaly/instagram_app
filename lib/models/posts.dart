import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final  datePublish;
  final String postUrl;
  final String profImage;
  final likes;

  Posts(
      {required this.description,
      required this.uid,
      required this.postId,
      required this.username,
      required this.datePublish,
      required this.postUrl,
      required this.profImage,
      required this.likes});

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "postId": postId,
        "username": username,
        "datePublish": datePublish,
        "postUrl": postUrl,
        "profImage": profImage,
        "likes": likes,
      };

  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Posts(
      description: snapshot["description"],
      uid: snapshot["uid"],
      postId: snapshot["postId"],
      username: snapshot["username"],
      datePublish: snapshot["datePublish"],
      postUrl: snapshot["postUrl"],
      profImage: snapshot["profImage"],
      likes: snapshot["likes"],
    );
  }
}
