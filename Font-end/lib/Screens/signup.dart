import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:salescast/Screens/home.dart';
import 'package:salescast/Screens/main_page.dart';
import 'package:salescast/reusable_widget/reusable_widgets.dart';
import 'package:email_validator/email_validator.dart';

import '../assets/colors.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  CollectionReference Products= FirebaseFirestore.instance.collection("Products");
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  final GlobalKey<FormState> _formkey= GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "SignUp",style: TextStyle(
            fontSize: 24,fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: Container(
        width: 1000,
        height: 1000,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("#008080"),
            hexStringToColor("#b2d8d8"),
            hexStringToColor("#66b2b2")
          ],begin: Alignment.topCenter,end: Alignment.bottomCenter)
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height*0.2, 20,0),
              child: Column(

                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextfield("Enter User Name", Icons.person, false,_userNameTextController,false),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextfield("Enter Email Id", Icons.mail, false,_emailTextController,true),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextfield("Enter a Strong Password", Icons.lock, true,_passwordTextController,false ),
                  const SizedBox(
                    height: 20,
                  ),
                  logInSignUpButton(context, false, (){
                    if(
                    _formkey.currentState!.validate()){
                      _formkey.currentState?.save();
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text).then((value) => {Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>MainPage()))

                      });




                    }}),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
