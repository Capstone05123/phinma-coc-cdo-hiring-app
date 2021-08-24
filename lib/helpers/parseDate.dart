import 'dart:convert';

import 'package:jiffy/jiffy.dart';
import 'package:http/http.dart' as http;

parseDateToString() async {
  var value;
  //var date = DateTime.parse(value);
  //http://worldtimeapi.org/api/timezone/Asia/Manila
  var response = await http.get(
    Uri.parse("http://worldtimeapi.org/api/timezone/Asia/Manila"),
  );
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var date = DateTime.parse(data["utc_datetime"]).toLocal();
    value = Jiffy({
      "year": date.year,
      "month": date.month,
      "day": date.day,
      "hour": date.hour,
    }).yMMMMEEEEdjm;
    return value;
  }
}
