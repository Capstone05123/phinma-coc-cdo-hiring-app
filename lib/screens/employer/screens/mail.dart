import 'package:flutter/material.dart';

class PageMail extends StatefulWidget {
  const PageMail({Key? key}) : super(key: key);

  @override
  _PageMailState createState() => _PageMailState();
}

class _PageMailState extends State<PageMail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Center(
            child: Text("Mail page"),
          ),
        ),
      ),
    );
  }
}
