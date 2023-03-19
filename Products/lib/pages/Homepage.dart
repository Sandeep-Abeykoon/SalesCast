
import 'package:flutter/material.dart';
import 'package:products/widgets/CategoriesWidget.dart';
import 'package:products/widgets/HomeAppBar.dart';
import 'package:products/widgets/ItemsWidget.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

    );
  }
}