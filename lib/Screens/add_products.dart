



import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../assets/colors.dart';
import '../reusable_widget/reusable_widgets.dart';

class AddNewProductPage extends StatefulWidget {
  const AddNewProductPage({Key? key}) : super(key: key);

  @override
  State<AddNewProductPage> createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  final _formkey = GlobalKey<FormState>();
  String imageUrl= "";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference prod = FirebaseFirestore.instance.collection('products');
  TextEditingController _prodName = TextEditingController();
  TextEditingController _prodID= TextEditingController();
  TextEditingController _prodPrice = TextEditingController();
  TextEditingController _prodBrand = TextEditingController();
  TextEditingController _prodCategory= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // backgroundColor: hexStringToColor("#b2d8d8"),

        appBar: AppBar(

          title: Text(" Add new Product",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
          backgroundColor: hexStringToColor("#008080"),

          elevation: 0,
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Material(
                elevation: 3,



            ),
            Form(
              key: _formkey,
              child:
              Padding(
              padding: const EdgeInsets.all(10),
              child:
              Column(

                children: [
                  SizedBox(height: 10,),
                 addProdcutsField("Product Name", _prodName),
                 SizedBox(height: 10,),
                 addProdcutsField("Product Id/ Bar Code", _prodID),
                  SizedBox(height: 10,),
                  addProdcutsField("Product Price", _prodPrice),
                  SizedBox(height: 10,),






    CustomDropdownButton(
    hint: 'Select the product category',
    items: [
    DropdownMenuItemWithImage(
    id: 'electronics',
    title: 'Electronics',
    imagePath: 'lib/assets/images/Electronics.png',
    ),
    DropdownMenuItemWithImage(
    id: 'home_garden',
    title: 'Home & Garden',
    imagePath: 'lib/assets/images/HomeGarden.png',
    ),
    // Add more items here
    ],
    onChanged: (selectedItem) {
    // Do something with the selected item
    },),

                SizedBox(height: 10,),
                addProdcutsField("Product Brand",_prodBrand),
                  // SizedBox(height: 10,),
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
                  //   child: CustomDropDown(
                  //     options: ['Electronics',
                  //       'Home & Garden',
                  //       'Sporting Goods & Equipment',
                  //       'Health & Beauty',
                  //       'Clothing, Shoes & Accessories',
                  //       'Jewelry & Watches',
                  //       'Collectibles & Art'],
                  //     images: [
                  //       Image.asset('lib/assets/images/Electronics.png'),
                  //       Image.asset('lib/assets/images/HomeGarden.png'),
                  //       Image.asset('lib/assets/images/Sports.png'),
                  //       Image.asset('lib/assets/images/health.png'),
                  //       Image.asset('lib/assets/images/Clothes.png'),
                  //       Image.asset('lib/assets/images/watches.png'),
                  //       Image.asset('lib/assets/images/Collectibles.png'),
                  //     ],
                  //     onOptionSelected: (String? value) {
                  //       // _prodCategory.text= newValue!;
                  //       // setState(() {
                  //       //   value= newValue!;
                  //       // });
                  //
                  //       // value= _prodCategory as String;
                  //       // Do something with the selected value
                  //     },
                  //   ),
                  // ),
                SizedBox(height: 20,),
                Container(
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
                    onTap: (){
                           //todO

                      },
                    readOnly: true,

                    decoration: InputDecoration(

                      floatingLabelBehavior: FloatingLabelBehavior.never,

                      filled: true,
                      labelText: "Upload the product image",
                      labelStyle: TextStyle(color: Colors.black54),
                      

                      suffixIcon:ElevatedButton(

                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                              if(states.contains(MaterialState.pressed)){
                                return hexStringToColor("#006666");
                              }
                              return hexStringToColor("#006666");
                            }),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
                        ),

                          onPressed: ()async{
                          ImagePicker imagepicker= ImagePicker();
                           XFile? file= await imagepicker.pickImage(source: ImageSource.gallery);
                           print("${file?.path}");
                           if(file == null)return;
                           String UniqueFileName= DateTime.now().microsecondsSinceEpoch.toString();

                           Reference referenceRoot= FirebaseStorage.instance.ref();
                           Reference referenceDirImages= referenceRoot.child("Images");

                           Reference referenceImageToUpload = referenceDirImages.child(UniqueFileName);

                           try {
                            await referenceImageToUpload.putFile(File(file!.path));
                            imageUrl= await referenceImageToUpload.getDownloadURL();
                           } catch (error) {

                             // TODO
                           }

                           },
                        child: Text("Browse"),),
                        fillColor: Colors.grey.withOpacity(0.3),
                        enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(width: 0,style: BorderStyle.none),
                      ),

                    ),

                  ),
                ),

                SizedBox(height: 60,),
                ElevatedButton(
                    onPressed: ()async{
                      final String prodName= _prodName.text;
                      final String prodID= _prodID.text;
                      final String prodPrice= _prodPrice.text;
                      final String prodBrand = _prodBrand.text;
                      final String prodCategory= _prodCategory.text;

                      await FirebaseFirestore.instance
                      .collection('products')
                      .add({
                        'product name': prodName,
                        'product Id': prodID,
                        'product Price': prodPrice,
                        'product Brand': prodBrand,
                        'product Category': prodCategory
                      });
                      Navigator.pop(context);

                      },

                    child:Text("Add Product"),
                  style:ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                        if(states.contains(MaterialState.pressed)){
                          return hexStringToColor("#b2d8d8");
                        }
                        return hexStringToColor("#004c4c");
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                  ), ),






                //  TextFormField(
                 //    decoration: InputDecoration(
                 //      labelText: "Product Name",
                 //      labelStyle: TextStyle(color: Colors.grey),
                 //      enabledBorder: UnderlineInputBorder(
                 //        borderSide: BorderSide(
                 //          color: Colors.grey.withOpacity(0.2),
                 //        ),
                 //      ),
                 //
                 //    ),
                 //
                 // ),
                ],
              ),
                ),
            )],
          ),
        ),
      ),
    );

  }

}
