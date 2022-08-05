import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video/Globals/globals.dart';
import 'package:video/Models/video.dart';
import 'package:video/Screens/videos.dart/upload.dart';
import 'package:video/utils/Filehandling.dart';
import 'package:video/API/cropedapi.dart';
import 'package:video/utils/size_config.dart';
import 'package:video/API/videoapi.dart';

class CropedList extends StatefulWidget {
  const CropedList({Key? key}) : super(key: key);
  static const id = 'VideoList';

  @override
  State<CropedList> createState() => _CropedListState();
}

bool upload = false;

class _CropedListState extends State<CropedList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: get_croped_video(),
        builder: (context, AsyncSnapshot snapshot) {
          print('got');
          print(snapshot.data);
          return snapshot.hasData
              ? Stack(
                  children: [
                    Scaffold(
                      floatingActionButton: Globals.user.uploadPerm
                          ? FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              height: screenHeight(context) * 0.1,
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
                                  upload = true;
                                });
                              },
                              child: Icon(
                                Icons.file_upload,
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                      backgroundColor: Colors.white,
                      body: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15),
                                child: Container(
                                  height: screenHeight(context) * .1,
                                  child: Container(
                                    height: screenHeight(context) * 0.09,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 50.0),
                                          child: Container(
                                              child: Image.asset(
                                            'assets/tb.png',
                                          )),
                                        ),
                                        FittedBox(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10.0),
                                                    child: Text(
                                                      snapshot
                                                          .data[i].videoName,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        snapshot.data[i]
                                                            .dateOfEvent,
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                  FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    15.0),
                                                        child: Text(
                                                          snapshot.data[i]
                                                              .typeOfEvent,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ],
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
                      ),
                    ),
                    upload ? Uploadpane() : Container(),
                    upload
                        ? Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    upload = false;
                                  });
                                },
                                icon: Icon(Icons.close)),
                          )
                        : Container()
                  ],
                )
              : Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
        });
  }
}
