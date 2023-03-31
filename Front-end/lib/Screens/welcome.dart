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
        decoration: BoxDecoration(
          color: Colors.white12.withOpacity(0.6)
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery
                .of(context)
                .size
                .height*0.1, 20, 0),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(0,0, 0,0),
                    child: Image(image: AssetImage("lib/assets/images/OnBoardImages/Image_2.png"))),


                // logoWidget("lib/assets/images/logo.png"),
                SizedBox(
                  height: 10,
                ),
                Text("Let's begin by login or sign in",style: TextStyle(fontFamily: "Poppins",fontSize: 24,fontWeight:FontWeight.w300,color: Colors.black),),
                SizedBox(height: 10,),
                logInSignUpButton(context, true, () {

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }

                ),
                logInSignUpButton(context, false, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                }),


                SizedBox(
                  height: 10,
                ),
                Container(
                  width:300 ,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),

                  child: ElevatedButton(
                    // style: ElevatedButton.styleFrom(
                    //   foregroundColor: Colors.black, backgroundColor: Colors.transparent,
                    // ),
                    onPressed: () {

                      AuthService().googleSignIn();
                      setState(() {
                        
                      });
                    },
                    style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith((states) {
                                if(states.contains(MaterialState.pressed)){
                                  return hexStringToColor("#b2d8d8");
                                }
                                return Colors.deepPurple.shade500;
                              }),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
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


                //signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }


}