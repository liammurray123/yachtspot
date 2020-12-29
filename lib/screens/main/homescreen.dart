import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:yachtspot/constants.dart';

// Screen Imports
import 'package:yachtspot/screens/sub/discoverscreen.dart';
import 'package:yachtspot/screens/sub/accountscreen.dart';
import 'package:yachtspot/screens/sub/searchscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  List _pages = [
    DiscoverScreen(),
    SearchScreen(),
    AccountScreen(),
  ];
  List _navicons = [];
  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages[_selectedTabIndex]),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: kBlueColor,
        selectedItemColor: kRedColor,
        currentIndex: _selectedTabIndex,
        onTap: _changeIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(FeatherIcons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.user), label: 'Account'),
        ],
      ),
    );
  }
}
