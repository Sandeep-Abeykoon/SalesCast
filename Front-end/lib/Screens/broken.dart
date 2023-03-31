import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
class Broken extends StatelessWidget {
  const Broken({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Image(image: AssetImage("lib/assets/images/3828537-removebg-preview.png")),
            SizedBox(height: 50,),
            Text("Sorry, This Page is Under Maintenance",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 40,),
            IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back))
          ],
        ),
      ),
    );
  }
}
