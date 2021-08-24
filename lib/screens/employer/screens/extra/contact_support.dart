import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ScreenContactSupport extends StatefulWidget {
  const ScreenContactSupport({Key? key}) : super(key: key);

  @override
  _ScreenContactSupportState createState() => _ScreenContactSupportState();
}

class _ScreenContactSupportState extends State<ScreenContactSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leadingWidth: 0,
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Colors.black87),
        actions: [
          IconButton(onPressed: () => Get.back(), icon: Icon(LineIcons.times)),
        ],
        //iconTheme: IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}
