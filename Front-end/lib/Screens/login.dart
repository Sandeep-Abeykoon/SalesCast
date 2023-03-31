import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salescast/Screens/foreget_password.dart';
import 'package:salescast/Screens/main_page.dart';
import 'package:salescast/Screens/signup.dart';
import 'package:salescast/assets/colors.dart';
import 'package:salescast/reusable_widget/reusable_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Form(
        key: _formkey,
        child: Container(
          width: 1000,
          height: 1000,
          decoration: BoxDecoration(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.1, 20, 0),
              child: Column(
                children: <Widget>[
                  logoWidget("lib/assets/images/logo.png", 240, 240),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextfield("Email Address", Icons.person_2_outlined,
                      false, _emailTextController, true),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextfield("Password", Icons.lock, true,
                      _passwordTextController, false),
                  SizedBox(
                    height: 20,
                  ),
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
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return hexStringToColor("#b2d8d8");
                            }
                            return Colors.deepPurple.shade500;
                          }),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState?.save();
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailTextController.text,
                                      password: _passwordTextController.text)
                                  .then((value) => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainPage()))
                                      });
                            } on FirebaseAuthException catch (error) {
                              print(error.message);
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: error.message,
                                  backgroundColor: Colors.red,
                                  animType: CoolAlertAnimType.slideInDown);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          }
                        },
                        child: Text("Login")),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassword()));
                        },
                        child: Text("Forgot your password?",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                        child: Text.rich(
                          TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(
                                    text: "Signup",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w400))
                              ]),
                        ),
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
