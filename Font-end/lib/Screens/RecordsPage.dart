import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:salescast/Screens/view_records.dart';

import '../assets/colors.dart';

class MyRecordsPage extends StatefulWidget {
  const MyRecordsPage({Key? key}) : super(key: key);

  @override
  _MyRecordsPageState createState() => _MyRecordsPageState();
}

class _MyRecordsPageState extends State<MyRecordsPage>{


  final String apiUrl = "http://10.0.2.2:5000/";
  var userId = "";
  User? user = FirebaseAuth.instance.currentUser;
  late File file;
  List<Map<String, dynamic>> recordsArray = [];

  @override
  void initState() {
    super.initState();
    fetchLastTwoRecords().then((data) {
      setState(() {
        recordsArray = data;
        print(recordsArray);
      });
    });
  }


  Future<List<Map<String, dynamic>>> fetchLastTwoRecords() async {
    final response = await http.post(
      Uri.parse("$apiUrl/getLastTwoRecords"),
      body: {'user_id': user?.uid},
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonData);
    } else {
      throw Exception('Failed to fetch data from server');
    }
  }

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
        body: {'user_id': user?.uid,'csv_contents': contents}
    );
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("CSV data uploaded successfully");
      }
    }else{
      if (kDebugMode) {
        print("error uploading CSV data");
      }
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
                  margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 5),
                      ),],
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),



                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Hey! \n\nYou can upload your sales records here. Upload a csv file of your sales records to get started 😃",style:TextStyle(fontSize: 18,fontWeight:FontWeight.w300),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                ElevatedButton(
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
                    onPressed:
                    pickCsvFile,
                    child: const Text("Choose CSV file")
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(

                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20,right: 60),
                      child: Text("Previous Records",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:20,
                          )
                      ),
                    ),

                    IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ViewRecords()));


                        },
                        icon:const Icon(Icons.navigate_next,)
                    ),



                  ],),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataRowHeight: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        dividerThickness: 1,
                        columnSpacing: 10,
                        columns: const <DataColumn>[
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
                              'Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        rows: List<DataRow>.generate(
                          recordsArray.length,
                              (index) {
                            return DataRow(
                              cells: <DataCell>[
                                DataCell(Text(recordsArray[index]['id_number'].toString())),
                                DataCell(Text(recordsArray[index]['product'].toString())),
                                DataCell(Text(recordsArray[index]['price'].toString())),
                                DataCell(Text(recordsArray[index]['sold_quantity'].toString())),
                                DataCell(Text(recordsArray[index]['date'].toString())),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),



                ),

                IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ViewRecords()));


                    },
                    icon:const Icon(Icons.arrow_circle_down_sharp,)
                ),





              ],
            ),
          ),
        ),
      ),
    );
  }
}


