import 'dart:io';

import 'package:hive/hive.dart';


class ServiceHive {
  static Box? timeBox;
  static Box? checkBox;
  static openBox() async {
    
    timeBox = await Hive.openBox('time');

  }

  static addBox({value}) {
    timeBox!.add({
      'hour': '22',
      'minute': '30',
      'isAlarm': false,
    });
  }

  static editBox(int index, value) {
    timeBox!.putAt(index, value);
  }

  static showDb() {
    for (int i = 0; i < timeBox!.length; i++) {
      print(timeBox!.getAt(i)['hour']);
    }
  }
}
