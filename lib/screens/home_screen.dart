import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/screens/product_add_page.dart';
import 'package:firebase_test/screens/signin_screen.dart';
import 'package:flutter/material.dart';

import 'my_records_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Home Page"
        ),
      ),
      backgroundColor: Colors.grey,
      body: Container(
        padding: const EdgeInsets.only(top: 300),
        child: Center(
          child: Column(
            children: <Widget>[

              ElevatedButton(
                  child: const Text("My Records"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MyRecordsPage()));
                  }
              ),

              ElevatedButton(
                  child: const Text("Add Product"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ProductAddPage()));
                  }
                  ),
              ElevatedButton(
              child: const Text("Logout"),
                  onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignInScreen()));
                });
              }
              ),
            ],
          ),
        ),
      ),
    );
  }
}








