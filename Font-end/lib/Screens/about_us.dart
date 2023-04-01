import 'package:flutter/material.dart';
import 'package:salescast/reusable_widget/app_large_text.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white.withOpacity(0.3),
      appBar: AppBar(
        title: Text(
          "About Us",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.3)),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: AppLargeText(text: "About Us"))),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 230,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 5),
                  ),
                ],
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "We are team Code Fellas, a group of second-year undergraduates "
                    "undertaking the BEng (Hons) Software Engineering Degree at the "
                    "Informatics Institute of Technology (IIT) affiliated with the "
                    "University of Westminster, United Kingdom. And this app was created "
                    "for the software development group project",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black38),
              ),
              ),

            // Align(
            //   alignment: Alignment.center,
            //   child: Padding(
            //     padding: EdgeInsets.all(10),
            //     child: Text(
            //       "We are team Code Fellas, a group of second-year undergraduates "
            //       "undertaking the BEng (Hons) Software Engineering Degree at the "
            //       "Informatics Institute of Technology (IIT) affiliated with the "
            //       "University of Westminster, United Kingdom. And this app was created "
            //       "for the software development group project",
            //       style: TextStyle(
            //           fontSize: 20,
            //           fontWeight: FontWeight.w400,
            //           color: Colors.black26),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Team Members",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    child: Image.network(
                        "https://scontent.xx.fbcdn.net/v/t39.30808-6/320611540_550812906920991_1079932591519390075_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGz4rzJc5su_sIXMp1W0nZ_WTVWZlWXWQpZNVZmVZdZCm36lKC23vvV0uFgz1mTSG1wi4WleSB1NAXKYyig9CY2&_nc_ohc=66zfgqEO-zAAX8K46mD&_nc_ht=scontent.xx&oh=00_AfD9TcLUACn7ug3kWuqlaj2TySi0OR3MjM2x-d3woY3tzw&oe=642C95C5"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sandeep Abeykoon -Team Leader",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Column(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    child: Image.network(
                        "https://scontent.xx.fbcdn.net/v/t39.30808-6/332560160_703530074793998_8708869170746102805_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEAUir01oAG7prPvWEboNhBX4NG1AK3lfJfg0bUAreV8kJyf5IXvPaMRAkCY21a-JDTixWQtFO-PQ-WijgEmCO0&_nc_ohc=_Jqt_f5FvRoAX-E0Fjh&_nc_ht=scontent.xx&oh=00_AfD1_vr2Pj29JI_lIaE9jPLTXYyCqpUULspWm_Kkic4dqQ&oe=642C1BEB"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Ravindu Yasintha -Team member",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Column(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    child: Image.network(
                        "https://scontent.xx.fbcdn.net/v/t39.30808-6/327975720_515428384011697_8717420196609558001_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeH8GSlU-BuH3AsXzeE93FjetmWhAP0NDQC2ZaEA_Q0NAK1IHYWHWmHPxxFclkwhZzK5b9IyRCgeh1PK-eQa11mV&_nc_ohc=21_4wX6k-J4AX9EpbrP&_nc_ht=scontent.xx&oh=00_AfBtqLfN-4CsLJ9zYzxSDfevRo07QstorwqEoyY4r515BQ&oe=642ACD8E"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Chathuni Abeysinghe -Team member",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Column(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    child: Image.network(
                        "https://scontent.xx.fbcdn.net/v/t39.30808-6/335189623_531118355795784_3314921151258614755_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGS8OQiV1O__441YpQ8eEyAjs2lwz5ePAuOzaXDPl48C78nfsrtrfXmI0o-9Xnk2mMG7HqCH8OY2pi4WLix-067&_nc_ohc=do7Rb7ZyHqUAX_LBGas&_nc_ht=scontent.xx&oh=00_AfClCK35QjuGVavrghzLMRJcb0MO5vMIhGX2nZza_0f-5A&oe=642BA5AA"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Tharushi Amarabandu -Team member",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
              child: Column(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    child: Image.network(
                        "https://avatars.githubusercontent.com/u/107125445?v=4"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Akilan Dananjayan -Team member",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text("©  2023 All rights reserved")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
