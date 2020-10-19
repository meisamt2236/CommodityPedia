import 'package:commoditypedia/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String id = 'splash_route';

  Future<void> initialRoute(context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      Navigator.pushNamed(context, LoginScreen.id);
    } else {
      Navigator.pushNamed(context, MainScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (_, __, ___) => LoginScreen()));
        // Navigator.pushNamed(context, LoginScreen.id);
      } else {
        Navigator.pushNamed(context, MainScreen.id);
      }
    });
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'first_part',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      'دایرالکالا',
                      style: TextStyle(
                          fontSize: 80, fontFamily: 'IRANSansMobile_Bold'),
                    ),
                  ),
                ),
                Hero(
                  tag: 'second_part',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      '.',
                      style: TextStyle(
                          fontSize: 80, fontFamily: 'IRANSansMobile_Bold', color: Colors.orangeAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
