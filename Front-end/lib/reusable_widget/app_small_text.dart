import 'package:flutter/material.dart';

class AppSmallText extends StatelessWidget {
  double size;
  final Color color;
  final String text;

  AppSmallText(
      {Key? key, this.size = 15, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
