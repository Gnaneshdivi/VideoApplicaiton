import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:video/Models/models.dart';

class Globals {
  const Globals._();

  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static User user = User(
      uniqueId: '',
      email: '',
      password: '',
      device1: '',
      device2: '',
      sharePerm: false,
      uploadPerm: false,
      accessLevel: 2);
}
