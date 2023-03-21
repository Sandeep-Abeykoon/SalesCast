import 'package:flutter/material.dart';
import 'package:products/pages/Homepage.dart';
import 'package:products/pages/userprofile.dart';

void main() =>runApp(MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
    "/":(context)=>userprofile()

    },

      );

  }
}

