class User{
  final String email;
  final String uid;
  final String username;
  final String photoUrl;
  final String bio;
  final List followers;
  final List following;

  User(
      {required this.email,
        required this.uid,
        required this.photoUrl,
        required  this.username,
        required this.bio,
        required this.followers,
        required this.following});
  Map<String , dynamic> toJson()=>{
    "username":username,
    "uid":uid,
    "email":email,
    "bio":bio,
    "photoUrl":photoUrl,
    "followers":followers,
    "following":following
  };

}