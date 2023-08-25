import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/utils/colors.dart';
import 'package:instagram_app/utils/utils.dart';
import 'package:instagram_app/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.uid});

  final String uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postlength = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();

      ///get Post Length
//var postSnap= await FirebaseFirestore.instance.collection("posts").where('uid', isEqualTo: widget.uid).get();
      var postSnap = await FirebaseFirestore.instance
          .collection("posts")
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postlength = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!["followers"].length;
      following = userSnap.data()!["following"].length;
      isFollowing = userSnap
          .data()!["followers"]
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (err) {
      print(err.toString());
      showSnakbar(err.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(userData['username']),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(userData["photoUrl"]),
                      radius: 40,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStateColumn(postlength, "posts"),
                              buildStateColumn(followers, "followers"),
                              buildStateColumn(following, "following"),
                            ],
                          ),
                          Row(
                            children: [
                              FirebaseAuth.instance.currentUser!.uid ==
                                      widget.uid
                                  ? FollowButton(
                                      backGroungColor: mobileBackgroundColor,
                                      borderColor: Colors.grey,
                                      text: "Edit Profile",
                                      textColor: primaryColor,
                                      function: () {},
                                    )
                                  : isFollowing
                                      ? FollowButton(
                                          backGroungColor: Colors.white,
                                          borderColor: Colors.black,
                                          text: "Unfollow",
                                          textColor: Colors.grey,
                                          function: () {},
                                        )
                                      : FollowButton(
                                          backGroungColor: Colors.blue,
                                          borderColor: Colors.grey,
                                          text: "Follow",
                                          textColor: Colors.white),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    userData['username'].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 1),
                  child: Text(
                    userData['bio'],
                  ),
                )
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Column buildStateColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
