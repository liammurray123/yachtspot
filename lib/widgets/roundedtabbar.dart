import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedTabBar extends StatelessWidget {
  RoundedTabBar({
    this.labels,
  });
  List<String> labels = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF4E556A),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Color(0xFF0D1333),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          tabs: [
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text(labels[0]),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text(labels[1]),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text(labels[2]),
              ),
            ),
          ]),
    );
  }
}
