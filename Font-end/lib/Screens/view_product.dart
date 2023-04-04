import 'package:flutter/material.dart';
import 'package:salescast/reusable_widget/app_large_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ViewProduct extends StatefulWidget {
  ViewProduct({Key? key}) : super(key: key);

  @override
  State<ViewProduct> createState() => _ViewProductState();
}
var productname="";
var productPrice="";
var productId=" ";
var productCategory="";
var productBrand ="";
var productImageUrl="";
List<int> trends = [1,2,3];

class _ViewProductState extends State<ViewProduct> {

  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [
      _SalesData('Week 1', 10,),
      _SalesData('Week 2', 18),
      _SalesData('Week 3', 24),
      _SalesData('Week 4', 12),

    ];
    final List<ChartData> chartData = <ChartData>[
      ChartData('Week 1', 128, 129),
      ChartData('Week 2', 123, 92),
      ChartData('Week 3', 107, 106),
      ChartData('Week 4', 87, 95),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.3),
        title: Text(
          "Product Name",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("Delete"),
                  onTap: () {
                    //code to delete item
                  },
                ),
              ]),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Image.asset(
                    "lib/assets/images/Electronics.png",
                    height: 200,
                    width: 300,
                  ),
                ),
              ),
              // Divider(thickness: 5,),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 1500,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
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
                          "Samsung TV",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "Product ID: 20",
                          style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        Text(
                          "Price : 800",
                          style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Product Category : Electronics",
                          style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Product Brand : Samsung",
                          style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    SizedBox(height: 50,),
                    AppLargeText(text: "Trending Products Recommendations"),
                    SizedBox(height: 30,),
                    Container(
                      child: Column(
                        children: [
                          Text("Here are the most trending items related to this product on ebay.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                          SizedBox(height: 30,),
                          for (var i in trends)Padding(
                            padding: EdgeInsets.all(10),
                            child: GestureDetector(
                                onTap: (){


                                },
                                child: Text("$i. JVC LT-40CA790 Android TV 40' Smart Full HD LED TV with Google Assistant",style: TextStyle(fontSize: 15,color: Colors.blue),)),
                          ),

                        ],
                      ),
                    )
                    , SizedBox(height: 50,),
                    AppLargeText(text: "Forecast"),
                    Column(
                        children:[
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                // Chart title
                                title: ChartTitle(text: 'Monthly sales analysis of the product'),
                                // Enable legend
                                legend: Legend(isVisible: true),
                                // Enable tooltip
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <ChartSeries<_SalesData, String>>[
                                  LineSeries<_SalesData, String>(
                                      dataSource: data,
                                      xValueMapper: (_SalesData sales, _) => sales.year,
                                      yValueMapper: (_SalesData sales, _) => sales.sales,

                                      name: 'Sales',
                                      // Enable data label
                                      dataLabelSettings: DataLabelSettings(isVisible: true))
                                ]),
                          ),
                          Container(
                              width: 500,
                              height: 300,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0,30, 0, 0),
                                child: SfCartesianChart(
                                    title: ChartTitle(text: 'Monthly sales Comparison analysis'),
                                    legend: Legend(isVisible: true, isResponsive: true, ),
                                    primaryXAxis: CategoryAxis(),
                                    tooltipBehavior: TooltipBehavior(enable: true,),
                                    series: <CartesianSeries>[

                                      LineSeries<ChartData, String>(
                                          name: "Your Forecast",
                                          dataSource: chartData,
                                          xValueMapper: (ChartData data, _) => data.x,
                                          yValueMapper: (ChartData data, _) => data.y
                                      ),
                                      LineSeries<ChartData, String>(
                                          name: "Trending Item",
                                          dataSource: chartData,
                                          xValueMapper: (ChartData data, _) => data.x,
                                          yValueMapper: (ChartData data, _) => data.y1
                                      ),

                                    ]
                                ),
                              )
                          ),
                        ] ), ],
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
  _SalesData(this.year, this.sales);


  final String year;
  final double sales;
}
