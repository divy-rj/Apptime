import 'package:app_usage/app_usage.dart';
import 'package:apptime/storage/App_Db.dart';
import 'package:apptime/storage/UsersModel.dart';
import 'package:apptime/storage/app_list.dart';
import 'package:apptime/storage/storage.dart';
import 'package:apptime/widget/getusage.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_apps/device_apps.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/home_screen.dart';
import 'Screens/splashScreen.dart';
import 'package:workmanager/workmanager.dart';

import 'Services/httpService.dart';
const myTask="syncDatabase";
const notificationTask="checkForNotification";
void callbackDispatcher()async{

  Shared_Prefs  shared_prefs= new Shared_Prefs();
  // SharedPreferences prefs = await SharedPreferences.getInstance();

  print("hi");
  Services services=Services();
  // var user=shared_prefs.getLoginStatus();
  // bool isLogin=await prefs.getBool("loginStatus")??false;
  // print(isLogin);

  // if(isLogin == true) {
      print("Here");
    Workmanager().executeTask((task, inputData) async {
      print("$task");
      print("$myTask");
      if (myTask.compareTo(task) >= 0) {
        print("huuu");

        Users users = await shared_prefs.getUsersInfo();
        bool isLogin= await shared_prefs.getLoginStatus()??false;
        print(isLogin);
        if(isLogin == false){
          print("Not logged In");
          return Future.value(false);
        }
        print("here::: $users");
        try {
          int status = await services.loginUser(users);
          print(status);
          return Future.value(true);
        } catch (e) {
          print(e);
          return Future.error(e);
        }

      }

      return Future.value(false);
    });

}

void main()  {
  // Enable integration testing with the Flutter Driver extension.
  // See https://flutter.io/testing/ for more info. ]
  // try {
  AwesomeNotifications awesome=new AwesomeNotifications();
  awesome.initialize(
      null,[
    NotificationChannel(
        channelKey:'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance:NotificationImportance.High,
        channelShowBadge: true
    )
  ]
  );
    WidgetsFlutterBinding.ensureInitialized();
    Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    Workmanager().registerPeriodicTask(
        "2", myTask, frequency: Duration(minutes:30), constraints: Constraints(
      networkType: NetworkType.connected,));
  Workmanager().registerPeriodicTask(
      "2", notificationTask, frequency: Duration(minutes: 15));

  // }catch(e){
  //   print("${DateTime.now()} \n $e");
  // }
  runApp(new MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      checkerboardRasterCacheImages: false,
      checkerboardOffscreenLayers: false,
      theme: ThemeData(
        primaryColor: Color(0xFF4D51BD), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF4D51BD),)
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}



