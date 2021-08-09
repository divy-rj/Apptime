import 'package:app_usage/app_usage.dart';
import 'package:apptime/storage/app_list.dart';
import 'package:apptime/storage/securestorage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../page/pie_chart_page.dart';
import '../widget/getusage.dart';
import '../page/bargraph.dart';
import 'acc_info.dart';
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
  List<Apps> getApps(){
      List<Apps> appsList=[];
      Apps listapp;
      for (var info in _infos) {
        for(var app in _apps) {
          if (info.appName != 'apptime' && info.packageName == app.packageName) {

            listapp=Apps(appName: app.appName,appUsage: info.usage.toString().substring(0, info.usage.toString().length-7));
            appsList.add(listapp);
          }
        }
      }
      list_apps=appsList;
  }
  void getUsage() async {
    try {
      List<AppUsageInfo> infoList = await getUsageStats(0);
      List<Application> apps = await DeviceApps.getInstalledApplications(onlyAppsWithLaunchIntent: true, includeAppIcons: true, includeSystemApps: true);
      setState(() {
          _infos = infoList;
                _apps = apps;
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
               return homescreen(list_apps);
             }
             else if(_page == 3){
               return accountinfo(isEditing: false,);
             }
             else{
               return homescreen(list_apps);
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

          color: Color(0xFF4D51BD),
          buttonBackgroundColor:Color(0xFF07335C),
          backgroundColor: Colors.white,

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

  List<Apps> appsList;
  homescreen(this.appsList);
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
                    return ListTile(
                        title: Text(appsList[index].appName),
                        trailing: Text(appsList[index].appUsage));
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
