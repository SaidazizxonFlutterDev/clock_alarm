import 'dart:io';

import 'package:clock_with_alarm/models/global_timezone_model.dart';
import 'package:clock_with_alarm/services/time_zone_service.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class ServiceGlobalTime {
  static showDatas() async {
    List a = await ServiceTimeZone.getDatas();
    selectedZone = a[0];
  }

  static String? selectedZone = "Africa/Abidjan";
  static Future<List<GlobalTImeZoneModel>> getDatas() async {
    await openBox();
    Response response =
        await Dio().get('http://worldtimeapi.org/api/timezone/$selectedZone');

    List<GlobalTImeZoneModel> datas = (response.data as List)
        .map((e) => GlobalTImeZoneModel.fromJson(e))
        .toList();

    addToBox(datas);
    return datas;
  }

  static Box? globalTimeBox;
  static openBox() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    globalTimeBox = await Hive.openBox('globaltimeBox');
  }

  static addToBox(datas) {
    globalTimeBox!.clear();
    globalTimeBox!.addAll(datas);
  }
}
