import 'dart:convert';

import 'package:apptime/storage/UsersModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class UserSecureStorage{
      static final _storage=FlutterSecureStorage();
      static const _keyJwt='Jwt';
       Future setJwt(String jwt)async{
        return await _storage.write(key: _keyJwt, value: jwt);
      }
       Future<String> getJwt()async{
        return await _storage.read(key: _keyJwt);
      }
       Future deleteAll()async{
        return await _storage.deleteAll();
      }

}