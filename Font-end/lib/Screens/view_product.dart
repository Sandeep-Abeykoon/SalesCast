import 'package:flutter/material.dart';
import 'package:salescast/reusable_widget/app_large_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewProduct extends StatefulWidget {
  final Map<String, String> productDetails;

  const ViewProduct({Key? key, required this.productDetails}) : super(key: key);

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

List<int> trends = [1, 2, 3];

class _ViewProductState extends State<ViewProduct> {

  Map<String, dynamic> forecasts = {};
  List<dynamic> trendingProducts = [];

  final String apiUrl = "http://10.0.2.2:5000/";
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    loadTrendingProducts();
    loadForecasts();
  }

  Future<void> loadForecasts() async {
    final response = await http
        .post(Uri.parse("$apiUrl/getWeeklyForecasts"), body: {
          'user_id': user?.uid,
          'product_id': widget.productDetails['product_id']});
    if (response.statusCode == 200) {
      setState(() {
        forecasts = jsonDecode(response.body);
      });
      print("User Id Sent successfully");
    } else {
      print("Server error");
    }
  }

  Future<void> loadTrendingProducts() async {
    final response = await http
        .post(Uri.parse("$apiUrl/getTrendingProducts"), body: {
      'user_id': user?.uid,
      'product_id': widget.productDetails['product_id']});
    if (response.statusCode == 200) {
      setState(() {
        trendingProducts = jsonDecode(response.body);
        print(trendingProducts);
      });
      print("User Id Sent successfully");
    } else {
      print("Server error");
    }
  }

  final Uri _url = Uri.parse('');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [];

    forecasts.forEach((key, value) {
      data.add(_SalesData(key, value));
    });


    final List<ChartData> chartData = <ChartData>[
      ChartData('Day 1', 128, 129),
      ChartData('Day 2', 123, 92),
      ChartData('Day 3', 107, 106),
      ChartData('Day 4', 87, 95),
      ChartData('Day 5', 87, 95),
      ChartData('Day 7', 87, 95),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.3),
        title: Text(
          widget.productDetails['product_name']!,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text("Delete"),
                      onTap: () {
                        //code to delete item
                      },
                    ),
                  ]),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Image.network(
                widget.productDetails['product_image']!,
                height: 200,
                width: 300,
              ),
            ),
            // Divider(thickness: 5,),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 1500,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.productDetails['product_name']!,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        "Product ID: ${widget.productDetails['product_id']!}",
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Price : ${widget.productDetails['product_price']!}",
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Product Category : Electronics",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Product Brand : ${widget.productDetails['product_brand']!}",
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AppLargeText(text: "Trending Products Recommendations"),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      const Text(
                        "Here are the most trending items related to this product on ebay.",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      for (var i in trends)
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                              onTap: () {

                                _launchUrl();

                              },
                              child: Text(
                                "$i. JVC LT-40CA790 Android TV 40' Smart Full HD LED TV with Google Assistant",
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.blue),
                              )),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AppLargeText(text: "Forecast"),
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(
                              text: 'Weekly sales analysis of the product'),
                          // Enable legend
                          legend: Legend(isVisible: true),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData, String>>[
                            LineSeries<_SalesData, String>(
                                dataSource: data,
                                xValueMapper: (_SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (_SalesData sales, _) =>
                                    sales.sales,
                                name: 'Sales',
                                // Enable data label
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true))
                          ]),
                    ),
                    SizedBox(
                        width: 500,
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: SfCartesianChart(
                              title: ChartTitle(
                                  text: 'Weekly sales Comparison analysis'),
                              legend: Legend(
                                isVisible: true,
                                isResponsive: true,
                              ),
                              primaryXAxis: CategoryAxis(),
                              tooltipBehavior: TooltipBehavior(
                                enable: true,
                              ),
                              series: <CartesianSeries>[
                                LineSeries<ChartData, String>(
                                    name: "Your Forecast",
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) =>
                                        data.y),
                                LineSeries<ChartData, String>(
                                    name: "Trending Item",
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) =>
                                        data.y1),
                              ]),
                        )),
                  ]),
                ],
              ),
            ),
          ],
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
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
