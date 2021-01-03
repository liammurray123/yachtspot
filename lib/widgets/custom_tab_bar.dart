import 'package:flutter/material.dart';
import 'package:yachtspot/constants.dart';
import 'package:flutter/cupertino.dart';

class RoundedTabBar extends StatelessWidget {
  RoundedTabBar({this.tabs});
  final List<TabInfo> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kBlueColor.withOpacity(0.3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TabBar(
        unselectedLabelColor: Colors.white,
        labelColor: kBlueColor,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        tabs: [
          for (final item in tabs)
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text(item.label),
              ),
            ),
        ],
      ),
    );
  }
}

/// A tab to display in a [RoundedTabBar]
class TabInfo {
  /// An icon to display.
  final Widget icon;

  final String label;
  TabInfo({
    this.icon,
    this.label,
  });
}
