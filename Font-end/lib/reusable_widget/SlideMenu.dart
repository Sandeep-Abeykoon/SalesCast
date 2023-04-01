import 'package:flutter/material.dart';
import 'package:salescast/Screens/welcome_page_slide.dart';

import '../Screens/profile_page.dart';

class SlideMenu extends StatefulWidget {
   SlideMenu({Key? key}) : super(key: key);

  @override
  State<SlideMenu> createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu> {
bool _iconbool = false;

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
                child: Image.asset("lib/assets/images/health.png",width: 90,height: 90,fit: BoxFit.cover,),
              ),
            ),
              accountName:Text("Jessica Smith",style: TextStyle(fontSize: 18,color: Colors.black38),),
              accountEmail: Text("abc@gmail.com",style: TextStyle(fontSize: 18,color: Colors.black38),)),
          ListTile(
            leading: Icon(Icons.person_2_outlined),
            title: Text("Profile"),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));},
          ),
          ListTile(
            leading: Icon(_iconbool ? _iconDark : _iconLight),
            title: Text("Dark Mode"),
            onTap: (){
              setState(() {
                _iconbool = !_iconbool;

              });

            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Share"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined),
            title: Text("Privacy Policy"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About Us"),
            onTap: (){},
          ),



        ],

      ),

    );
  }
}