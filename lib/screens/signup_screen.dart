
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/reusable_widgets/reusable_widgets.dart';
import 'package:firebase_test/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.grey
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Email", Icons.person_outlined, false, _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Password", Icons.lock_outlined, true, _passwordTextController),
              const SizedBox(
                height: 20,
              ),
              signInSignUpButton(context, false, () {
                FirebaseAuth.instance.createUserWithEmailAndPassword(
                  //TODO Input validation
                    email: _emailTextController.text,
                    password: _passwordTextController.text)
                    .then((value){
                      print("Created New Account");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()));
                }).onError((error, stackTrace) {
                  print("Error : $error");
                });
              })
            ],
          ),
        ),
      ),
    );
  }
}
