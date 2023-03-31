


<<<<<<< Updated upstream
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
=======
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salescast/Screens/foreget_password.dart';
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
      backgroundColor: Colors.white12,
>>>>>>> Stashed changes
        body: Form(
        key: _formkey,

          child: Container(
            width: 1000,
            height: 1000,
<<<<<<< Updated upstream
            decoration: BoxDecoration(gradient: LinearGradient(
                colors: [
                  hexStringToColor("#008080"),
                  hexStringToColor("#b2d8d8"),
                  hexStringToColor("#66b2b2")],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
=======
            decoration: BoxDecoration(
>>>>>>> Stashed changes
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, MediaQuery
                    .of(context)
                    .size
<<<<<<< Updated upstream
                    .height * 0.2, 20, 0),
                child: Column(
                  children: <Widget>[
                    logoWidget("lib/assets/images/logo.png"),
=======
                    .height * 0.1, 20, 0),
                child: Column(
                  children: <Widget>[
                    logoWidget("lib/assets/images/logo.png",240,240),
>>>>>>> Stashed changes
                    SizedBox(
                      height: 20,
                    ),
                    reusableTextfield(
<<<<<<< Updated upstream
                        "Email Address", Icons.mail, false, _emailTextController,true),
=======
                        "Email Address", Icons.person_2_outlined, false, _emailTextController,true),
>>>>>>> Stashed changes
                    SizedBox(
                      height: 20,
                    ),
                    reusableTextfield(
                        "Password", Icons.lock, true, _passwordTextController,false),
                    SizedBox(
                      height: 20,
                    ),
<<<<<<< Updated upstream
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
=======
                    //  logInSignUpButton(context, true, () {if(
                    //        _formkey.currentState!.validate()){
                    //         _formkey.currentState?.save();
                    //         FirebaseAuth.instance.signInWithEmailAndPassword(
                    //             email: _emailTextController.text,
                    //             password: _passwordTextController.text).then((value) => {
                    //               Navigator.push(context,
                    //         MaterialPageRoute(builder: (context)=>MainPage()))
                    //
                    //         });
                    //
                    //
                    //
                    //
                    // }}),

                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                          if(states.contains(MaterialState.pressed)){
                            return hexStringToColor("#b2d8d8");
                          }
                          return Colors.deepPurple.shade500;
                        }),
                        ),
                          onPressed: () async {
                            if(
                            _formkey.currentState!.validate()){
                              _formkey.currentState?.save();
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text)
                                    .then((value) =>
                                {
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) => MainPage()))
                                });
                              }  on FirebaseAuthException catch (error){
                                print(error.message);
                                CoolAlert.show(context: context, type:CoolAlertType.error,
                                    text: error.message,backgroundColor: Colors.red,animType: CoolAlertAnimType.slideInDown);

                              }


                              catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

                              }
                            }
                            },
                          child: Text("Login")),
                    ),
                    SizedBox(
                      height: 30,
>>>>>>> Stashed changes
                    ),
                    Container(
                      child: Center(
                        child:  TextButton(
                          onPressed: (){

                            Navigator.push(context,
<<<<<<< Updated upstream
                                MaterialPageRoute(builder: (context)=>SignUpPage()));
                            },
                          child:Text("Forgot your password?",style: TextStyle(color: Colors.white70,fontSize: 16)),
=======
                                MaterialPageRoute(builder: (context)=>ForgetPassword()));
                            },
                          child:Text("Forgot your password?",style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w400)),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                          child:Text("Don't have an account? SignUp",style: TextStyle(color: Colors.white70,fontSize: 16)),
=======
                          child:Text.rich(


                          TextSpan(text: "Don't have an account? ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: "Signup",
                              style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w400)

                            )
                          ]),
                      ),
>>>>>>> Stashed changes
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