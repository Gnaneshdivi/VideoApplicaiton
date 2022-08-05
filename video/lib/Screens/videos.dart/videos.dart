import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video/Globals/globals.dart';
import 'package:video/Models/video.dart';
import 'package:video/Screens/videos.dart/upload.dart';
import 'package:video/utils/Filehandling.dart';
import 'package:video/utils/size_config.dart';
import 'package:video/API/videoapi.dart';

class VideoList extends StatefulWidget {
  const VideoList({Key? key}) : super(key: key);
  static const id = 'VideoList';

  @override
  State<VideoList> createState() => _VideoListState();
}

late Videodata vid = Videodata(
    videoUrl: '',
    videoName: '',
    dateOfEvent: '',
    typeOfEvent: '',
    eventLocation: '',
    uploadedBy: Globals.user.uniqueId,
    uniqueId: '');
String dropdownvalue = 'Low';

// List of items in our dropdown menu
var items = [
  'Low',
  'Medium',
  'High',
];
DateTime selectedDate = DateTime.now();

class _VideoListState extends State<VideoList> {
  bool upload = false;
  bool uploading = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        vid.dateOfEvent = '${selectedDate.day}/' '${selectedDate.month}/' +
            '${selectedDate.year}';
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(upload);
    print(uploading);
    return !uploading
        ? FutureBuilder<Object>(
            future: getvideos(),
            builder: (context, AsyncSnapshot snapshot) {
              print(snapshot.data);
              return snapshot.hasData
                  ? Stack(
                      children: [
                        Scaffold(
                          floatingActionButton: Globals.user.uploadPerm
                              ? FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10.0),
                                                        child: Text(
                                                          snapshot.data[i]
                                                              .videoName,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                              'Date : ' +
                                                                  snapshot
                                                                      .data[i]
                                                                      .dateOfEvent,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500))),
                                                      FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15.0),
                                                            child: Text(
                                                                'Type Of Event : ' +
                                                                    snapshot
                                                                        .data[i]
                                                                        .typeOfEvent,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth(context) * 0.2,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  Filem().decrept(
                                                      snapshot.data[i]);
                                                },
                                                icon: Icon(Icons.download))
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
                        upload
                            ? Container(
                                color: Colors.black.withOpacity(0.4),
                                child: Container(
                                  height: screenHeight(context),
                                  width: screenWidth(context),
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      height: screenHeight(context) * 0.6,
                                      width: screenWidth(context) * 0.6,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:
                                                  screenHeight(context) * 0.02,
                                            ),
                                            Text(
                                              'UPLOAD VIDEO',
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            SizedBox(
                                              height:
                                                  screenHeight(context) * 0.1,
                                            ),
                                            vid.videoUrl == ''
                                                ? InkWell(
                                                    onTap: () {
                                                      Filem.uploadfile()
                                                          .then(((value) {
                                                        setState(() {
                                                          vid.videoUrl = value;
                                                        });
                                                      }));
                                                    },
                                                    child: Container(
                                                      width:
                                                          screenWidth(context) *
                                                              0.4,
                                                      height: screenHeight(
                                                              context) *
                                                          0.2,
                                                      child: Center(
                                                          child: Text(
                                                              'Click here to Uplaod file')),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      Filem.uploadfile()
                                                          .then(((value) {
                                                        setState(() {
                                                          vid.videoUrl = value;
                                                        });
                                                      }));
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      width:
                                                          screenWidth(context) *
                                                              0.4,
                                                      height: screenHeight(
                                                              context) *
                                                          0.2,
                                                      child: Center(
                                                          child: Text(
                                                        'uploaded file from '
                                                        '${vid.videoUrl}',
                                                        softWrap: true,
                                                      )),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.green[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                  ),
                                            SizedBox(
                                              height:
                                                  screenHeight(context) * 0.05,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text('Video Quality'),
                                                DropdownButton(
                                                  // Initial Value
                                                  value: dropdownvalue,

                                                  // Down Arrow Icon
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down),

                                                  // Array list of items
                                                  items:
                                                      items.map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(items),
                                                    );
                                                  }).toList(),
                                                  // After selecting the desired option,it will
                                                  // change button value to selected value
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      dropdownvalue = newValue!;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              width:
                                                  screenWidth(context) * 0.35,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  icon: Icon(Icons.edit),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red)),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                                  labelText: 'Video Name',
                                                ),
                                                onChanged: (text) {
                                                  setState(() {
                                                    vid.videoName = text;
                                                    //you can access nameController in its scope to get
                                                    // the value of text entered as shown below
                                                    //fullName = nameController.text;
                                                  });
                                                },
                                              ),
                                            ),
                                            InkWell(
                                              onTap: (() =>
                                                  _selectDate(context)),
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                width:
                                                    screenWidth(context) * 0.35,
                                                child: TextField(
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    enabled: false,
                                                    icon: Icon(Icons
                                                        .date_range_rounded),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red)),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                    labelText: '${selectedDate.day}/'
                                                            '${selectedDate.month}/' +
                                                        '${selectedDate.year}',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              width:
                                                  screenWidth(context) * 0.35,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  icon: Icon(Icons.note_alt),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red)),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                                  labelText: 'Type Of Event',
                                                ),
                                                onChanged: (text) {
                                                  setState(() {
                                                    vid.typeOfEvent = text;
                                                    //you can access nameController in its scope to get
                                                    // the value of text entered as shown below
                                                    //fullName = nameController.text;
                                                  });
                                                },
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              width:
                                                  screenWidth(context) * 0.35,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  icon: Icon(
                                                      Icons.pin_drop_outlined),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red)),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                                  labelText: 'Place Of Event',
                                                ),
                                                onChanged: (text) {
                                                  setState(() {
                                                    vid.eventLocation = text;

                                                    //you can access nameController in its scope to get
                                                    // the value of text entered as shown below
                                                    //fullName = nameController.text;
                                                  });
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  screenHeight(context) * 0.05,
                                            ),
                                            Container(
                                              width:
                                                  screenWidth(context) * 0.35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          upload = false;
                                                          vid = Videodata(
                                                              uniqueId: '',
                                                              videoUrl: '',
                                                              videoName: '',
                                                              dateOfEvent: '',
                                                              typeOfEvent: '',
                                                              eventLocation: '',
                                                              uploadedBy: Globals
                                                                  .user
                                                                  .uniqueId);
                                                        });
                                                      },
                                                      child: Text('Discard'),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .redAccent))),
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        setState(() {
                                                          setState(() {
                                                            uploading = true;
                                                          });
                                                        });

                                                        print(uploading);
                                                        await savevideo(vid)
                                                            .then((value) {
                                                          setState(() {
                                                            uploading = false;

                                                            upload = false;
                                                            vid = Videodata(
                                                                uniqueId: '',
                                                                videoUrl: '',
                                                                videoName: '',
                                                                dateOfEvent: '',
                                                                typeOfEvent: '',
                                                                eventLocation:
                                                                    '',
                                                                uploadedBy: Globals
                                                                    .user
                                                                    .uniqueId);
                                                          });
                                                        });
                                                      },
                                                      child: Text('Save'),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      Colors
                                                                          .blue))),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  screenHeight(context) * 0.1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            : Container(),
                        upload
                            ? Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        uploading = false;

                                        upload = false;
                                        vid = Videodata(
                                            uniqueId: '',
                                            videoUrl: '',
                                            videoName: '',
                                            dateOfEvent: '',
                                            typeOfEvent: '',
                                            eventLocation: '',
                                            uploadedBy: Globals.user.uniqueId);
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
            })
        : Scaffold(
            body: Center(
            child: Image.asset('assets/upload.gif'),
          ));
  }
}
