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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Forecasts",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        backgroundColor:Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
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
                    "Hey! \n\nYou Don't have any Forecasts yet 🥺. Try adding product sales records and come back  ",style:TextStyle(fontSize: 18,fontWeight:FontWeight.w100),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
