import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video/Globals/apiurls.dart';
import 'package:video/Globals/globals.dart';
import 'package:video/Globals/urls.dart';
import 'package:video/Models/video.dart';
import 'package:video/utils/Filehandling.dart';

Future<List<Videodata>> getvideos() async {
  var aa;
  await httpcall().get(read_videos + '${Globals.user.uniqueId}').then((value) {
    print('getvideos');
    try {
      aa = Videolist.fromJson(value);
    } catch (v) {}
  });
  return aa == null ? [] : aa.videodata;
  // return [
  //   Videodata.fromMap({
  //     "unique_id": "4175f4f7cdfe4d48875d2a1244e7a0f9",
  //     "video_url":
  //         "/Volumes/Macintosh HD - Data/Users/divignanesh/Downloads/video.mp4",
  //     "video_name": "ev",
  //     "date_of_event": "",
  //     "type_of_event": "s",
  //     "event_location": "asd",
  //     "uploaded_by": "33b627a84cdd44388475a7200234a376"
  //   })
  // ];
}

Future<dynamic> savevideo(Videodata vid) async {
  print(vid.toJson());
  print('saving video process initited');
  if (vid.dateOfEvent != '' &&
      vid.eventLocation != '' &&
      vid.typeOfEvent != '' &&
      vid.uploadedBy != '' &&
      vid.videoName != '' &&
      vid.videoUrl != '') {
    await Filem().save(vid).then((value) {
      httpcall().post(upload_video, value.toJson());
      print('videosaved');
      return value;
    });
  } else {
    Globals.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        backgroundColor: Colors.yellowAccent,
        duration: Duration(seconds: 1),
        content: Text('Fill all the required details')));
  }

  return '';
}
