import 'package:flutter/material.dart';
import 'package:salescast/Screens/view_product.dart';
import 'package:salescast/assets/colors.dart';


import 'add_products.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<int> text = [];//TODO Need to load product data




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(

        title: const Text("My Products",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,


      ),
      body: ListView(children: [

        Container(
          padding: const EdgeInsets.only(top:15),
          decoration: const BoxDecoration(
              color: Color(0x0ffedcf2),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35)
              )
          ),
          child: SingleChildScrollView(
            scrollDirection:Axis.vertical,
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30),

                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left:5),
                          height: 50,
                          width:200,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border:InputBorder.none,
                              hintText: "Search here...",
                            ),

                          ),
                        ),
                        const Spacer(),

                      ],
                    )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),

                ),

                //this following container appears only when no products are available in the product list
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 5),
                      ),],
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Hey! \n\nYou Don't have any products added yet. Click ➕ in the corner to add a new product 😃  ",style:TextStyle(fontSize: 18,fontWeight:FontWeight.w300),
                    ),
                  ),
                ),
                for (var i in text)Container(
                  height: 110,
                  margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: [
                  BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 5),
                ),],
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        margin: const EdgeInsets.only(right: 20),
                        child: Image.asset("lib/assets/images/Clothes.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Product Title",
                              style:TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                  color:Colors.black.withOpacity(0.4)
                              ) ,),
                            Text("Product Id: 12",
                              style:TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color:Colors.black.withOpacity(0.4)
                              ) ,),
                            Text("Quantity : 20 ",
                              style:TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color:Colors.black.withOpacity(0.4)),
                            ),
                            Text("Price: Rs.800 ",
                              style:TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color:Colors.black.withOpacity(0.4)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:20),
                        child: Column(

                          children: [
                            Padding(padding:const EdgeInsets.fromLTRB(67, 0, 0, 0),
                            child: IconButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProduct()));


                            }, icon: const Icon(Icons.navigate_next))),


                          ],
                        ),
                      ),
                    ],

                  ),





                ),

              ],
            ),
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

        backgroundColor: hexStringToColor("#8776ff"),

        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_){
              return const AddNewProductPage();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),

    );
  }
}
