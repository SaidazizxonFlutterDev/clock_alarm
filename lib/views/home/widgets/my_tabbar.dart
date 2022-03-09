import 'package:flutter/material.dart';

class MyTabBar {
  // appBar TAB
  static TabBar myTabBar() {
    return const TabBar(tabs: [
      Tab(
        icon: Icon(
          Icons.alarm,
        ),
      ),
      Tab(
        icon: Icon(Icons.access_time),
      ),
      Tab(
        icon: Icon(
          Icons.hourglass_bottom,
        ),
      ),
      Tab(
        icon: Icon(
          Icons.timer,
        ),
      ),
    ]);
  }
}
