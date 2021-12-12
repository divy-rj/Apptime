// import 'dart:convert';
//
// import 'package:apptime/storage/app_list.dart';
// import 'package:flutter/cupertino.dart';
//
// class Data {
//   Data({
//     @required this.email,
//     @required this.deviceName,
//     @required this.apps,
//     @required this.dateTime,
//   });
//
//   String email;
//   String deviceName;
//   List<Apps_sent> apps;
//   DateTime dateTime;
//
//   factory Data.fromJson(String str) => Data.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Data.fromMap(Map<String, dynamic> json) => Data(
//     email: json["email"],
//     deviceName: json["device_name"],
//     apps: json["apps"].map((x) => Apps_sent.fromMap(x)),
//     dateTime: DateTime.parse(json["dateTime"]),
//   );
//
//   Map<String, dynamic> toMap() => {
//     "email": email,
//     "device_name": deviceName,
//     "apps": List<dynamic>.from(apps.map((x) => x.toMap())),
//     "dateTime": dateTime.toIso8601String(),
//   };
//
//   @override
//   String toString() {
//     return 'Data{email: $email, deviceName: $deviceName, apps: $apps, dateTime: $dateTime}';
//   }
// }
// To parse this JSON data, do
//
//     final data = dataFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Data {
  Data({
    @required this.email,
    @required this.deviceName,
    @required this.apps,
    @required this.dateTime,
  });

  final String email;
  final String deviceName;
  final List<App> apps;
  final DateTime dateTime;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      email: json["email"],
      deviceName: json["deviceName"],
      apps: List.of(json["apps"])
          .map((i) => i /* can't generate it properly yet */)
          .toList(),
      dateTime: DateTime.parse(json["dateTime"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'deviceName': this.deviceName,
      'apps': this.apps,
      'dateTime': this.dateTime,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      email: map['email'] as String,
      deviceName: map['deviceName'] as String,
      apps: map['apps'] as List<App>,
      dateTime: map['dateTime'] as DateTime,
    );
  } //

}

class App {
  App({
    @required this.appName,
    @required this.appUsage,
  });

  final String appName;
  final String appUsage;
  factory App.fromJson(Map<String, dynamic> json) => App(
    appName: json["appName"],
    appUsage: json["appUsage"],
  );

  Map<String, dynamic> toJson() => {
    "appName": appName,
    "appUsage": appUsage,
  };

  @override
  String toString() {
    return 'App{appName: $appName, appUsage: $appUsage}';
  }
}
