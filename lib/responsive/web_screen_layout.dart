import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/utils/colors.dart';
import 'package:instagram_app/utils/global_variable.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  String username = "";
  int _page = 0;
  late PageController pageController;

  void initState() {
    super.initState();
    getUsername();
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
    setState(() {
      _page=page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print(snap);
    setState(() {
      username = (snap.data()! as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () => navigationTapeed(0),
            icon: Icon(
              Icons.home,
              color:_page==0? primaryColor:secondaryColor,
            ),
          ),
          IconButton(
            onPressed: ()  => navigationTapeed(1),
            icon: Icon(
              Icons.search,
              color:_page==1? primaryColor:secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => navigationTapeed(2),
            icon: Icon(
              Icons.add_a_photo,
              color:_page==2? primaryColor:secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => navigationTapeed(3),
            icon: Icon(
              Icons.favorite,
              color:_page==3? primaryColor:secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => navigationTapeed(4),
            icon: Icon(
              Icons.person,
              color:_page==4? primaryColor:secondaryColor,
            ),
          ),
        ],
      ),
      body: PageView(children: homeScreensItems,controller: pageController,onPageChanged: onPageChanged,)
    );
  }
}
