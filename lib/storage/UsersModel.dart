import 'package:flutter/cupertino.dart';

class Users{
  final String name;
  final String email;
  final String password;
  final int id;
  Users( {
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.password,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json["name"],
      email: json["email"],
      password: json["password"],
      id: int.parse(json["id"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "email": this.email,
      "password": this.password,
      "id": this.id,
    };
  }
//

}