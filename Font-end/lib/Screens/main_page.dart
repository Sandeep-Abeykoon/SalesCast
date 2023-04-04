import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:salescast/Screens/forecasts.dart';
import 'package:salescast/Screens/home.dart';
import 'package:salescast/Screens/products_page.dart';
import 'package:salescast/Screens/profile_page.dart';
import 'package:salescast/Screens/RecordsPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List pages = [
    HomePage(),
    ProductsPage(),
    MyRecordsPage(),
   ForecastsPage(),
    ProfilePage()
  ];
  int currentIndex = 0;
  void onTap(int index) {

    setState(() {

      currentIndex = index;
    });
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => pages[currentIndex]),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white54,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: onTap,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.box), label: "Prodcuts"),
          BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.newspaper), label: "Records"),
          BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.bar_chart), label: "Forecasts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: "Profile")
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
