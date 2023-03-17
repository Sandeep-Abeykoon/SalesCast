import 'package:flutter/material.dart';
import 'package:salescast/Screens/login.dart';
import 'package:salescast/Screens/signup.dart';
import 'package:salescast/assets/colors.dart';
import 'package:salescast/auth_service.dart';
import 'package:salescast/reusable_widget/reusable_widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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

                logInSignUpButton(context, true, () {

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }

                ),
                logInSignUpButton(context, false, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                }), SizedBox(
                  height: 10,
                ),
                Container(
                  width:MediaQuery.of(context).size.width ,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),

                  child: ElevatedButton(
                    // style: ElevatedButton.styleFrom(
                    //   foregroundColor: Colors.black, backgroundColor: Colors.transparent,
                    // ),
                    onPressed: () {
                      AuthService().googleSignIn();
                    },
                    style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith((states) {
                                if(states.contains(MaterialState.pressed)){
                                  return hexStringToColor("#b2d8d8");
                                }
                                return hexStringToColor("#66b2b2");
                              }),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Image(
                            image: AssetImage("lib/assets/images/google-logo-9808.png"),
                            height: 18.0,
                            width: 24,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 24, right: 8),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),



























                // Container(
                //   width:MediaQuery.of(context).size.width ,
                //   height: 50,
                //   margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(150)),
                //   child: ElevatedButton(
                //
                //       onPressed:(){
                //     AuthService().signInWithGoogle();
                //
                //
                //   },
                //
                //
                //       , child: Text("Sign in With Google", style: const TextStyle(
                //           color: Colors.black87, fontWeight: FontWeight.bold,fontSize: 16
                //       ),
                //       ),
                //     style: ButtonStyle(
                //         backgroundColor: MaterialStateProperty.resolveWith((states) {
                //           if(states.contains(MaterialState.pressed)){
                //             return Colors.teal;
                //           }
                //           return Colors.white;
                //         }),
                //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
                //     ),
                //   ),
                // ),


                SizedBox(
                  height: 5,
                ),

                //signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }


}