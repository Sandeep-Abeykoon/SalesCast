import 'package:flutter/material.dart';





class ViewProduct extends StatefulWidget {
  ViewProduct({Key? key}) : super(key: key);

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.3),
        title: Text("Product Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
        actions: [
          PopupMenuButton(




              itemBuilder:(context)=>[
                PopupMenuItem(child:Text("Delete"),
                onTap: (){
                  //code to delete item 


                },),
              ]),
        ],
      ),
       body:  SingleChildScrollView(
             child: Container(
                 child: Column(
                   children: [
                  Container(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                         child: Image.asset("lib/assets/images/Electronics.png",height: 200,width: 300,),
                ),

                ),
                     // Divider(thickness: 5,),
                     SizedBox(height: 40,),
                     Container(
                       height: MediaQuery.of(context).size.height,
                       width: double.infinity,
                       padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.only(
                           topLeft: Radius.circular(35),
                           topRight: Radius.circular(35),
                         ),
                         boxShadow: [BoxShadow(
                           color: Colors.grey.withOpacity(0.4),
                           blurRadius: 10,
                           spreadRadius: 1,
                         ),]
                       ),
                       child: Column(
                         children: [
                           Row(
                             children: [
                               
                               Text("Samsung TV",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.grey),)

                           ],
                           ),
                           SizedBox(height: 10,),
                           Divider(thickness: 1,),
                           SizedBox(height: 30,),

                           Row(
                             children: [
                               Text("Product ID: 20",style: TextStyle(fontSize: 20, color: Colors.black38),)

                             ],
                           ),
                           SizedBox(height: 10,),
                           Row(
                             children: [
                               Text("Quantity : 20",style: TextStyle(fontSize: 20, color: Colors.black38),)

                             ],
                           ),
                           SizedBox(height: 10,),
                           Row(
                             children: [
                               Text("Price : 800",style: TextStyle(fontSize: 20, color: Colors.black38),)

                             ],
                           ),
                           SizedBox(height: 10,),
                           Row(
                             children: [
                               Text("Product Category : Electronics",style: TextStyle(fontSize: 20, color: Colors.black38),)

                             ],
                           ),
                           SizedBox(height: 10,),
                           Row(
                             children: [
                               Text("Product Brand : Samsung",style: TextStyle(fontSize: 20, color: Colors.black38),)

                             ],
                           ),








                         ],
                       ),





                     ),

             ],

         ),
        ),
    ) ,



    );
  }
}
