<<<<<<< Updated upstream
// TODO Implement this library.
=======
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:salescast/Screens/about_us.dart';
import 'package:salescast/Screens/broken.dart';
import 'package:salescast/Screens/welcome_page_slide.dart';

import '../Screens/profile_page.dart';

class SlideMenu extends StatefulWidget {
   SlideMenu({Key? key}) : super(key: key);

  @override
  State<SlideMenu> createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu> {
  String imageUrl = "";
  var userId = " ";
bool _iconbool = false;
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    userId = user!.uid;
    imageUrl = user.photoURL ?? '';
  }
  final user = FirebaseAuth.instance.currentUser;
  var url = FirebaseAuth.instance.currentUser?.photoURL;
  final name= FirebaseAuth.instance.currentUser?.displayName;
  final email= FirebaseAuth.instance.currentUser?.email;

IconData _iconLight = Icons.wb_sunny;
IconData _iconDark= Icons.nights_stay;

ThemeData _lightTheme = ThemeData(primarySwatch: Colors.amber,brightness: Brightness.light);
ThemeData _darkTheme = ThemeData(primarySwatch: Colors.red,brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(

            decoration: BoxDecoration(
              image:DecorationImage(
                image: AssetImage("lib/assets/images/Bg1.jpg"),
                fit: BoxFit.cover
              )



            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child:imageUrl == ''
                    ? Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 80,
                )
                    : CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) =>
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 80,
                      ),
                ),
                // Image.asset("lib/assets/images/health.png",width: 90,height: 90,fit: BoxFit.cover,),
              ),
            ),
              accountName:Text(name!,style: TextStyle(fontSize: 18,color: Colors.black38),),
              accountEmail: Text(email!,style: TextStyle(fontSize: 18,color: Colors.black38),)),
          ListTile(
            leading: Icon(Icons.person_2_outlined),
            title: Text("Profile"),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));},
          ),
          // ListTile(
          //   leading: Icon(_iconbool ? _iconDark : _iconLight),
          //   title: Text("Dark Mode"),
          //   onTap: (){
          //     setState(() {
          //       _iconbool = !_iconbool;
          //
          //     });
          //
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Share"),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Broken()));


            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined),
            title: Text("Privacy Policy"),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Broken()));},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Broken()));},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About Us"),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));},
          ),



        ],

      ),

    );
  }
}
>>>>>>> Stashed changes
