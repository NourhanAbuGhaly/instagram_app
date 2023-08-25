import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  FollowButton(
      {super.key,
       this.function,
      required this.backGroungColor,
      required this.borderColor,
      required this.text,
      required this.textColor});

  final Function()? function;
  final Color backGroungColor;
  final Color borderColor;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 28),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: backGroungColor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 250,
          height: 27,
        ),
      ),
    );
  }
}
