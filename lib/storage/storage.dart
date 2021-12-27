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