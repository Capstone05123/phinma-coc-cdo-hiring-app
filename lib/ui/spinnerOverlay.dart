import 'package:cdo_hiring_app/ui/spinners.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void toggleOverlay({required BuildContext context}) {
  Alert(
    context: context,
    title: "",
    buttons: [],
    content: SizedBox(child: spinnerChasingDots(color: Color(0xFF64B5F6), size: 24.0)),
    style: AlertStyle(
      isOverlayTapDismiss: false,
      titleStyle: TextStyle(height: 0),
      isCloseButton: false,
      backgroundColor: Colors.white.withOpacity(0.9),
      overlayColor: Colors.white.withOpacity(0.9),
      alertElevation: 0,
      alertBorder: Border(
        top: BorderSide.none,
        bottom: BorderSide.none,
        left: BorderSide.none,
        right: BorderSide.none,
      ),
      animationType: AnimationType.grow,
    ),
  ).show();
}
