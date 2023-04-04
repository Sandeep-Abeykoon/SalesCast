import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:salescast/Screens/home.dart';
import 'package:salescast/Screens/main_page.dart';
import 'package:salescast/reusable_widget/app_large_text.dart';
import 'package:salescast/reusable_widget/app_small_text.dart';
import 'package:salescast/reusable_widget/reusable_widgets.dart';
import 'package:email_validator/email_validator.dart';

import '../assets/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  CollectionReference Products =
  FirebaseFirestore.instance.collection("Products");
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      extendBodyBehindAppBar: true,
      // l
      body: Container(
        width: 1000,
        height: 1000,
        decoration: BoxDecoration(),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  logoWidget("lib/assets/images/logo2.png", 200, 100),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(text: "Get On Board !"),
                        SizedBox(
                          height: 5,
                        ),
                        AppSmallText(
                            text: "Create your profile to start journey",
                            color: Colors.black45),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  reusableTextfield("Enter User Name", Icons.person_outlined,
                      false, _userNameTextController, false),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextfield("Enter Email", Icons.email_outlined, false,
                      _emailTextController, true),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextfield("Enter a Strong Password", Icons.password,
                      true, _passwordTextController, false),
                  const SizedBox(
                    height: 30,
                  ),
                  // logInSignUpButton(context, false, (){
                  //   if(
                  //   _formkey.currentState!.validate()){
                  //     _formkey.currentState?.save();
                  //     FirebaseAuth.instance.createUserWithEmailAndPassword(
                  //         email: _emailTextController.text,
                  //         password: _passwordTextController.text).then((value) => {Navigator.push(context,
                  //         MaterialPageRoute(builder: (context)=>MainPage()))
                  //
                  //     });
                  //
                  //
                  //
                  //
                  //
                  //   }}),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return hexStringToColor("#b2d8d8");
                            }
                            return Colors.deepPurple.shade500;
                          }),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState?.save();

                            _signIn(_emailTextController.text,
                                _passwordTextController.text);

                            //   try{ FirebaseAuth.instance.createUserWithEmailAndPassword(
                            //     email: _emailTextController.text,
                            //     password: _passwordTextController.text).then((value) => {
                            //  FirebaseAuth.instance.currentUser!.updateDisplayName(_userNameTextController.text),
                            //   Navigator.push(context,
                            //       MaterialPageRoute(builder: (context)=>MainPage()))
                            //
                            //
                            // });}on FirebaseAuthException catch (error){
                            //     print(error.message);
                            //     Fluttertoast.showToast(msg: error.message.toString(),gravity: ToastGravity.TOP);
                            //
                            //   }
                            //       catch(e){
                            //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                            //       }
                          }
                        },
                        child: Text("SIGNUP")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _signIn(String _email, String _password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((value) => {
        FirebaseAuth.instance.currentUser!
            .updateDisplayName(_userNameTextController.text),
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MainPage()))
      });
    } on FirebaseAuthException catch (error) {
      print(error.message);
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: error.message,
          backgroundColor: Colors.red,
          animType: CoolAlertAnimType.slideInDown);
    }
  }
}
