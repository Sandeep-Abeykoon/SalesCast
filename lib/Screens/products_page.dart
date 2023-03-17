import 'package:flutter/material.dart';
import 'package:salescast/assets/colors.dart';

import '../reusable_widget/CategoriesWidget.dart';
import '../reusable_widget/HomeAppBar.dart';
import '../reusable_widget/ItemsWidget.dart';
import 'add_products.dart';

class ProdcutsPage extends StatefulWidget {
  const ProdcutsPage({Key? key}) : super(key: key);

  @override
  State<ProdcutsPage> createState() => _ProdcutsPageState();
}

class _ProdcutsPageState extends State<ProdcutsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor("#b2d8d8"),
      extendBodyBehindAppBar: true,
      appBar: AppBar(

        title: Text("Products Page",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,


      ),
      body: ListView(children: [
        HomeAppBar(),
        Container(
          padding: EdgeInsets.only(top:15),
          decoration: BoxDecoration(
              color: Color(0xFFEDCF2),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35)
              )
          ),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),

                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left:5),
                        height: 50,
                        width:300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border:InputBorder.none,
                            hintText: "Search here...",
                          ),

                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.camera_alt,
                        size: 27,
                        color: Color(0xFF4C53A5),
                      ),
                    ],
                  )
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: Text(
                  "My Products",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5)),
                ),
              ),
              CategoriesWidget(),

              ItemsWidget(),
            ],
          ),
        )
      ],),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Container(
      //
      //       ),
      //
      //     ],
      //
      //
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(

        backgroundColor: hexStringToColor("#5d9b8c"),

        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_){
              return AddNewProductPage();
            },
          ));
        },
        child: Icon(Icons.add),
      ),

    );
  }
}
