import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class MyRecordsPage extends StatefulWidget {
  const MyRecordsPage({Key? key}) : super(key: key);

  @override
  _MyRecordsPageState createState() => _MyRecordsPageState();
}

class _MyRecordsPageState extends State<MyRecordsPage>{

  var userId = "";
  User? user = FirebaseAuth.instance.currentUser;
  late File file;

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
            "My Records"),
      ),
      backgroundColor: Colors.grey,
      body: Container(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            children: <Widget>[

          ElevatedButton(
          child: const Text("Choose CSV file"),
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['csv'],
            );
            if (result != null) {
              file = File(result.files.single.path!);
            }

            // Uploading to the Cloud Storage
            String filePath = 'csv/$userId' ;
            Reference ref = FirebaseStorage.instance.ref().child(filePath);
            UploadTask uploadTask = ref.putFile(file);
            TaskSnapshot taskSnapShot = await uploadTask.whenComplete(() => null);
            String downloadUrl = await taskSnapShot.ref.getDownloadURL();

            final referenceDatabase = FirebaseDatabase.instance.ref();
            referenceDatabase.child(userId)
            .child("userRecords").
            push()
            .set(downloadUrl);

          }
          ),
              const SizedBox(
                height: 50,
              ),
              const Text("Your Records",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              )
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}