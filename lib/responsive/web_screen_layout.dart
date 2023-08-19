import 'package:flutter/material.dart';
import 'package:instagram_app/utils/colors.dart';
class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Container(color: primaryColor,child: Text("This is a web", style: TextStyle(color: Colors.white),),),);
  }
}
