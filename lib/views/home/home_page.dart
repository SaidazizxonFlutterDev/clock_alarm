import 'package:clock_with_alarm/views/alarm/alarm_page.dart';
import 'package:clock_with_alarm/views/clock/clock_page.dart';
import 'package:clock_with_alarm/views/home/widgets/my_tabbar.dart';
import 'package:clock_with_alarm/views/stopwatch/stopwatch_page.dart';
import 'package:clock_with_alarm/views/timer/timer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AlarmPage? alarmPage;
  ClockPage? clockPage;
  TimerPage? timerPage;
  StopWatchPage? stopWatchPage;
  List myTabBarPages = [];
  @override
  void initState() {
    alarmPage = const AlarmPage();
    clockPage = const ClockPage();
    timerPage = const TimerPage();
    stopWatchPage = const StopWatchPage();

    myTabBarPages.addAll([clockPage,alarmPage, timerPage, stopWatchPage]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {  
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.blue.shade900),
          backgroundColor: Colors.blue.shade900,
          title: MyTabBar.myTabBar(),
        ),
        body: TabBarView(
                children: [
                  myTabBarPages[0],
                  myTabBarPages[1],
                  myTabBarPages[2],
                  myTabBarPages[3],
                ],
              ),
      ),
    );
  }

  tabBar() {
    return const TabBar(tabs: [
      Tab(
        icon: Icon(
          Icons.alarm,
        ),
      ),
      Tab(
        icon: Icon(
          Icons.settings,
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
