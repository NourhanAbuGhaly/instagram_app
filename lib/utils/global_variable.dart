import 'package:flutter/material.dart';
import 'package:instagram_app/screens/add_post_screens.dart';
import 'package:instagram_app/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreensItems = [
  FeedScreen(),
  Text("search"),
  AddPostScreens(),
  Text("notification"),
  Text("profile"),
];
