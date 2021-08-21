import 'package:cdo_hiring_app/ui/spinners.dart';
import 'package:flutter/material.dart';

class ScreenGlobalSpinner extends StatelessWidget {
  const ScreenGlobalSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: spinnerChasingDots(
          color: Color(0xFF64B5F6),
          size: 18.0,
        ),
      ),
    );
  }
}
