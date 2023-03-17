import 'package:flutter/material.dart';
import 'package:salescast/assets/colors.dart';

class ForecastsPage extends StatefulWidget {
  const ForecastsPage({Key? key}) : super(key: key);

  @override
  State<ForecastsPage> createState() => _ForecastsPageState();
}

class _ForecastsPageState extends State<ForecastsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor("#b2d8d8"),
      appBar: AppBar(
        title: Text("Forecasts",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        backgroundColor:Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
