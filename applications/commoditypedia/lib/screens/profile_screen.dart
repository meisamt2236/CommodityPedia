import 'package:commoditypedia/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:commoditypedia/widgets/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _HomeScreenMobile(),
          desktop: _HomeScreenDesktop(),
        ),
      ),
    );
  }
}

class _HomeScreenMobile extends StatefulWidget {
  @override
  __HomeScreenMobileState createState() => __HomeScreenMobileState();
}

class __HomeScreenMobileState extends State<_HomeScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () async{
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', null);
          prefs.setString('id', null);
          Navigator.pushNamed(context, SplashScreen.id);
        },
      ),
    );
  }
}

class _HomeScreenDesktop extends StatefulWidget {
  @override
  __HomeScreenDesktopState createState() => __HomeScreenDesktopState();
}

class __HomeScreenDesktopState extends State<_HomeScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', null);
          prefs.setString('id', null);
          Navigator.pushNamed(context, SplashScreen.id);
        },
      ),
    );
  }
}
