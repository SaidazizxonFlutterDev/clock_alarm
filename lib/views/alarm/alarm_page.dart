import 'package:clock_with_alarm/services/hive_service.dart';
import 'package:clock_with_alarm/services/time_zone_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  int hour = 00;
  int minute = 00;

  @override
  void initState() {
    super.initState();
    print(ServiceHive.timeBox!.values.toList().toString());
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box("time").listenable(),
        builder: (context, box, __) {
          final List times = box.values.toList();
          return myContainer(times);
        });
  }

  myContainer(times) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: times.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 1.0),
                    child: ExpansionTile(
                      trailing: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.013,
                          ),
                          Switch(
                            activeColor: Colors.red,
                            value: times[index]['isAlarm'],
                            onChanged: (bool v) {
                              setState(() {
                                ServiceHive.timeBox!.putAt(index, {
                                  'hour': times[index]['hour'],
                                  'minute': times[index]['minute'],
                                  'isAlarm': !times[index]['isAlarm'],
                                });
                              });
                              if (times[index]['isAlarm']) {
                                FlutterAlarmClock.createAlarm(
                                    times[index]['hour'],
                                    times[index]['minute']);
                              }
                            },
                          ),
                        ],
                      ),
                      title: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                _changeTime(times, index);
                              },
                              child: Text(
                                times[index]['hour']
                                        .toString()
                                        .padLeft(2, "0") +
                                    ":" +
                                    times[index]['minute']
                                        .toString()
                                        .padLeft(2, "0"),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.1,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                      ),
                      backgroundColor: Colors.blue.shade900,
                      collapsedBackgroundColor: Colors.blue.shade900,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(color: Colors.white),
                        ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.07,
                          color: Colors.blue.shade900,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.05,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.025),
                                child: const Text(
                                  "DELETING -->",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.025),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  _deleteItems(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Positioned(
            bottom: 1,
            right: 1,
            left: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  ServiceTimeZone.getDatas();
                  _showMyTimePicker();
                  setState(() {});
                },
                child: const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.add, color: Colors.white),
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _deleteItems(index) {
    ServiceHive.timeBox!.deleteAt(index);
  }

  _changeTime(times, index) {
    showTimePicker(
        context: context,
        initialTime: const TimeOfDay(
          hour: 0,
          minute: 0,
        )).then((value) {
      ServiceHive.timeBox!.putAt(
        index,
        {
          'hour': '${value!.hour}',
          'minute': '${value.minute}',
          'isAlarm': true,
        },
      );
      setState(() {});
    });
    setState(() {});
  }

  _showMyTimePicker() {
    showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 16, minute: 5),
    ).then((value) {
      ServiceHive.timeBox!.add(
        {
          'hour': '${value!.hour}',
          'minute': '${value.minute}',
          'isAlarm': false,
        },
      );
      print(value.hour.toString());
      print(value.minute.toString());
      setState(() {});
    });
    setState(() {});
  }
}
