import 'dart:async';

import 'package:clock_with_alarm/services/global_time_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  String? _nowHour, _nowMinute, _nowSecond;
  Timer? _everySecond;

  @override
  void initState() {
    super.initState();

    // set frist values
    _nowHour = DateTime.now().hour.toString();
    _nowMinute = DateTime.now().minute.toString();
    _nowSecond = DateTime.now().second.toString();

    //define timers
    _everySecond = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _nowHour = DateTime.now().hour.toString();
        _nowMinute = DateTime.now().minute.toString();
        _nowSecond = DateTime.now().second.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box('timezone').listenable(),
        builder: (context, box, __) {
          final List timeZones = box.values.toList();
          return FutureBuilder(builder: (context, AsyncSnapshot snap) {
            if (!snap.hasData) {
              return ValueListenableBuilder<Box>(
                  valueListenable: Hive.box('globaltimeBox').listenable(),
                  builder: (context, globalTimeBox, __) {
                    final List globalTimes = globalTimeBox.values.toList();
                    return myContainer(context, timeZones, globalTimes);
                  });
            } else if (snap.hasError) {
              return const Center(
                child: Text(
                  "ERRORR: 404",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              var globalTImeDatas = snap.data;
              return myContainer(context, timeZones, globalTImeDatas);
            }
          });
        });
  }

  Container myContainer(
      BuildContext context, List timeZones, var globalTimeDatas) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blue.shade900,
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$_nowHour:$_nowMinute:$_nowSecond",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.13,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white),
          Text(globalTimeDatas[0]['abbreviation'].toString()),
          Expanded(
            flex: 6,
            child: ListView.builder(
              itemCount: timeZones.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        ServiceGlobalTime.selectedZone = timeZones[index];
                        setState(() {});
                      },
                      child: Text(timeZones[index]),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
