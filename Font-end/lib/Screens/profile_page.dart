
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  final ImagePicker _picker = ImagePicker();
  String imageUrl = "";
  var userId = "";
  XFile? _image;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    userId = user!.uid;
    imageUrl = user.photoURL ?? '';
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75,
      );

      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
          uploadPic(context);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadPic(BuildContext context) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('ProfilePics')
          .child(userId)
          .child(_image!.path);
      final task = ref.putFile(File(_image!.path));
      final snapshot = await task.whenComplete(() {});
      imageUrl = await snapshot.ref.getDownloadURL();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile Picture Updated')),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  final user = FirebaseAuth.instance.currentUser;
  var url = FirebaseAuth.instance.currentUser?.photoURL;
  final name = FirebaseAuth.instance.currentUser?.displayName;
  final email = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
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
                SizedBox(
                  height: 20,
                ),
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
                            child: imageUrl == ''
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
                              errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                            // imageUrl =="" ? Icon(Icons.person,color: Colors.white,size: 80,)
                            //                             //   : CachedNetworkImage(imageUrl: imageUrl)
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 5,
                            child: IconButton(
                              icon: Icon(Icons.camera_alt,
                                  color: Colors.black, size: 35),
                              onPressed: () {
                                _pickImage(ImageSource.gallery);
                              },
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  name!,
                  style: const TextStyle(
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
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: const Text(
                    'Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    name!,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  trailing:
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                ),
                Divider(),
                ListTile(
                  title: const Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    email!,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple.withOpacity(0.6), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    AuthService().signOut();
                    FirebaseAuth.instance.signOut().then((value) => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WelcomePage()))
                    });
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

























