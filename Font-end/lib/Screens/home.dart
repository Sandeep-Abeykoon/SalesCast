import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salescast/reusable_widget/SlideMenu.dart';

import 'package:salescast/reusable_widget/app_large_text.dart';

import '../assets/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {

    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      drawer: SlideMenu(),

      extendBodyBehindAppBar: true,
      // appBar: AppBar(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 70, left: 20),
              child: Row(
                children: <Widget>[
                  Builder(builder: (context) {
                    return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(
                          Icons.menu_sharp,
                          size: 30,
                          color: Colors.black,
                        ));
                  }),
                  Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("lib/assets/images/logo2.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: AppLargeText(text: "SALESCAST"),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //   ),
            // ),
            // SizedBox(height: 30,),

            Visibility(
              visible: isEmpty,
              child: Container(
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
                    "Hey! \n\nWelcome to SalesCast !!!.You can start by adding your products in the products page 😃  ",style:TextStyle(fontSize: 18,fontWeight:FontWeight.w300),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !isEmpty,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                height: 280,
                width: double.maxFinite,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                  Container(

                    child: Expanded(
                      child: SlidingDashboard(children:
                      [
                        Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 8,
                              offset: Offset(10, 5),
                            ),],
                          color: Colors.deepOrange,
                          image: DecorationImage(
                            image: AssetImage("lib/assets/images/trends.png"),
                            fit: BoxFit.fill
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // color: Colors.red,

                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 5),
                              ),],
                            color: Colors.deepOrange,
                            image: DecorationImage(
                                image: AssetImage("lib/assets/images/hello.png"),
                                fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // color: Colors.red,

                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 5),
                              ),],
                            color: Colors.deepOrange,
                            image: DecorationImage(
                                image: AssetImage("lib/assets/images/Predict Sales.png"),
                                fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // color: Colors.red,

                        ),

                      ]),
                    ),
                  ),
                    // ListView.builder(
                    //   itemCount: 3,
                    //   scrollDirection: Axis.horizontal,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return Container(
                    //
                    //       margin: const EdgeInsets.only(right: 15, top: 10),
                    //       width: 300,
                    //       height: 300,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(20),
                    //         color: Colors.white,
                    //         // image: DecorationImage(
                    //         //     image: AssetImage(_images[index]),
                    //         //     fit: BoxFit.cover)
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
         Image(image: AssetImage("lib/assets/images/OnBoardImages/Image_5.jpg"))
          ],
        ),
      ),
    );
  }
}

class SlidingDashboard extends StatefulWidget {
  final List<Widget> children;

  SlidingDashboard({required this.children});

  @override
  _SlidingDashboardState createState() => _SlidingDashboardState();
}

class _SlidingDashboardState extends State<SlidingDashboard> {
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      if (_pageController.page == widget.children.length - 1) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, index) {
        return widget.children[index % widget.children.length];
      },
      itemCount: widget.children.length * 1000,
    );
  }
}
