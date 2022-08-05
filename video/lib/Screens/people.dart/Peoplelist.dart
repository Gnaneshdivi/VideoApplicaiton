import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video/API/peopleapi.dart';
import 'package:video/Models/models.dart';
import 'package:video/utils/size_config.dart';
import 'package:video/API/videoapi.dart';

class PeopleList extends StatefulWidget {
  const PeopleList({Key? key}) : super(key: key);
  static const id = 'PeopleList';

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  bool abc = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Object>(
          future: getaccess(),
          builder: (context, AsyncSnapshot snapshot) {
            print('get');
            print(snapshot.data);
            List<User> aa = snapshot.data;
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 15),
                            child: Container(
                              height: screenHeight(context) * .1,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                height: screenHeight(context) * 0.09,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: Image.asset(
                                      'assets/man.png',
                                    )),
                                    FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                    snapshot.data[i].email)),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                          'Upload permissions'),
                                                      CupertinoSwitch(
                                                          value:
                                                              aa[i].uploadPerm,
                                                          onChanged: (v) {
                                                            setState(() {
                                                              aa[i].uploadPerm =
                                                                  v;
                                                            });

                                                            update_permissions(
                                                                aa[i]);
                                                          })
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text('Share permissions'),
                                                      CupertinoSwitch(
                                                          value:
                                                              aa[i].sharePerm,
                                                          onChanged: (v) {
                                                            setState(() {
                                                              aa[i].sharePerm =
                                                                  v;
                                                            });

                                                            update_permissions(
                                                                aa[i]);
                                                          })
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox()
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 0.5,
                            color: Colors.black87,
                          )
                        ],
                      );
                    },
                  )
                : Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
          }),
    );
  }
}
