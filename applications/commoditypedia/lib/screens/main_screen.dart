import 'package:commoditypedia/screens/add_screen.dart';
import 'package:commoditypedia/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:commoditypedia/widgets/custom_tab_bar.dart';
import 'package:commoditypedia/screens/home_screen.dart';
import 'package:commoditypedia/widgets/responsive.dart';
import 'package:commoditypedia/widgets/custom_app_bar.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_route';
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    Scaffold(),
    AddScreen(),
    Scaffold(),
    ProfileScreen(),
  ];
  final List<IconData> _icons = const [
    Icons.layers,
    Icons.search,
    Icons.add,
    Icons.local_offer,
    Icons.account_circle,
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: _icons.length,
        child: Scaffold(
          appBar: Responsive.isDesktop(context)
              ? PreferredSize(
                  child: CustomAppBar(
                    icons: _icons,
                    selectedIndex: _selectedIndex,
                    onTap: (index) => setState(() => _selectedIndex = index),
                  ),
                  preferredSize: Size(screenSize.width, 100))
              : null,
          body: IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          bottomNavigationBar: !Responsive.isDesktop(context)
              ? CustomTabBar(
                  icons: _icons,
                  selectedIndex: _selectedIndex,
                  onTap: (index) => setState(() => _selectedIndex = index),
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
