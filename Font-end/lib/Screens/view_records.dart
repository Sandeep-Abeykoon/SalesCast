import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewRecords extends StatefulWidget {
  const ViewRecords({Key? key}) : super(key: key);

  @override
  State<ViewRecords> createState() => _ViewRecordsState();
}

class _ViewRecordsState extends State<ViewRecords> {

  final String apiUrl = "http://10.0.2.2:5000/";
  var userId = "";
  User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> recordsArray = [];

  @override
  void initState() {
    super.initState();
    fetchRecords().then((data) {
      setState(() {
        recordsArray = data;
        print(recordsArray);
      });
    });
  }

  //This method return the recent two records entered to the application
  Future<List<Map<String, dynamic>>> fetchRecords() async {
    final response = await http.post(
      Uri.parse("$apiUrl/getSalesRecords"),
      body: {'user_id': user?.uid},
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonData);
    } else {
      throw Exception('Failed to fetch data from server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: Text(
          "View Records",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        backgroundColor: Colors.grey.withOpacity(0.3),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              dividerThickness: 1,
              columnSpacing: 10,
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
              ),
              DataColumn(
                label: Text(
                  'Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('3')),
                    DataCell(Text('Product C')),
                    DataCell(Text('\$20')),
                    DataCell(Text('100')),
                    DataCell(Text('\$1000')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('4')),
                    DataCell(Text('Product D')),
                    DataCell(Text('\$10')),
                    DataCell(Text('100')),
                    DataCell(Text('\$1000')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('5')),
                    DataCell(Text('Product E')),
                    DataCell(Text('\$30')),
                    DataCell(Text('100')),
                    DataCell(Text('\$800')),
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
        ),
      ),
    );
  }
}
