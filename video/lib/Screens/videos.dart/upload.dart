import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video/Globals/globals.dart';
import 'package:video/Models/video.dart';
import 'package:video/utils/Filehandling.dart';
import 'package:video/utils/size_config.dart';
import 'package:video/API/videoapi.dart';
import 'package:video/utils/videoplayer.dart';

class Uploadpane extends StatefulWidget {
  const Uploadpane({Key? key}) : super(key: key);

  @override
  State<Uploadpane> createState() => _UploadpaneState();
}

class _UploadpaneState extends State<Uploadpane> {
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
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
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            height: screenHeight(context) * 0.6,
            width: screenWidth(context) * 0.6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight(context) * 0.02,
                  ),
                  Text(
                    'UPLOAD VIDEO',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: screenHeight(context) * 0.1,
                  ),
                  vid.videoUrl == ''
                      ? InkWell(
                          onTap: () {
                            Filem.uploadfile().then(((value) {
                              setState(() {
                                vid.videoUrl = value;
                              });
                            }));
                          },
                          child: Container(
                            width: screenWidth(context) * 0.4,
                            height: screenHeight(context) * 0.2,
                            child: Center(
                                child: Text('Click here to Uplaod file')),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 1, color: Colors.green),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            Filem.uploadfile().then(((value) {
                              setState(() {
                                vid.videoUrl = value;
                              });
                            }));
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: screenWidth(context) * 0.4,
                            height: screenHeight(context) * 0.2,
                            child: Center(
                                child: Text(
                              'uploaded file from ' '${vid.videoUrl}',
                              softWrap: true,
                            )),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 1, color: Colors.green),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: screenHeight(context) * 0.05,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Video Quality'),
                      DropdownButton(
                        // Initial Value
                        value: dropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: screenWidth(context) * 0.35,
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.edit),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
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
                    onTap: (() => _selectDate(context)),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: screenWidth(context) * 0.35,
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          enabled: false,
                          icon: Icon(Icons.date_range_rounded),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelText:
                              '${selectedDate.day}/' '${selectedDate.month}/' +
                                  '${selectedDate.year}',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: screenWidth(context) * 0.35,
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.note_alt),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
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
                    width: screenWidth(context) * 0.35,
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.pin_drop_outlined),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
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
                    height: screenHeight(context) * 0.05,
                  ),
                  Container(
                    width: screenWidth(context) * 0.35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            child: Text('Discard'),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.redAccent))),
                        ElevatedButton(
                            onPressed: () {
                              savevideo(vid);
                            },
                            child: Text('Save'),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight(context) * 0.1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
