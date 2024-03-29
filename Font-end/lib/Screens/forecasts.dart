import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForecastsPage extends StatefulWidget {
  const ForecastsPage({Key? key}) : super(key: key);

  @override
  State<ForecastsPage> createState() => _ForecastsPageState();
}

List<int> text = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
];

class _ForecastsPageState extends State<ForecastsPage> {

  List<Map<String, dynamic>> forecasts = [];
  List<_SalesData> data = [];

  final String apiUrl = "http://10.0.2.2:5000/";
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    loadForecasts();
  }


  Future<void> loadForecasts() async {
    final response = await http
        .post(Uri.parse("$apiUrl/getForecasts"), body: {'user_id': user?.uid});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      setState(() {
        forecasts = jsonResponse.cast<Map<String, dynamic>>();
      });
      print("User Id Sent successfully");
    } else {
      print("Server error");
    }
  }

  @override
  Widget build(BuildContext context) {

    for (var item in forecasts) {
      String productName = item['product_name'];
      double itemSales = item['total'];
      data.add(_SalesData(productName, itemSales));

    }

    List<_SalesData> data2 = [
      _SalesData(
        'Trending P1',
        10,
      ),
      _SalesData('Trending P2', 18),
      _SalesData('Trending P3', 0),
      _SalesData('Trending P4', 12),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent.withOpacity(0.8),
            title: const Text(
              'Forecasts',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              tabs: [
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        30, 0, MediaQuery.of(context).size.width * 0.2, 0),
                    child: const Tab(
                      icon: Icon(Icons.table_chart),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.2, 0, 30, 0),
                    child: const Tab(icon: Icon(Icons.insert_chart))),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Hey! \n\nYou Don't have any Forecasts yet 🥺. Try adding product sales records and come back  ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          dataRowHeight: 80,
                          showBottomBorder: true,
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
                          dividerThickness: 2,
                          columnSpacing: 10,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Your Product',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Sales',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Trending product',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Sales',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: <DataRow>[
                            for (var i in text)
                              const DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('Product A')),
                                  DataCell(Text('20')),
                                  DataCell(Text('Trending Product A')),
                                  DataCell(Text('30')),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Hey! \n\nYou Don't have any Forecasts yet 🥺. Try adding product sales records and come back  ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(
                              text:
                                  'Next week sales forecast of your products'),
                          // Enable legend
                          legend: Legend(isVisible: true),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData, String>>[
                            BarSeries<_SalesData, String>(
                                dataSource: data,
                                xValueMapper: (_SalesData sales, _) =>
                                sales.product,
                                yValueMapper: (_SalesData sales, _) =>
                                    sales.sales,
                                name: 'Sales',
                                // Enable data label
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true))
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 0, 20),
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(
                              text:
                                  'Next week sales forecast of most trending product'),
                          // Enable legend
                          legend: Legend(isVisible: true),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData, String>>[
                            BarSeries<_SalesData, String>(
                                color: Colors.redAccent,
                                dataSource: data2,
                                xValueMapper: (_SalesData sales, _) =>
                                sales.product,
                                yValueMapper: (_SalesData sales, _) =>
                                    sales.sales,
                                name: 'Sales',
                                // Enable data label
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true))
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final String x;
  final double? y;
  final double? y1;
}

class _SalesData {
  _SalesData(this.product, this.sales);

  final String product;
  final double sales;
}
