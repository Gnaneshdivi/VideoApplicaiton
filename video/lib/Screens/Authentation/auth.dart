import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video/Screens/Home_Screen/homescreen.dart';

import 'package:video/main.dart';
import 'package:video/API/authfunctions.dart';
import 'package:video/Globals/globals.dart';
import 'package:video/utils/helpers.dart';
import 'package:video/utils/size_config.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);
  static const id = 'AuthenticationScreen';

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

String? validateemail(String value) {
  if ((value.contains('@')) && value.isNotEmpty) {
    return "Improper mail id";
  }
  return null;
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var mailid;
  var password;
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            Container(
              height: screenHeight(context),
              width: screenWidth(context) * 0.45,
              decoration: BoxDecoration(
                  color: Colors.black87,
                  image: DecorationImage(
                      image: AssetImage('assets/cam.jpg'), fit: BoxFit.cover)),
            ),
            Container(
              height: screenHeight(context),
              width: screenWidth(context) * 0.55,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        width: screenWidth(context) * 0.2,
                        child: Image.asset('assets/kadi.png')),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                      width: screenWidth(context) * 0.3,
                      child: Row(
                        children: [
                          Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.black, fontSize: 40),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: screenWidth(context) * 0.3,
                      child: TextField(
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelText: 'Mail ID',
                        ),
                        onChanged: (text) {
                          setState(() {
                            mailid = text;
                            //you can access nameController in its scope to get
                            // the value of text entered as shown below
                            //fullName = nameController.text;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: screenWidth(context) * 0.3,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelText: 'Password',
                        ),
                        onChanged: (text) {
                          setState(() {
                            password = text;
                            //you can access nameController in its scope to get
                            // the value of text entered as shown below
                            //fullName = nameController.text;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 30),
                      width: screenWidth(context) * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ignore: deprecated_member_use
                          FlatButton(
                            height: 50,
                            minWidth: 100,
                            onPressed: () {
                              if (mailid != null &&
                                  password != null &&
                                  mailid.toString().contains('@')) {
                                login(mailid, password).then((value) {
                                  if (value != null) {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      HomeScreen.id,
                                    );
                                  }
                                });
                              } else {
                                Globals.scaffoldMessengerKey.currentState!
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        duration: Duration(seconds: 1),
                                        content:
                                            Text('Verify Email and password')));
                              }
                            },
                            color: Colors.black,
                            child: const Text(
                              "SUBMIT",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ],
        ));
  }
}
