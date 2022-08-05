// To parse this JSON data, do
//
//     final video = videoFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Videolist {
  Videolist({
    required this.videodata,
  });

  List<Videodata> videodata;

  factory Videolist.fromJson(String str) => Videolist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Videolist.fromMap(js) => Videolist(
        videodata: List<Videodata>.from(
            js.map((x) => Videodata.fromJson(json.encode(x)))),
      );

  Map<String, dynamic> toMap() => {
        "Videodata": List<dynamic>.from(videodata.map((x) => x.toMap())),
      };
}

class Videodata {
  Videodata({
    required this.uniqueId,
    required this.videoUrl,
    required this.videoName,
    required this.dateOfEvent,
    required this.typeOfEvent,
    required this.eventLocation,
    required this.uploadedBy,
  });

  String uniqueId;
  String videoUrl;
  String videoName;
  String dateOfEvent;
  String typeOfEvent;
  String eventLocation;
  String uploadedBy;

  factory Videodata.fromJson(String str) => Videodata.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Videodata.fromMap(Map<String, dynamic> json) => Videodata(
        uniqueId: json["unique_id"],
        videoUrl: json["video_url"],
        videoName: json["video_name"],
        dateOfEvent: json["date_of_event"],
        typeOfEvent: json["type_of_event"],
        eventLocation: json["event_location"],
        uploadedBy: json["uploaded_by"],
      );

  Map<String, dynamic> toMap() => {
        "unique_id": uniqueId,
        "video_url": videoUrl,
        "video_name": videoName,
        "date_of_event": dateOfEvent,
        "type_of_event": typeOfEvent,
        "event_location": eventLocation,
        "uploaded_by": uploadedBy,
      };
}
