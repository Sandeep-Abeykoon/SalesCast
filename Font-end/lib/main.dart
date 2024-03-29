import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'package:salescast/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salescast/Screens/main_page.dart';

import 'package:salescast/Screens/view_product.dart';
import 'package:salescast/Screens/welcome.dart';
import 'package:salescast/Screens/welcome_page_slide.dart';
import 'package:salescast/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    DevicePreview(
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData(),
        home: AuthService().handleAuthState());
  }
}
