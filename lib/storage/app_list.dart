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
//

}

