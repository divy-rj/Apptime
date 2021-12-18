import 'dart:convert';

import 'package:apptime/storage/UsersModel.dart';
import 'package:apptime/storage/securestorage.dart';
import 'package:apptime/storage/storage.dart';
import 'package:http/http.dart' as http;
import 'package:objectid/objectid.dart';
const baseUrl='https://apptime10.herokuapp.com/';
class Services{
  Shared_Prefs shared_prefs=Shared_Prefs();
  UserSecureStorage userSecureStorage=UserSecureStorage();
  Future<int> createUser(String name,String email,String password)async{
    try {
      var response = await http.post(Uri.parse("${baseUrl}user/register"), body:jsonEncode(<String, String> {
        "name": name,
        "email": email,
        "password": password
      }),headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);
      print(response.body.runtimeType);
      if(response.statusCode == 200) {
        print(response.body);
        shared_prefs.saveUsersInfo(name, email, password);
        print(shared_prefs.getUsersInfo());
      }
      return response.statusCode;
    }catch(e){
      print(e);
      return -1;
    }

  }
  Future<int> loginUser(Users users)async {
    try {
      var response = await http.post(
        Uri.parse("${baseUrl}user/authentication"),
        body: jsonEncode(<String, String>{
          "email": users.email,
          "password": users.password
        }), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);
      shared_prefs.saveUsersInfo(users.name, users.email, users.password,);
      await userSecureStorage.setJwt(response.body.toString());
      print(response.body.toString());
      print(response.statusCode);
      return response.statusCode;
    }
    catch (e) {
      print(e);
      return -1;
    }
  }
  Future<int> updateUser(String Old_email,Users user)async{
    try{
      var response=await http.patch(
          Uri.parse("${baseUrl}user/update"),
          body:jsonEncode(<String,String>{
            "old_email":Old_email,
            "name": user.name,
            "email": user.email,
            "password": user.password
          }), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',

      },);
      if(response.statusCode == 200) {
        shared_prefs.saveUsersInfo(user.name, user.email, user.password);
        print(shared_prefs.getUsersInfo());
      }
      print(response.statusCode);
      return response.statusCode;
    } catch(e){
      print(e);
      return -1;
    }       
  }
  Future<int> deleteUser(String email)async{
    try{
      var response=await http.delete(Uri.parse('${baseUrl}user/delete'),body:jsonEncode(<String,String>{
        "email": email,
      }), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',});
        print(response.statusCode);
        return response.statusCode;
    } catch(e){
      print(e);
      return -1;
    }
  }
}