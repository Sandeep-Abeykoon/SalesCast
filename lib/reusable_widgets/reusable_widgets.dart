import 'package:flutter/material.dart';

TextField reusableTextField(
  String text,
  IconData icon,
  bool isPasswordType,
  TextEditingController controller){

  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(
      color: Colors.white.withOpacity(0.9)
    ),
    decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: (const BorderSide(width: 0, style:BorderStyle.none )
            ),
        )
    ),
    keyboardType: isPasswordType ?
      TextInputType.visiblePassword :
      TextInputType.emailAddress,
  );
}

Container signInSignUpButton(
  BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          }
          return Colors.white;
        }
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
          )
        )
      ),
      child: Text(
        isLogin ? "LOG IN" : "SIGN UP",
        style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16
        ),
      ),
    )
  );
}

TextField addProductTextField(
    TextEditingController controller,
    String text){
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: text,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black
        )
      ),
    ),
  );
}