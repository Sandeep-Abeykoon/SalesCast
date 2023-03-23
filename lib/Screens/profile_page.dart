import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salescast/Screens/welcome.dart';
import 'package:salescast/auth_service.dart';



class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.red,
        //   title: Center(
        //     child: const Text(' User Profile'),
        //   ),
        // ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.deepOrange.shade300],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.5, 0.9],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 60.0,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(
                              "https://scontent.fcmb2-2.fna.fbcdn.net/v/t39.30808-6/327975720_515428384011697_8717420196609558001_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=XglucdrWZPUAX-_87kW&_nc_ht=scontent.fcmb2-2.fna&oh=00_AfAMi1R3VoioMiINSmf8Y9hlSlrz7vBdSPPTaBUyIb_7Tg&oe=6413128E"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Chathuni Abeysinghe',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Chathuni Abeysinghe',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'chathuni@gmail.com',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      AuthService().signOut();
                      FirebaseAuth.instance.signOut().then((value) => {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>WelcomePage()))});

                    },
                    child: Text('Sign Out'),
                  )
                ],
              ),
            )
          ],
        ),

    );
  }
}

























// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:salescast/Screens/welcome.dart';
// import 'package:salescast/assets/colors.dart';
// import 'package:salescast/auth_service.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: hexStringToColor("#b2d8d8"),
//       appBar: AppBar(
//         title: Text("Profile Page",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//
//       ),
//       body: Column(
//         children: [
//           Container(
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(100, 300, 100, 20),
//               child: Center(
//                 child: ElevatedButton(
//                     onPressed:(){
//                       AuthService().signOut();
//                       //
//                       // FirebaseAuth.instance.signOut().then((value) => {
//                       //   Navigator.push(context, MaterialPageRoute(
//                       //       builder: (context)=>WelcomePage()))});
//                       },
//                     child: Text("Logout"),),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
