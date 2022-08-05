import 'package:video/Globals/apiurls.dart';
import 'package:video/Globals/globals.dart';
import 'package:video/Globals/urls.dart';
import 'package:video/Models/access.dart';
import 'package:video/Models/models.dart';

Future<List<User>> getaccess() async {
  Access aa;
  List<User> abc = [];
  await httpcall()
      .get(get_access + '${Globals.user.uniqueId}')
      .then((value) async {
    print('get access');

    try {
      print(value);
      aa = Access.fromJson(value);
      for (int i = 0; i < aa.subUsers.length; i++) {
        print(aa.subUsers[i]);
        await httpcall().get(get_user_uid + '${aa.subUsers[i]}').then((value) {
          print(value);
          abc.add(User.fromJson(value));
        });
      }
    } catch (v) {}
  });
  print(abc);
  return abc;
}

update_permissions(User us) async {
  await httpcall()
      .put(update_user_uid + '${us.uniqueId}', us.toJson())
      .then((value) => print('user updated'));
}
