import 'dart:convert';
import 'dart:typed_data';

import 'package:app_usage/app_usage.dart';
import 'package:apptime/storage/app_list.dart';
import 'package:apptime/storage/securestorage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../page/pie_chart_page.dart';
import '../widget/getusage.dart';
import '../page/bargraph.dart';
import 'acc_info.dart';
import 'dart:io' as Io;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
List<AppUsageInfo> _infos = [];
List<Application> _apps =  [];
List<Apps> list_apps=[];
class _MyHomePageState extends State<MyHomePage> {

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  DateTime total_screentime;
  String name;
  @override
  void initState() {
    getUsage();
    super.initState();
     init();
  }

  Future init()async{
    final name=await UserSecureStorage.getUsername();
    setState(() {
       this.name=name;
    });

  }
  Future<List<Apps>> getApps()async {
      List<Apps> appsList=[];
      for (var info in _infos) {
        for(var app in _apps) {
          if (info.appName != 'apptime' && info.packageName == app.packageName) {
            //   //
            Uint8List image=await( app is ApplicationWithIcon ? app.icon : null);
            Apps apps=await Apps(appName: app.appName,appUsage: info.usage.toString().substring(0,(info.usage.toString().length)-7),images:image);
            appsList.add(apps);
          }
        }
      }
      list_apps=appsList;
  }
  Future<void> getApp() async{
    List apps = await DeviceApps.getInstalledApplications(onlyAppsWithLaunchIntent: true,
        includeAppIcons: true, includeSystemApps: true);
    setState(() {
      _apps = apps;
    });
  }
  void getUsage() async {
    try {
      List<AppUsageInfo> infoList = await getUsageStats(0);
     await getApp();
      setState(() {
          _infos = infoList;
      });
      await getApps();
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AppTime'),
          backgroundColor: Color(0xFF4D51BD),
        ),


        body: Builder(
            builder: (context) {
             if(_page ==1 ){
               return homescreen(list_apps,_apps);
             }
             else if(_page == 3){
               return accountinfo(isEditing: false,);
             }
             else{
               return homescreen(list_apps,_apps);
             }
            },
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          items: <Widget>[
            Icon(Icons.home, size: 30,color: Colors.white,),
            Icon(Icons.app_blocking, size: 30,color: Colors.white,),
            Icon(Icons.analytics, size: 30,color: Colors.white,),
            Icon(Icons.person, size: 30,color: Colors.white,),
          ],
          // height: 70.0,

          color: Color(0xFF4D51BD),
          buttonBackgroundColor:Color(0xFF07335C),
          backgroundColor: Colors.white,
          animationDuration: Duration(microseconds: 4),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        ),


    );
  }
}


class homescreen extends StatelessWidget {

  List<Apps> appsList = [];
  List apps=[];
  homescreen(this.appsList,this.apps);
  @override

  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return PageView(

        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        scrollDirection: Axis.horizontal,
        controller: controller,
        children:  <Widget>[

          Center(
            child: ListView.builder(
                itemCount: appsList.length,
                itemBuilder: (context, index) {
                  if(appsList.length != 0) {
                      return ListTile(
                        leading:  Image.memory(appsList[index].images,fit: BoxFit.contain,width: 40,height: 50,),
                        title: Text(appsList[index].appName),
                        trailing: Text(appsList[index].appUsage),
                        
                      );
                    
                  }
                  else{
                    return Center(child:Text("Hurray!! No app used"));
                  }
                  }
                     )
          ),
          Center(
            child:PieChartPage(_infos,_apps),
          ),
          Center(
            child: BarChartSample1(),
          )
        ],
    );
  }
}
