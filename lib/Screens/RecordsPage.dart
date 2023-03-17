import 'package:flutter/material.dart';
import 'package:salescast/assets/colors.dart';

class SalesRecords extends StatefulWidget {
  const SalesRecords({Key? key}) : super(key: key);

  @override
  State<SalesRecords> createState() => _SalesRecordsState();
}

class _SalesRecordsState extends State<SalesRecords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor("#b2d8d8"),
      appBar: AppBar(
        title: Text("Sales Records",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [


          ],
        ),
      ),
    );
  }
}
