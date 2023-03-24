import 'package:flutter/material.dart';
import 'package:untitled4/view_product.dart';





class ProdcutsPage extends StatefulWidget {
  const ProdcutsPage({Key? key}) : super(key: key);

  @override
  State<ProdcutsPage> createState() => _ProdcutsPageState();
}

class _ProdcutsPageState extends State<ProdcutsPage> {
  List<int> text = [1,2,3,4,5,6];




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(

        title: Text("My Products",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,


      ),
      body: ListView(children: [

        Container(
          padding: EdgeInsets.only(top:15),
          decoration: BoxDecoration(
              color: Color(0xFFEDCF2),
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
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30),

                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left:5),
                          height: 50,
                          width:200,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border:InputBorder.none,
                              hintText: "Search here...",
                            ),

                          ),
                        ),
                        Spacer(),

                      ],
                    )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),

                ),

                //this following container appears only when no products are available in the product list
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
                      "Hey! \n\nYou Don't have any products added yet. Click ➕ in the corner to add a new product 😃  ",style:TextStyle(fontSize: 18,fontWeight:FontWeight.w100),
                    ),
                  ),
                ),
                for (var i in text)Container(
                  height: 110,
                  margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 5),
                      ),],
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        margin: EdgeInsets.only(right: 20),
                        child: Image.asset("lib/assets/images/Clothes.png"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
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
                        padding: EdgeInsets.symmetric(vertical:20),
                        child: Column(

                          children: [
                            Padding(padding:EdgeInsets.fromLTRB(67, 0, 0, 0),
                                child: IconButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProduct()));


                                }, icon: Icon(Icons.navigate_next))),


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



        onPressed: () {  },
        child: Icon(Icons.add),
      ),

    );
  }
}