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
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.black38,))
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
                     Divider(thickness: 5,),

             ],

         ),
        ),
    ) ,



    );
  }
}
