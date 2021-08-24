import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ScreenReplyTemplates extends StatefulWidget {
  const ScreenReplyTemplates({Key? key}) : super(key: key);

  @override
  _ScreenReplyTemplatesState createState() => _ScreenReplyTemplatesState();
}

class _ScreenReplyTemplatesState extends State<ScreenReplyTemplates> {
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
