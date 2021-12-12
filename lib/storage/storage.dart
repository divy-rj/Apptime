import 'dart:convert';
import 'dart:typed_data';

import 'package:app_usage/app_usage.dart';
import 'package:apptime/storage/securestorage.dart';
import 'package:apptime/widget/getusage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'App_Db.dart';
import 'UsersModel.dart';
import 'app_list.dart';          
List<AppUsageInfo> _infos = [];
List<Application> _apps =  [];
List<Apps> list_apps=[];
class Shared_Prefs{
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
    _apps = apps;
  }
  void getUsage() async {
    try {
      List<AppUsageInfo> infoList = await getUsageStats(0);
      await getApp();
      _infos = infoList;
      await getApps();
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }
//   Future<void> saveData(List<App>list_apps,String device_info,String email) async {
//     DateTime dateTime;
//     dateTime=DateTime.now();
//     String app_u=jsonEncode(App.fromJson(list_apps));
//     listApps=App.
//   final Data data = Data(apps:list_apps,dateTime: dateTime,email: email,deviceName: device_info);
//   print("Sent $data");
//   Map decoded=jsonDecode(data.toString());
//   String user=jsonEncode(Data.fromMap(decoded));
//   print(user);
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool result = await prefs.setString('Data', jsonEncode(data));
//   print(result);
// }
// Future<Data> getData() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//
//   Map userMap = await jsonDecode(prefs.getString('Data'));
//   print(userMap);
//   var data = Data.fromMap(userMap);
//   return data;
// }
   Future<void> saveUsersInfo(String username,String email_id,String password) async {
    Users users = Users(email: email_id,name: username,password: password);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString('Users', jsonEncode(users));
    print(result);
  }
  setLoginStatus(bool isLogin)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("loginStatus",isLogin);
  }
  Future<bool> getLoginStatus()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool islogin =prefs.getBool("loginStatus") ?? false;
    return islogin;
  }
  Future<Users> getUsersInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> userMap;
    final String userStr = prefs.getString('Users');
    if (userStr != null) {
      userMap = jsonDecode(userStr) as Map<String, dynamic>;
    }

    if (userMap != null) {
      final Users users = Users.fromJson(userMap);
      print(users);
      return users;
    }
    return null;
  }
}