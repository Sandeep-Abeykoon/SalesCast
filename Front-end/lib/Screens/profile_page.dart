import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salescast/Screens/welcome.dart';
import 'package:salescast/auth_service.dart';

import '../assets/colors.dart';



class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override

  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  String imageUrl = "";
  var userId = " ";
@override

  User? user = FirebaseAuth.instance.currentUser;



 void pickUploadImage() async{
   final image = await ImagePicker().pickImage(

       source:ImageSource.gallery,
       maxHeight: 512,
       maxWidth: 512,
       imageQuality: 75);

   Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");
   await  ref.putFile(File(image!.path));
   ref.getDownloadURL().then((value)  {
     print(value);
     setState(() {
       imageUrl =value;
     });

   });
 }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

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
            height: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurpleAccent, Colors.deepPurple.shade400],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.5, 0.9],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0), //or 15.0
                          child: Container(
                            height: 150.0,
                            width: 150.0,
                            color: Colors.blueGrey,
                            child:
                            imageUrl =="" ? Icon(Icons.person,color: Colors.white,size: 80,)
                                : Image.network(imageUrl,fit: BoxFit.cover,)
                          ),
                        ),
                        // CircleAvatar(
                        //
                        //   backgroundColor: Colors.white,
                        //   minRadius: 65.0,
                        //   child: CircleAvatar(
                        //       radius: 60.0,
                        //
                        //
                        //
                        //
                        //       // backgroundImage:
                        //       // imageUrl.isEmpty? AssetImage("lib/assets/images/Image_7.jpg")
                        //       // : FileImage(file)(_) ,
                        //       // NetworkImage("")
                        //   ),
                        // ),
                        Positioned(
                            bottom: 0,
                            right: 5,

                            child: IconButton(

                              icon: Icon(Icons.camera_alt, color: Colors.black,
                                  size: 35),
                              onPressed: () {
                               pickUploadImage();


                              },
                            )),


                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),


                //
                //                 TextButton(
                //                     onPressed: () async{
                //                       ImagePicker imagepicker= ImagePicker();
                //
                //                       XFile? file= await imagepicker.pickImage(source: ImageSource.gallery);
                //                       print("${file?.path}");
                //                       if(file == null)return;
                //                        String UniqueFileName= DateTime.now().microsecondsSinceEpoch.toString();
                //
                //                       Reference referenceRoot= FirebaseStorage.instance.ref();
                //                       Reference referenceDirImages= referenceRoot.child("ProfilePics");
                //                       Reference referenceUserFolder= referenceDirImages.child(userId);
                //                       Reference referenceImageToUpload = referenceUserFolder.child(UniqueFileName);
                //
                // try {
                //                         await referenceImageToUpload.putFile(File(file.path));
                //                         imageUrl= await referenceImageToUpload.getDownloadURL();
                //                         print(imageUrl);
                //                     } catch (e) {
                //                         print(e);
                //
                //                       }
                //                     },
                //                     child: Text("Upload Image",style: TextStyle(fontSize: 16),)),


                // showMenu(
                //   context: context,
                //   position: RelativeRect.fromLTRB(100.0, 100.0, 0.0, 0.0),
                //   items: <PopupMenuEntry>[
                //     PopupMenuItem(
                //       value: 1,
                //       child: Text('View Profile Picture'),
                //       onTap: (){},
                //     ),
                //     PopupMenuItem(
                //       value: 2,
                //       child: Text('Upload Image'),
                //     ),
                //
                //   ],
                // ).then((value) {
                //   // Do something when a menu item is selected
                // });


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
                SizedBox(height: 20,),
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
                SizedBox(height: 60,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    AuthService().signOut();
                    FirebaseAuth.instance.signOut().then((value) =>
                    {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => WelcomePage()))});
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




  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text("Choose Profile Photo", style: TextStyle(fontSize: 20),),
          SizedBox(height: 20,),
          Row(
            children: [
              SizedBox(width: 50,),
              ElevatedButton.icon(icon: Icon(Icons.camera), onPressed: () async {
                ImagePicker imagepicker = ImagePicker();

                XFile? file = await imagepicker.pickImage(
                    source: ImageSource.camera);
                print("${file?.path}");
                if (file == null) return;
                String UniqueFileName = DateTime
                    .now()
                    .microsecondsSinceEpoch
                    .toString();

                Reference referenceRoot = FirebaseStorage
                    .instance.ref();
                Reference referenceDirImages = referenceRoot
                    .child("ProfilePics");
                Reference referenceUserFolder = referenceDirImages
                    .child(userId);
                Reference referenceImageToUpload = referenceUserFolder
                    .child(UniqueFileName);

                try {
                  await referenceImageToUpload.putFile(
                      File(file.path));
                  imageUrl =
                      await referenceImageToUpload.getDownloadURL();
                  print(imageUrl);
                } catch (e) {
                  print(e);
                }




              }, label: Text("Camera"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((
                          states) {
                        if (states.contains(MaterialState.pressed)) {
                          return hexStringToColor("#b2d8d8");
                        }
                        return hexStringToColor("#66b2b2");
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)))
                  )
              ),
              SizedBox(width: 50,),


              ElevatedButton.icon(onPressed: () async{


                ImagePicker imagepicker = ImagePicker();

                XFile? file = await imagepicker.pickImage(
                    source: ImageSource.gallery);
                print("${file?.path}");
                if (file == null) return;
                String UniqueFileName = DateTime
                    .now()
                    .microsecondsSinceEpoch
                    .toString();

                Reference referenceRoot = FirebaseStorage
                    .instance.ref();
                Reference referenceDirImages = referenceRoot
                    .child("ProfilePics");
                Reference referenceUserFolder = referenceDirImages
                    .child(userId);
                Reference referenceImageToUpload = referenceUserFolder
                    .child(UniqueFileName);

                try {
                  await referenceImageToUpload.putFile(
                      File(file.path));
                  imageUrl =
                      await referenceImageToUpload.getDownloadURL();
                  print(imageUrl);
                } catch (e) {
                  print(e);
                }

setState(() {

});

              }, icon: Icon(Icons.image), label: Text("Gallery"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((
                        states) {
                      if (states.contains(MaterialState.pressed)) {
                        return hexStringToColor("#b2d8d8");
                      }
                      return hexStringToColor("#66b2b2");
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))
                ),),

            ],
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
