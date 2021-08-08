import 'dart:convert';

import 'package:apptime/storage/UsersModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class UserSecureStorage{
      static final _storage=FlutterSecureStorage();
      static const _keyUsername='username';
      static const _keyEmail='email';
      static const _keyPassword='password';
      static const _keyStatus='status';
      static Future setUsername(String username)async{
         return await _storage.write(key: _keyUsername, value: username);
      }
      static Future<String> getUsername()async{
        return await _storage.read(key: _keyUsername);
      }
      static Future setEmail(String email)async{
        return await _storage.write(key: _keyEmail, value: email);
      }
      static Future<String> getEmail()async{
        return await _storage.read(key: _keyEmail);
      }

      static Future setPassword(String password)async{
        return await _storage.write(key: _keyPassword, value: password);
      }
      static Future<String> getPassword()async{
        return await _storage.read(key: _keyPassword);
      }
      static Future setStatus(String status)async{
        return await _storage.write(key: _keyStatus, value: status);
      }
      static Future<String> getStatus()async{
        return await _storage.read(key: _keyStatus);
      }
      static Future deleteAll()async{
        return await _storage.deleteAll();
      }

}