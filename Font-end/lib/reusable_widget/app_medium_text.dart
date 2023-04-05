import 'package:flutter/material.dart';

class AppMediumText extends StatelessWidget {
  double size;
  final Color color;
  final String text;

  AppMediumText({Key? key,
    this.size= 20,
    required this.text,
    this.color= Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),);
  }
}
