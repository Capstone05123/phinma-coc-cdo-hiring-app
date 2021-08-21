import 'package:shared_preferences/shared_preferences.dart';

Future loadUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? id = prefs.getString("userId");
  return id;
}
