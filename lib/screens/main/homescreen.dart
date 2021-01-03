import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

// Screen Imports
import 'package:yachtspot/screens/sub/discoverscreen.dart';
import 'package:yachtspot/screens/sub/accountscreen.dart';
import 'package:yachtspot/screens/sub/searchscreen.dart';

// Widget Imports
import 'package:yachtspot/widgets/dot_bottom_nav.dart';

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

  List<DotNavigationBarItem> _navItems = [
    DotNavigationBarItem(
      icon: Icon(FeatherIcons.home),
    ),
    DotNavigationBarItem(
      icon: Icon(FeatherIcons.search),
    ),
    DotNavigationBarItem(
      icon: Icon(FeatherIcons.user),
    ),
  ];

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages[_selectedTabIndex]),
      bottomNavigationBar: DotNavigationBar(
        currentIndex: _selectedTabIndex,
        items: _navItems,
        onTap: _changeIndex,
      ),
    );
  }
}
