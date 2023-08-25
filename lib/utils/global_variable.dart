import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/screens/add_post_screens.dart';
import 'package:instagram_app/screens/feed_screen.dart';
import 'package:instagram_app/screens/profile_screen.dart';
import 'package:instagram_app/screens/searh_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreensItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreens(),
  Text("notification"),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  )
];
