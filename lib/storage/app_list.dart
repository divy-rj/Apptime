import 'package:flutter/cupertino.dart';

class Apps{
  final String appName;
  final String appUsage;

   Apps({
    @required this.appName,
    @required this.appUsage,
  });

  Map<String, dynamic> toJson() {
    return {
      "appName": this.appName,
      "appUsage": this.appUsage,
    };
  }

  factory Apps.fromJson(Map<String, dynamic> json) {
    return Apps(
      appName: json["appName"],
      appUsage: json["appUsage"],
    );
  }
//

//

}

