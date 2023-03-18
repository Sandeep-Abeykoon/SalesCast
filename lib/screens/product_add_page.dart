import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../reusable_widgets/reusable_widgets.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({Key? key}) : super(key: key);

  @override
  State<ProductAddPage> createState() => _ProductAddPage();
}

class _ProductAddPage extends State<ProductAddPage> {

  var userId = "";

  final referenceDatabase = FirebaseDatabase.instance.ref();
  final referenceFirestore = FirebaseStorage.instance.ref();

  User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController _productNameTextEditingController = TextEditingController();
  final TextEditingController _productPriceTextEditingController = TextEditingController();
  final TextEditingController _productIdTextEditingController = TextEditingController();

  String imageUrl = "";

  @override
  Widget build(BuildContext context) {

    final user = this.user;
    if(user != null){
      userId = user.uid;
      print("User Id : $userId");
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
              "Add Products Page"
          )
      ),
      backgroundColor: Colors.grey,
      body: Container(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            children: <Widget>[

              addProductTextField(
                  _productNameTextEditingController,
                  "Product Name"),

              const SizedBox(
                height: 20,
              ),

              addProductTextField(
                  _productPriceTextEditingController,
                  "Price"),

              const SizedBox(
                height: 20,
              ),

              addProductTextField(
                  _productIdTextEditingController,
                  "Product Id"),

              const SizedBox(
                height: 20,
              ),

              ElevatedButton(
                  child: const Text("Add Image"),
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    print('${file?.path}');

                    if(file == null) return;

                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages = referenceRoot.child('images');
                    Reference referenceUserFolder = referenceDirImages.child(userId);

                    //Creating a reference to the image to be stored
                    Reference referenceImageToUpload = referenceUserFolder.child(_productIdTextEditingController.text);

                    try{
                      //Storing the file
                      await referenceImageToUpload.putFile(File(file.path));
                      // Getting download url
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                    } catch(e){
                      print(e);
                    }

                  }
              ),

              const SizedBox(
                height: 20,
              ),

              ElevatedButton(
                  child: const Text("Add"),
                  onPressed: () {

                    referenceDatabase.child(userId)
                        .child("products")
                        .child("productName")
                        .push()
                        .set(_productNameTextEditingController.text)
                        .asStream();

                    referenceDatabase.child(userId)
                        .child("products")
                        .child("productPrice")
                        .push()
                        .set(_productPriceTextEditingController.text)
                        .asStream();

                    referenceDatabase.child(userId)
                        .child("products")
                        .child("productId")
                        .push()
                        .set(_productIdTextEditingController.text)
                        .asStream();

                    referenceDatabase.child(userId)
                        .child("products")
                        .child("imageUrl")
                        .push()
                        .set(imageUrl)
                        .asStream();

                    _productIdTextEditingController.clear();
                    _productPriceTextEditingController.clear();
                    _productNameTextEditingController.clear();
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
