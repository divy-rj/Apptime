import 'package:flutter/cupertino.dart';

import 'app_list.dart';

class Users{
  final String name;
  final String email;
  final String password;
  Users( {
    @required this.name,
    @required this.email,
    @required this.password,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json["name"],
      email: json["email"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "email": this.email,
      "password": this.password,
    };
  }

  @override
  String toString() {
    return '"Users":{name: $name, email: $email, password: $password}';
  }
//

}
