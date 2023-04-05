import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salescast/reusable_widget/app_large_text.dart';
import 'package:salescast/reusable_widget/app_small_text.dart';
import 'package:salescast/reusable_widget/reusable_widgets.dart';

import '../assets/colors.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              const Image(image: AssetImage("lib/assets/images/Forget_Password.png")),
              const SizedBox(height: 20,),
              AppLargeText(text: "Forget Password"),
              const SizedBox(height: 10,),
              AppSmallText(text: "Enter your email address to reset the Password", color: Colors.black45),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(child: Column(
                  children: [
                    reusableTextfield("Email", Icons.alternate_email, false, _emailController, true),
                    const SizedBox(height: 30,),
                    SizedBox(height: 40,
                      width: 80,
                      child: ElevatedButton(
                        onPressed: (){
                          FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                              if(states.contains(MaterialState.pressed)){
                                return hexStringToColor("#000000");
                              }
                              return Colors.deepPurple.shade500;
                            }),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))
                        ),
                        child: const Text("Next"),
                      ),)

                  ],
                )),
              )

            ],
          ),
        ),
      ),
    );
  }
}
