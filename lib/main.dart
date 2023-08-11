import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/screens/login_screen.dart';
import 'package:instagram_app/utils/colors.dart';
import 'package:instagram_app/utils/dementaion.dart';
import 'package:instagram_app/responsive/mobile_screen_layout.dart';
import 'package:instagram_app/responsive/responsive_layout_screen.dart';
import 'package:instagram_app/responsive/web_screen_layout.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'instagram  Clone',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home:const ResponsiveLayout(
      //     webScreenLayout: WebScreenLayout(),
      //     mobileScreenLayout: MobileScreenLayout()),
      home: LoginScreens(),
    );
  }
}
