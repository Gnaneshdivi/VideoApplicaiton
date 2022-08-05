import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:aes_crypt/aes_crypt.dart';
import 'package:video/Globals/globals.dart';
import 'package:video/Models/video.dart';
import 'package:path/path.dart' as Path;

import 'package:path_provider/path_provider.dart';

class Filem {
  static Future<String> uploadfile() async {
    print('Uplaod file');

    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.video, allowMultiple: false);
    if (result != null) {
      String file = result.files.first.path.toString();
      print(file);
      return file;
    } else {
      // User canceled the picker
    }
    return '';
  }

  Future encript(Videodata vid) async {
    print(DateTime.now());
    Videodata l = vid;
    var crypt = AesCrypt();
    crypt.setPassword('videoencryption');
    crypt.setOverwriteMode(AesCryptOwMode.rename);
    await crypt.encryptFileSync(vid.videoUrl, '${vid.videoName}.aes');

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    print(appDocDir);
    l.videoUrl = appDocPath + '/${vid.videoName}.aes';
    return l;
  }

  decrept(Videodata vid) async {
    var crypt = AesCrypt();
    crypt.setPassword('videoencryption');
    Directory appDocDir = await getTemporaryDirectory();
    print(appDocDir.path);
    String appDocPath = appDocDir.path;
    await crypt.decryptFileSync(
        vid.videoUrl, '/Users/divignanesh/downloads/' + '${vid.videoName}.mp4');
    print('decrepted' + '${vid.videoName}.mp4');
  }

  Future<Videodata> save(Videodata l) async {
    late Videodata vid;

    await encript(l).then((value) {
      vid = value;
      print(DateTime.now());
    });

    return vid;
  }
}
