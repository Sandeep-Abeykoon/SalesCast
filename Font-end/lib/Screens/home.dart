import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    List _images = [
      "lib/assets/images/Image_6.jpg",
      "lib/assets/images/Image_1.jpg",
      "lib/assets/images/Image_4.jpg"
    ];
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      drawer: SlideMenu(),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 70, left: 20),
            child: SingleChildScrollView(
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
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: AppLargeText(text: "SalesCast"),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            height: 300,
            width: double.maxFinite,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 15, top: 10),
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage(_images[index]),
                              fit: BoxFit.cover)),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class CircleTabIndicator extends Decoration {
//   final Color color;
//   double radius;
//
//   CircleTabIndicator({required this.color, required this.radius});
//
//   @override
//   BoxPainter createBoxPainter([VoidCallback? onChanged]) {
//     // TODO: implement createBoxPainter
//     return _CirclePainter(color: color, radius: radius);
//   }
// }
//
// class _CirclePainter extends BoxPainter {
//   final Color color;
//   double radius;
//
//   _CirclePainter({required this.color, required this.radius});
//
//   @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
//     Paint _paint = Paint();
//     _paint.color = color;
//     _paint.isAntiAlias = true;
//     final Offset circleOffset = Offset(configuration.size!.width / 2, 0);
//     canvas.drawCircle(offset + circleOffset, radius, _paint);
//   }
// }
