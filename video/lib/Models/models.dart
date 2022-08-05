// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class User {
  User({
    required this.uniqueId,
    required this.email,
    required this.password,
    required this.device1,
    required this.device2,
    required this.sharePerm,
    required this.uploadPerm,
    required this.accessLevel,
  });

  String uniqueId;
  String email;
  String password;
  String device1;
  String device2;
  bool sharePerm;
  bool uploadPerm;
  int accessLevel;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        uniqueId: json["unique_id"],
        email: json["email"],
        password: json["password"],
        device1: json["device1"],
        device2: json["device2"],
        sharePerm: json["share_perm"],
        uploadPerm: json["upload_perm"],
        accessLevel: json["access_level"],
      );

  Map<String, dynamic> toMap() => {
        "unique_id": uniqueId,
        "email": email,
        "password": password,
        "device1": device1,
        "device2": device2,
        "share_perm": sharePerm,
        "upload_perm": uploadPerm,
        "access_level": accessLevel,
      };
}
