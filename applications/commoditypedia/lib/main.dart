import 'package:commoditypedia/screens/add_screen.dart';
import 'package:commoditypedia/screens/signup_screen.dart';
import 'package:commoditypedia/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:commoditypedia/screens/main_screen.dart';
import 'package:commoditypedia/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'IRANSansMobile'),
      initialRoute: SplashScreen.id,
      routes: {
        MainScreen.id: (context) => MainScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        AddScreen.id: (context) => AddScreen(),
      },
    );
  }
}
