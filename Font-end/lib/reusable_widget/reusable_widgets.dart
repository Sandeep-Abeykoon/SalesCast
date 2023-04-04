import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:salescast/assets/colors.dart';

Image logoWidget(String imageName,double width,double height){
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: width,
    height: height,
  );
}
Material reusableTextfield(String text, IconData icon,bool isPasswordType,TextEditingController controller,bool isEmail,){
  return Material(




    child: TextFormField(

      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      autofillHints: [AutofillHints.email],
      cursorColor: Colors.grey,



      validator: (text){

        if(text!.isEmpty){
          return "This Field Cannot be empty";
        }
        if(isEmail&&!EmailValidator.validate(text, true)){

          return "Invalid Email Address";
        }
        return null;
      },

      style: TextStyle(color: Colors.black.withOpacity(0.9)),
      decoration: InputDecoration(
        hintText: text,
        prefixIcon: Icon(
          icon,color: Colors.grey ,
        ),


        labelText: text,
        labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 5,style: BorderStyle.solid),
        ),
      ),
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    ),
  );

}
Container logInSignUpButton(BuildContext context,bool isLogin, Function onTap){
  return Container(
    width:300 ,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      child: Text(
        isLogin ? 'LOGIN' : 'SIGNUP',
        style: const TextStyle(
            color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 16
        ),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if(states.contains(MaterialState.pressed)){
              return hexStringToColor("#b2d8d8");
            }
            return Colors.deepPurple.shade500;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))
      ),
    ),
  );

}
Container addProductsField(String text,TextEditingController controller, bool isQuantityOrPrice){
  return Container(
    decoration: BoxDecoration(


      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black12.withOpacity(0.1),
          blurRadius: 8,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: TextFormField(

      controller: controller,
      autocorrect: true,
      cursorColor: Colors.grey,

      keyboardType: isQuantityOrPrice
          ? TextInputType.numberWithOptions()
          : TextInputType.multiline,
      validator: (text){

        if(text!.isEmpty){
          return "This Field Cannot be empty";
        }

      },
      onSaved: (value){
        value=controller as String?;
      },

      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(



        labelText: text,
        labelStyle: TextStyle(color: Colors.black54),

        filled: true,
        fillColor: Colors.grey.withOpacity(0.3),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 0,style: BorderStyle.solid),
        ),
      ),

    ),
  );

}


class DropdownMenuItemWithImage {
  final String id;
  final String title;
  final String imagePath;

  DropdownMenuItemWithImage({
    required this.id,
    required this.title,
    required this.imagePath,
  });
}

class CustomDropdownButton extends StatefulWidget {
  final List<DropdownMenuItemWithImage> items;
  final String hint;
  final Function(DropdownMenuItemWithImage?) onChanged;

  CustomDropdownButton({
    required this.items,
    required this.hint,
    required this.onChanged,

  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 5),
          ),
        ],

        color: Colors.grey.withOpacity(0.3),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(

          fillColor: Colors.black38.withOpacity(0.3),
        ),
        value: selectedValue,
        hint: Text(
          widget.hint,
          style: TextStyle(color: Colors.black54),
        ),
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });

          var selectedItem = widget.items.firstWhere((item) => item.id == value);
          widget.onChanged(selectedItem);
        },
        items: widget.items.map((item) {
          return DropdownMenuItem<String>(
            value: item.id,
            child: Row(
              children: [
                Image.asset(
                  item.imagePath,
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 20),
                Text(item.title),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

