import 'package:flutter/material.dart';



class ViewRecords extends StatefulWidget {
  const ViewRecords({Key? key}) : super(key: key);

  @override
  State<ViewRecords> createState() => _ViewRecordsState();
}

class _ViewRecordsState extends State<ViewRecords> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: Text("View Records",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
        backgroundColor: Colors.grey.withOpacity(0.3),
      ),
      body: SingleChildScrollView(
        child:Container(

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
    );
  }
}