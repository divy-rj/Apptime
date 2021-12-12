import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class Apps{
  final String appName;
  final String appUsage;
  final Uint8List images;
   Apps( {
    @required this.appName,
    @required this.appUsage,
    @required this.images,
  });

  factory Apps.fromJson(Map<String, dynamic> json) {
    return Apps(
      appName: json["appName"],
      appUsage: json["appUsage"],
      images:Uint8List.fromList(json['profile'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "appName": this.appName,
      "appUsage": this.appUsage,
      "images": this.images as List<int>,
    };
  }

  @override
  String toString() {
    return '"Apps":{appName: $appName, appUsage: $appUsage, images: $images}';
  }
//

}

// class Apps_sent{
//   final String appName;
//   final String appUsage;
//
//    Apps_sent({
//     @required this.appName,
//     @required this.appUsage,
//   });
//
//   factory Apps_sent.fromJson(Map<String, dynamic> json) {
//     return Apps_sent(
//       appName: json["appName"],
//       appUsage: json["appUsage"],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "appName": this.appName,
//       "appUsage": this.appUsage,
//     };
//   }
//
//   @override
//   String toString() {
//     return '{appName: $appName, appUsage: $appUsage}';
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'appName': this.appName,
//       'appUsage': this.appUsage,
//     };
//   }
//
//   factory Apps_sent.fromMap(Map<String, dynamic> json) => Apps_sent(
//     appName: json["appName"],
//     appUsage: json["appUsage"],
//   );
// //
//
// }
