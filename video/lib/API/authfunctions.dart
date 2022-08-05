import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:video/Models/models.dart';
import 'package:video/Globals/globals.dart';
import 'package:video/Globals/urls.dart';

import '../Globals/apiurls.dart';

Future<String?> login(String mail, String password) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;

  Userlogin user = Userlogin(email: mail, password: password);
  var abc = await httpcall().post(login_url, user.toJson());
  try {
    User l = User.fromJson(abc);

    await prefs.setString('uid', l.uniqueId);
    Globals.user = l;
    print(Globals.user.uniqueId);
  } catch (v) {
    Globals.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
        content: Text('Incorrect Email ID and Password')));
  }
  if (prefs.getString('uid') == '') {
    return null;
  }

  return prefs.getString('uid');
}

Future<Userlogin> getuserdata(String uid) async {
  Userlogin k;
  var abc = await httpcall().get(get_uer_data + '$uid');

  return Userlogin.fromJson(abc);
}

class Userlogin {
  Userlogin({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory Userlogin.fromJson(String str) => Userlogin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Userlogin.fromMap(Map<String, dynamic> json) => Userlogin(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
      };
}
