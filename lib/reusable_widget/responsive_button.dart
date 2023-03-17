import 'package:flutter/material.dart';
import 'package:salescast/assets/colors.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  ResponsiveButton({Key? key,this.width,this.isResponsive=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 120),
      width: width,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: hexStringToColor("#a6a6df"),
      ),
      child: Row(

        children: [
          Image.asset("lib/assets/images/next_button.png")
        ],

      ),
    );
  }
}
