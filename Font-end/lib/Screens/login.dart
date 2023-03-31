


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salescast/Screens/home.dart';
import 'package:salescast/Screens/main_page.dart';
import 'package:salescast/Screens/signup.dart';
import 'package:salescast/assets/colors.dart';
import 'package:salescast/reusable_widget/reusable_widgets.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  final GlobalKey<FormState> _formkey= GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
        key: _formkey,

          child: Container(
            width: 1000,
            height: 1000,
            decoration: BoxDecoration(gradient: LinearGradient(
                colors: [
                  hexStringToColor("#008080"),
                  hexStringToColor("#b2d8d8"),
                  hexStringToColor("#66b2b2")],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, MediaQuery
                    .of(context)
                    .size
                    .height * 0.2, 20, 0),
                child: Column(
                  children: <Widget>[
                    logoWidget("lib/assets/images/logo.png"),
                    SizedBox(
                      height: 20,
                    ),
                    reusableTextfield(
                        "Email Address", Icons.mail, false, _emailTextController,true),
                    SizedBox(
                      height: 20,
                    ),
                    reusableTextfield(
                        "Password", Icons.lock, true, _passwordTextController,false),
                    SizedBox(
                      height: 20,
                    ),
                     logInSignUpButton(context, true, () {if(
                           _formkey.currentState!.validate()){
                            _formkey.currentState?.save();
                            FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text).then((value) => {
                                  Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>MainPage()))

                            });




                    }}),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Center(
                        child:  TextButton(
                          onPressed: (){

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>SignUpPage()));
                            },
                          child:Text("Forgot your password?",style: TextStyle(color: Colors.white70,fontSize: 16)),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child:  TextButton(
                          onPressed: (){

                             Navigator.push(context,
                           MaterialPageRoute(builder: (context)=>SignUpPage()));
                             },
                          child:Text("Don't have an account? SignUp",style: TextStyle(color: Colors.white70,fontSize: 16)),
                        ),

                      ),
                    ),
                    //signUpOption()
                  ],
                ),
              ),
            ),
          ),
        ),
     );
  }
}