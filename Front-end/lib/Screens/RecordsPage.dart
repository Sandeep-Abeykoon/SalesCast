import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salescast/Screens/view_records.dart';

import '../assets/colors.dart';

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
        elevation: 0,
        title: const Text(
            "My Records",style: TextStyle(color: Colors.black),),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 5),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 5),
                      ),],
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),



                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: const Text(
                      "Hey! \n\nYou can upload your sales records here. Upload a csv file of your sales records to get started 😃",style:TextStyle(fontSize: 18,fontWeight:FontWeight.w300),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                ElevatedButton(
                    child: const Text("Choose CSV file"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          if(states.contains(MaterialState.pressed)){
                            return hexStringToColor("#e47b88");
                          }
                          return hexStringToColor("#8776ff");
                        }),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
                    ),
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
                  height: 30,
                ),
                Row(

                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20,right: 60),
                      child: const Text("Previous Records",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:20,
                        )
                  ),
                    ),

                    IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewRecords()));


                        },
                        icon:Icon(Icons.navigate_next,)
                    ),



                  ],),
                const SizedBox(
                  height: 10,
                ),

            Container(

              width: MediaQuery.of(context).size.width,
              child: DataTable(
             dividerThickness: 1,


                columnSpacing: 1,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Product Id',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  DataColumn(
                    label: Text(
                      'Product Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Price',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Items Sold',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Profit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[

                      DataCell(Text('1')),
                      DataCell(Text('Product A')),
                      DataCell(Text('\$10')),
                      DataCell(Text('100')),
                      DataCell(Text('\$500')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[

                      DataCell(Text('2')),
                      DataCell(Text('Product B')),
                      DataCell(Text('\$20')),
                      DataCell(Text('100')),
                      DataCell(Text('\$1000')),
                    ],
                  ),

                ],
              ),
            ),
                IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewRecords()));


                    },
                    icon:Icon(Icons.arrow_circle_down_sharp,)
                ),





              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'dart:html';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:salescast/assets/colors.dart';
//
// class SalesRecords extends StatefulWidget {
//   const SalesRecords({Key? key}) : super(key: key);
//
//   @override
//   State<SalesRecords> createState() => _SalesRecordsState();
// }
//
// class _SalesRecordsState extends State<SalesRecords> {
//   var userId = "";
//   User? user = FirebaseAuth.instance.currentUser;
//   late File file;
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: hexStringToColor("#b2d8d8"),
//       appBar: AppBar(
//         title: Text("Sales Records",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Placeholder(
//               child: Text(
//                 "Your Sales Records will be appear here"
//
//               ),
//               fallbackHeight: 20,
//               fallbackWidth: 10,
//               strokeWidth: 0,
//             ),
//             SizedBox(
//               height: 350,
//             ),
//
//             Center(
//               child: Container(
//                 child: ElevatedButton(
//                   onPressed:()async{
//                     FilePickerResult? result = await FilePicker.platform.pickFiles(
//                         type: FileType.custom,
//                         allowedExtensions: ['csv'],);
//                     if (result != null) {
//                       file = File(result.files.single.path!);
//
//
//
//
//
//
//                   } ,
//                   child: Text(
//                     "Choose Csv file"
//                   ),
//
//
//                 ),
//
//               ),
//             ),
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
