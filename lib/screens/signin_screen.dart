import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/screens/home_screen.dart';
import 'package:firebase_test/screens/signup_screen.dart';

import 'package:flutter/material.dart';

import '../reusable_widgets/reusable_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 300.0),
        decoration: const BoxDecoration(
          color: Colors.grey
          ),
            child: Column(
                children: <Widget>[
                  reusableTextField("Enter userName", Icons.person_2_outlined, false, _emailTextController),
                  const SizedBox(height: 20),
                  reusableTextField("Enter password", Icons.lock_outline, true, _passwordTextController),
                  const SizedBox(height: 20),
                  signInSignUpButton(context, true, () {
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text).then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()));
                    }).onError((error, stackTrace) {
                      print("Error : " + error.toString() );
                    });
                  }),
                  signUpOption()
              ]
            ),
        ),
      );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
            style: TextStyle(
                color: Colors.white70
            )
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
              color: Colors.white,fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

}
