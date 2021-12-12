import 'package:app_usage/app_usage.dart';
import 'package:apptime/storage/App_Db.dart';
import 'package:apptime/storage/UsersModel.dart';
import 'package:apptime/storage/app_list.dart';
import 'package:apptime/storage/storage.dart';
import 'package:apptime/widget/getusage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/home_screen.dart';
import 'Screens/splashScreen.dart';
import 'package:workmanager/workmanager.dart';

import 'Services/httpService.dart';
const myTask="syncDatabase";
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
        } catch (e) {
          print(e);
          return Future.error(e);
        }
        List<App>  app_sent=[];
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print('Running on ${androidInfo.device}');
        List apps = await DeviceApps.getInstalledApplications(onlyAppsWithLaunchIntent: true,
            includeAppIcons: true, includeSystemApps: true);
        List<AppUsageInfo> infoList = await getUsageStats(0);
        app_sent=await GetApps().getApps_sent(infoList, apps);
        Data data=Data(email: users.email,dateTime: DateTime.now(),
            apps: app_sent,deviceName: androidInfo.model);
        // shared_prefs.saveData(app_sent,androidInfo.device,users.email);
        // print("here123");
        // Data d=Data();
        // d=shared_prefs.getData() as Data;
        // print(d);
      }
      print("${DateTime.now()}Ended data sending1");

      return Future.value(true);
    });

    // }
    //     catch(e){
    //   print(e);
    // }
    //

    print("Ended data sending2");
  // }
  // else{
  //   print("Not loggedin");
  // }
}

void main()  {
  // Enable integration testing with the Flutter Driver extension.
  // See https://flutter.io/testing/ for more info. ]
  // try {
    WidgetsFlutterBinding.ensureInitialized();
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    Workmanager().registerPeriodicTask(
        "2", myTask, frequency: Duration(minutes: 15), constraints: Constraints(
      networkType: NetworkType.connected,));

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

      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}



