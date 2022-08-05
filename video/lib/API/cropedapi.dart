import 'package:video/Globals/globals.dart';
import 'package:video/Globals/urls.dart';
import 'package:video/Models/video.dart';
import 'package:video/utils/Filehandling.dart';

import '../Globals/apiurls.dart';

Future<List<Videodata>> get_croped_video() async {
  var aa;
  await httpcall()
      .get(read_cropped + '${Globals.user.uniqueId}')
      .then((value) async {
    print('cropped videos');
    try {
      aa = Videolist.fromJson(value);
    } catch (v) {}
  });

  return aa == null ? [] : aa.videodata;
}

Future savecropped(Videodata vid) async {
  await Filem().save(vid).then((value) {
    httpcall().post(upload_video, value.toJson());
    return value;
  });

  print('videouploaded');
}
