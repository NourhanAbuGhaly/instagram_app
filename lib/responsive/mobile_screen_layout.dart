import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/provider/user_provider.dart';
import 'package:instagram_app/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:instagram_app/models/user.dart' as models;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";
  int _page = 0;
  late PageController pageController;

  void initState() {
    super.initState();
    pageController = PageController();
    //  getUsername();
  }

  @override
  void dispose() {
    pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // void getUsername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   print(snap);
  //   setState(() {
  //     username = (snap.data()! as Map<String, dynamic>)['username'];
  //   });
  // }

  void navigationTapeed(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    // models.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: PageView(
        children: [
          Text("read"),
          Text("search"),
          Text("add post"),
          Text("notification"),
          Text("profile"),

        ],
        controller: pageController,
        //onPageChanged:,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(icon: Icon(
            Icons.home, color: _page == 0 ? primaryColor : secondaryColor,),
              label: " ",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(
            Icons.search, color: _page == 1 ? primaryColor : secondaryColor,),
              label: " ",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle,
            color: _page == 2 ? primaryColor : secondaryColor,),
              label: " ",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(
            Icons.favorite, color: _page == 3 ? primaryColor : secondaryColor,),
              label: " ",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(
            Icons.person, color: _page == 4 ? primaryColor : secondaryColor,),
              label: " ",
              backgroundColor: primaryColor),
        ], onTap: navigationTapeed,
      ),

    );
  }
}
