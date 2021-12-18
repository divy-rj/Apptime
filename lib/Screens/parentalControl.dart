import 'package:app_usage/app_usage.dart';
import 'package:apptime/storage/app_list.dart';
import 'package:apptime/widget/getusage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class ParentalControl extends StatefulWidget {
  const ParentalControl({Key key}) : super(key: key);

  @override
  _ParentalControlState createState() => _ParentalControlState();
}

class _ParentalControlState extends State<ParentalControl> {
  List<Apps> app_sent;
  void init() async{
    // TODO: implement initState
    List apps = await DeviceApps.getInstalledApplications(onlyAppsWithLaunchIntent: true,
        includeAppIcons: true, includeSystemApps: true);
    List<AppUsageInfo> infoList = await getUsageStats(0);
    app_sent=await GetApps().getApps(infoList, apps);
    super.initState();
  }
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      child: ListView.builder(
        itemCount: app_sent.length,
        itemBuilder: (context, index) {

        return ListTile(
          leading: Image.memory(app_sent[index].images),
          title: Text(app_sent[index].appName),
          trailing: TextButton(
            child: Text("Set timer"),
            onPressed: (){
              
            },
          )
        ) ;
      },)

    );
  }
}
