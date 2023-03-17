import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:salescast/assets/colors.dart';

Image logoWidget(String imageName){
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
  );
}
Material reusableTextfield(String text, IconData icon,bool isPasswordType,TextEditingController controller,bool isEmail){
  return Material(

    child: TextFormField(

      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      autofillHints: [AutofillHints.email],
      cursorColor: Colors.white,


     validator: (text){

      if(text!.isEmpty){
        return "This Field Cannot be empty";
      }
      if(isEmail&&!EmailValidator.validate(text, true)){

       return "Invalid Email Address";
      }
      return null;
    },

      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,color: Colors.white70,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0,style: BorderStyle.none),
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
    width:MediaQuery.of(context).size.width ,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
        },
      child: Text(
        isLogin ? 'LOG IN' : 'SIGN UP',
        style: const TextStyle(
          color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 16
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if(states.contains(MaterialState.pressed)){
            return hexStringToColor("#b2d8d8");
          }
          return hexStringToColor("#66b2b2");
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
      ),
    ),
  );

}
Container addProdcutsField(String text,TextEditingController controller){
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


      validator: (text){

        if(text!.isEmpty){
          return "This Field Cannot be empty";
        }

      },
      onSaved: (value){
        value=controller as String?;
      },

      style: TextStyle(color: Colors.grey.withOpacity(0.9)),
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


// class DropdownMenuItemWithImage {
//   final String title;
//   final String imagePath;
//
//   DropdownMenuItemWithImage({
//     required this.title,
//     required this.imagePath,
//   });
// }
//
// class CustomDropdownButton extends StatefulWidget {
//   final List<DropdownMenuItemWithImage> items;
//   final String hint;
//   final Function(DropdownMenuItemWithImage?) onChanged;
//
//   CustomDropdownButton({
//     required this.items,
//     required this.hint,
//     required this.onChanged,
//   });
//
//   @override
//   _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
// }
//
// class _CustomDropdownButtonState extends State<CustomDropdownButton> {
//   DropdownMenuItemWithImage? selectedValue;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//
//         color: Colors.grey.withOpacity(0.3),
//       ),
//       child: DropdownButtonFormField(
//
//         decoration: InputDecoration(
//
//           fillColor: Colors.black38.withOpacity(0.3),
//
//         ),
//
//         value: selectedValue,
//         hint: Text(widget.hint,style: TextStyle(color: Colors.black54),),
//         onChanged: (value) {
//           setState(() {
//             selectedValue = value as DropdownMenuItemWithImage?;
//           });
//           widget.onChanged(value as DropdownMenuItemWithImage?);
//         },
//         items: widget.items.map((item) {
//           return DropdownMenuItem<DropdownMenuItemWithImage>(
//
//             value: item,
//             child: Row(
//
//               children: [
//
//                 Image.asset(
//                   item.imagePath,
//                   width: 40,
//                   height: 40,
//                 ),
//                 SizedBox(width: 20),
//                 Text(item.title),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
// }



// class CustomDropDown extends StatefulWidget {
//   final List<String> options;
//   final List<Widget> images;
//   final Function(String) onOptionSelected;
//
//   CustomDropDown({required this.options, required this.images, required this.onOptionSelected});
//
//   @override
//   _CustomDropDownState createState() => _CustomDropDownState();
// }
//
// class _CustomDropDownState extends State<CustomDropDown> {
//   String? selectedOption;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//           decoration: BoxDecoration(
//
//             color: Colors.grey.withOpacity(0.3),
//             borderRadius: BorderRadius.circular(8),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           child: DropdownButtonHideUnderline(
//
//
//             child: DropdownButton<String>(
//               value: selectedOption,
//               icon: Icon(Icons.arrow_drop_down),
//               iconSize: 10,
//               elevation: 6,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedOption = newValue;
//                   widget.onOptionSelected(newValue!);
//                 });
//               },
//               hint: Container(
//                 width:MediaQuery.of(context).size.width*0.7,
//                 child: Text(
//                   "Select Product Category",style: TextStyle(color: Colors.black38,fontSize: 16),
//                 ),
//               ),style: TextStyle(color: Colors.black38,decorationColor: Colors.red),
//               items: List<DropdownMenuItem<String>>.generate(widget.options.length, (int index) {
//                 return DropdownMenuItem<String>(
//
//                   value: widget.options[index],
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Row(
//                       children: [
//                         widget.images[index],
//                         SizedBox(width: 8),
//                         Text(widget.options[index]),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }





