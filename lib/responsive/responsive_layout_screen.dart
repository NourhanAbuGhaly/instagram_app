import 'package:flutter/material.dart';
import 'package:instagram_app/provider/user_provider.dart';
import 'package:instagram_app/utils/global_variable.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout(
      {super.key,
      required this.webScreenLayout,
      required this.mobileScreenLayout});

  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    addData();
    // TODO: implement initState
    super.initState();
  }
  Future<void> addData()async{
    UserProvider _userProvider= Provider.of(context,listen: false);
    await _userProvider.refreshUser();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return widget.webScreenLayout;
      } else {
        return widget.mobileScreenLayout;
      }
    });
  }
}
