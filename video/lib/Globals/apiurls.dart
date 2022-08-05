import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video/Models/models.dart';
import 'package:video/Globals/globals.dart';

class httpcall {
  Future<dynamic> post(url, body) async {
    var u = Uri.parse(url);

    var kk = await http.post(u,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);

    return kk.body;
  }

  Future<dynamic> put(url, body) async {
    var u = Uri.parse(url);

    var kk = await http.put(u,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);

    return kk.body;
  }

  Future<dynamic> get(url) async {
    var u = Uri.parse(url);
    var kk = await http.get(
      u,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return kk.body;
  }
}
