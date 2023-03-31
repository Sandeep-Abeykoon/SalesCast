import 'package:flutter/material.dart';

hexStringToColor(String hexColor){
  hexColor= hexColor.toUpperCase().replaceAll("#", "");
  if(hexColor.length==6){
    hexColor= "FF"+hexColor;
  }
  return Color(int.parse(hexColor,radix: 16));
}

//on boarding colours
const tOnBordingPage1color = Colors.white;
const tOnBordingPage2color = Color(0xfffddcdf);
const tOnBordingPage3color = Color(0xffffdcbd);