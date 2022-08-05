import 'package:meta/meta.dart';
import 'dart:convert';

class Access {
  Access({
    required this.uniqueId,
    required this.mainUser,
    required this.subUsers,
  });

  String uniqueId;
  String mainUser;
  List<String> subUsers;

  factory Access.fromJson(String str) => Access.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Access.fromMap(Map<String, dynamic> json) => Access(
        uniqueId: json["unique_id"],
        mainUser: json["main_user"],
        subUsers: List<String>.from(json["sub_users"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "unique_id": uniqueId,
        "main_user": mainUser,
        "sub_users": List<dynamic>.from(subUsers.map((x) => x)),
      };
}
