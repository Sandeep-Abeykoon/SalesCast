import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

class MyRecordsPage extends StatefulWidget {
  const MyRecordsPage({Key? key}) : super(key: key);

  @override
  _MyRecordsPageState createState() => _MyRecordsPageState();
}

class _MyRecordsPageState extends State<MyRecordsPage>{

  var userId = "";
  User? user = FirebaseAuth.instance.currentUser;


  Future<void> pickCsvFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      final contents = await file.readAsString();

      sendCsvContents(contents);


    }
  }


  void sendCsvContents(contents) async {
    const url = "http://10.0.2.2:5000/upload_csv_contents";
    final response = await http.post(
      Uri.parse(url),
      body: {'csv_contents': contents}
    );
    if (response.statusCode == 200) {
      print("CSV data uploaded successfully");
    }else{
      print("error uploading CSV data");
    }
  }

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
          onPressed: pickCsvFile,
          child: const Text("Choose CSV file")
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