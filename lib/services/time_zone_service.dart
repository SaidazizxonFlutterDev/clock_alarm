// ! http://worldtimeapi.org/api/timezone
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class ServiceTimeZone {
  static Future<List> getDatas() async {
    await openBox();
    Response response = await Dio().get("http://worldtimeapi.org/api/timezone");
    List datas = response.data;
    await putData(datas);
    return datas;
  }

  static Box? timeZonebox;
  static openBox() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    timeZonebox = await Hive.openBox('timezone');
  }

  static putData(List datas) {
    timeZonebox!.clear();
    timeZonebox!.addAll(datas);
  } 
}
