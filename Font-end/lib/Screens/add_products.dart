import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../assets/colors.dart';
import '../reusable_widget/reusable_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddNewProductPage extends StatefulWidget {
  const AddNewProductPage({Key? key}) : super(key: key);

  @override
  State<AddNewProductPage> createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  final String apiUrl = "http://10.0.2.2:5000/";

  // Getting the Current user ID
  var userId = "";
  User? user = FirebaseAuth.instance.currentUser;

  final _formkey = GlobalKey<FormState>();

  String imageUrl = "";
  final referenceDatabase = FirebaseDatabase.instance.ref();
  final referenceFirestore = FirebaseStorage.instance.ref();
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // final CollectionReference prod = FirebaseFirestore.instance.collection('products');
  final TextEditingController _prodName = TextEditingController();
  final TextEditingController _prodID = TextEditingController();
  final TextEditingController _prodPrice = TextEditingController();
  final TextEditingController _prodBrand = TextEditingController();
  TextEditingController _prodCategory = TextEditingController();
  late String prodCategory;

  // This method is to check the product id with the available products
  Future<bool?> _productAvailability() async {
    try {
      final response = await http.post(
          Uri.parse('$apiUrl/product_availability'),

          body: {'user_id': user?.uid, 'product_id': _prodID.text.trim()});

      if (response.statusCode == 200) {
        print("Request sent");
        final responseBody = json.decode(response.body);
        return responseBody['is_available'];
      } else {
        throw Exception("Failed to send the request");
      }
    } catch (e) {
      print(e);
    }
  }

  // This method sends the new product details to the back-end
  Future<void> registerProduct() async {

    final response =
        await http.post(Uri.parse('$apiUrl/register_product'),
            body: {
              'user_Id': user?.uid,
              'product_name': _prodName.text.trim(),
              'product_id': _prodID.text.trim(),
              'product_price': _prodPrice.text.trim(),
              'product_brand': _prodBrand.text.trim(),
              'product_category': ' ',
            });


    if (response.statusCode == 200) {
      print("data sent successfully");
    } else {
      throw Exception("Failed to send the data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // backgroundColor: hexStringToColor("#b2d8d8"),

        appBar: AppBar(
          title: const Text(
            " Add new Product",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: hexStringToColor("#8776ff"),
          elevation: 0,
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              const Material(
                elevation: 3,
              ),
              Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      addProductsField("Product Name", _prodName, false),
                      const SizedBox(
                        height: 10,
                      ),
                      addProductsField("Product Id/ Bar Code", _prodID, false),
                      const SizedBox(
                        height: 10,
                      ),
                      addProductsField("Product Price", _prodPrice, true),
                      const SizedBox(
                        height: 10,
                      ),

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
                          DropdownMenuItemWithImage(
                            id: 'jewelleries',
                            title: 'Jewelry & Watches',
                            imagePath: 'lib/assets/images/watches.png',
                          ),
                          DropdownMenuItemWithImage(
                            id: 'health',
                            title: 'Health & Beauty',
                            imagePath: 'lib/assets/images/health.png',
                          ),
                          DropdownMenuItemWithImage(
                            id: 'sports',
                            title: 'Sporting Goods & Equipment',
                            imagePath: 'lib/assets/images/Sports.png',
                          ),
                          DropdownMenuItemWithImage(
                            id: 'clothing',
                            title: 'Clothing, Shoes & Accessories',
                            imagePath: 'lib/assets/images/Clothes.png',
                          ),
                          DropdownMenuItemWithImage(
                            id: 'collectibles',
                            title: 'Collectibles & Art',
                            imagePath: 'lib/assets/images/Collectibles.png',
                          ),

                          // Add more items here
                        ],
                        onChanged: (selectedItem) {
                          setState(() {
                            _prodCategory =
                                selectedItem as TextEditingController;
                          });

                          // Do something with the selected item
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      addProductsField("Product Brand", _prodBrand, false),

                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          onTap: () {
                            //todO
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            labelText: "Upload the product image",
                            labelStyle: const TextStyle(color: Colors.black54),
                            suffixIcon: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Colors.deepPurpleAccent;
                                    }
                                    return hexStringToColor("#8776ff");
                                  }),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)))),
                              onPressed: () async {
                                ImagePicker imagepicker = ImagePicker();
                                XFile? file = await imagepicker.pickImage(
                                    source: ImageSource.gallery);
                                print("${file?.path}");
                                if (file == null) return;
                                // String UniqueFileName= DateTime.now().microsecondsSinceEpoch.toString();

                                Reference referenceRoot =
                                    FirebaseStorage.instance.ref();
                                Reference referenceDirImages =
                                    referenceRoot.child("Images");
                                Reference referenceUserFolder =
                                    referenceDirImages.child(userId);
                                Reference referenceImageToUpload =
                                    referenceUserFolder.child(_prodID.text);

                                try {
                                  await referenceImageToUpload
                                      .putFile(File(file.path));
                                  imageUrl = await referenceImageToUpload
                                      .getDownloadURL();
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: const Text("Browse"),
                            ),
                            fillColor: Colors.grey.withOpacity(0.3),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final result = await _productAvailability();

                          if (result == false) {
                            registerProduct();
                          } else {
                            print(
                                "The product is already registered to the system by the current user");
                          }

                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return hexStringToColor("#aeaeff");
                              }
                              return hexStringToColor("#8776ff");
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                        child: const Text("Add Product"),
                      ),

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
              )
            ],
          ),
        ),
      ),
    );
  }
}
