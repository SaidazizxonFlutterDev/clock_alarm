import 'package:hive/hive.dart';

part 'global_timezone_model.g.dart';

@HiveType(typeId: 0)
class GlobalTImeZoneModel {
  GlobalTImeZoneModel({
    this.abbreviation,
    this.clientIp,
    this.datetime,
    this.dayOfWeek,
    this.dayOfYear,
    this.dst,
    this.dstFrom,
    this.dstOffset,
    this.dstUntil,
    this.rawOffset,
    this.timezone,
    this.unixtime,
    this.utcDatetime,
    this.utcOffset,
    this.weekNumber,
  });

  @HiveField(0)
  String? abbreviation;
  @HiveField(1)
  String? clientIp;
  @HiveField(2)
  DateTime? datetime;
  @HiveField(3)
  int? dayOfWeek;
  @HiveField(4)
  int? dayOfYear;
  @HiveField(5)
  bool? dst;
  @HiveField(6)
  dynamic? dstFrom;
  @HiveField(7)
  int? dstOffset;
  @HiveField(8)
  dynamic? dstUntil;
  @HiveField(9)
  int? rawOffset;
  @HiveField(10)
  String? timezone;
  @HiveField(11)
  int? unixtime;
  @HiveField(12)
  DateTime? utcDatetime;
  @HiveField(13)
  String? utcOffset;
  @HiveField(014)
  int? weekNumber;


  factory GlobalTImeZoneModel.fromJson(Map<String, dynamic> json) =>
      GlobalTImeZoneModel(
        abbreviation: json["abbreviation"],
        clientIp: json["client_ip"],
        datetime: DateTime.parse(json["datetime"]),
        dayOfWeek: json["day_of_week"],
        dayOfYear: json["day_of_year"],
        dst: json["dst"],
        dstFrom: json["dst_from"],
        dstOffset: json["dst_offset"],
        dstUntil: json["dst_until"],
        rawOffset: json["raw_offset"],
        timezone: json["timezone"],
        unixtime: json["unixtime"],
        utcDatetime: DateTime.parse(json["utc_datetime"]),
        utcOffset: json["utc_offset"],
        weekNumber: json["week_number"],
      );

  Map<String, dynamic> toJson() => {
        "abbreviation": abbreviation,
        "client_ip": clientIp,
        "datetime": datetime!.toIso8601String(),
        "day_of_week": dayOfWeek,
        "day_of_year": dayOfYear,
        "dst": dst,
        "dst_from": dstFrom,
        "dst_offset": dstOffset,
        "dst_until": dstUntil,
        "raw_offset": rawOffset,
        "timezone": timezone,
        "unixtime": unixtime,
        "utc_datetime": utcDatetime!.toIso8601String(),
        "utc_offset": utcOffset,
        "week_number": weekNumber,
      };
}
