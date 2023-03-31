import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:salescast/Screens/welcome.dart';
import 'package:salescast/assets/colors.dart';
import 'package:salescast/reusable_widget/app_large_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
 class WelcomePageSlide extends StatefulWidget {
   const WelcomePageSlide({Key? key}) : super(key: key);

   @override
   State<WelcomePageSlide> createState() => _WelcomePageSlideState();
 }

 class _WelcomePageSlideState extends State<WelcomePageSlide> {
   List images= ["lib/assets/images/Image_2.png","lib/assets/images/Image_3.png","lib/assets/images/Image_5.png"

   ];
   final controller = LiquidController();
   int currentPage = 0;
   @override
   Widget build(BuildContext context) {
     return Scaffold(

       body:Stack(
         alignment: Alignment.center,
         children: [
           LiquidSwipe(
             liquidController: controller,
              onPageChangeCallback: onPageChanged,
               pages: [
                 Container(
                     color: tOnBordingPage1color,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     SizedBox(height: 10,),
                     AppLargeText(text:"Welcome to SalesCast!" ),

                     Image(
                         image:
                         AssetImage("lib/assets/images/OnBoardImages/Student_and_teacher_studying_financial_graph_growth-removebg-preview.png"),height:MediaQuery.of(context).size.height * 0.4 ,width: MediaQuery.of(context).size.width,
                     ),
                     SizedBox(height: 10,),
                     Text("Let's start the journey with Salescast",style: TextStyle(fontFamily: "Poppins",fontSize: 18,color: Colors.grey),),
                     SizedBox(height: 30,),
                     Text("1/3",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                   ],
                 ),
                 ),
                 Container(color: tOnBordingPage2color,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       SizedBox(height: 10,),

                       Image(
                         image:
                         AssetImage("lib/assets/images/OnBoardImages/competitor_analysis_16-removebg-preview.png"),height:MediaQuery.of(context).size.height * 0.4 ,width: MediaQuery.of(context).size.width,
                       ),

                       Text("",style: TextStyle(fontFamily: "Poppins",fontSize: 26,fontWeight:FontWeight.bold,color: Colors.black),),
                       SizedBox(height: 10,),
                       Padding(
                         padding: EdgeInsets.only(left: 30),
                           child: Text("Get the detailed forecasts of your favourite products.",style: TextStyle(fontFamily: "Poppins",fontSize: 18,color: Colors.grey),)),
                       SizedBox(height: 10,),
                       Text("2/3",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                     ],
                   ),),
                  Container(color: tOnBordingPage3color,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),

                        Image(
                          image:
                          AssetImage("lib/assets/images/OnBoardImages/rebranding_5-removebg-preview.png"),height:MediaQuery.of(context).size.height * 0.4 ,width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(height: 10,),
                        Padding
                          (padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                            child: Text("Compare the forecasts of your product brand with the highest demanding product brands.",style: TextStyle(fontFamily: "Poppins",fontSize: 18,color: Colors.grey),)),
                        SizedBox(height: 10,),
                        Text("3/3",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                      ],
                    ),)

                  ],
             slideIconWidget: Icon(Icons.arrow_back_ios),
             enableSideReveal: true,
           ),

           Positioned(
             bottom: 30,
               child:OutlinedButton(
                 onPressed: (){
                   if(controller.currentPage ==2){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePage()));

                   }
                   int nextpage = controller.currentPage +1 ;
                   controller.animateToPage(page: nextpage);

                 },

                 style: ElevatedButton.styleFrom(
                   side:  BorderSide(color: Colors.grey),
                   shape:  CircleBorder(),
                   padding:  EdgeInsets.all(15),
                   onPrimary: Colors.white,
                 ),
                 child: Container(
                   padding: EdgeInsets.all(20),
                   decoration: BoxDecoration(
                     color: Colors.black,shape: BoxShape.circle,
                   ),
                   child:  Icon(Icons.arrow_forward_ios),

                 ),
               )
           ),
           Positioned(
             top: 50,
               right: 20,

               child: TextButton(
                 onPressed: ()=> controller.jumpToPage(page: 2),
                 child: Text(
                   "Skip",style: TextStyle(color: Colors.grey),
                 ),
               )),
           Positioned(
             bottom: 10,

               child: AnimatedSmoothIndicator(
             activeIndex: controller.currentPage, count: 3,
               effect: WormEffect(
                 activeDotColor: Colors.black,
                 dotHeight: 5,
               ),))
         ],
       )
     );
   }

 void onPageChanged(int activePageIndex) {
     currentPage = activePageIndex;
     setState(() {

     });
 }
 }
