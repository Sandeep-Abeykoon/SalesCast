import 'package:flutter/material.dart';
import 'package:salescast/Screens/welcome.dart';
import 'package:salescast/assets/colors.dart';
import 'package:salescast/auth_service.dart';
import 'package:salescast/reusable_widget/app_large_text.dart';
import 'package:salescast/reusable_widget/app_small_text.dart';
import 'package:salescast/reusable_widget/responsive_button.dart';
 class WelcomePageSlide extends StatefulWidget {
   const WelcomePageSlide({Key? key}) : super(key: key);
 
   @override
   State<WelcomePageSlide> createState() => _WelcomePageSlideState();
 }
 
 class _WelcomePageSlideState extends State<WelcomePageSlide> {
   List images= ["lib/assets/images/Image_2.png","lib/assets/images/Image_3.png","lib/assets/images/Image_5.png"

   ];
   @override
   Widget build(BuildContext context) {
     return Scaffold(

       body:


         PageView.builder(
           scrollDirection: Axis.vertical,
            itemCount: images.length,
             itemBuilder:(_,index){
            return Container(

           // margin: EdgeInsets.only(top: 300),
              width:MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(scale:1,
                    image: AssetImage(

                    images[index]
                    ),
                  fit: BoxFit.cover
                ),
                ),

              child: Container(
                margin: const EdgeInsets.only(left: 20,top: 100,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // SizedBox(height: 100),

                    AppLargeText(text:"Welcome"),
                    SizedBox(height:10 ,),
                    Container(
                      width: 250,

                        child: AppSmallText(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s  ", color: Colors.black.withOpacity(0.5))),
                    SizedBox(height: 100,),
                    Container(
                      width: 100,
                      height: 50,
                      margin: EdgeInsets.only(left: 10),
                      child: ElevatedButton(onPressed: (){


                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WelcomePage()));
                      }, child: Text("Next",style: TextStyle(color: Colors.black,fontSize: 15),),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                              if(states.contains(MaterialState.pressed)){
                                return Colors.white70;
                              }
                              return hexStringToColor("#a6a6df");
                            }),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),),
                    )

                    ],
                    ),
                  Column(
                    children: List.generate(3, (indexDots) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 2),
                        width: 8,
                        height: index== indexDots?40:12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: hexStringToColor("#a6a6df"),
                        ),

                      );
                    }),
                  )],
                ),

              ),

            );
           } ),

     );
   }
 }
 