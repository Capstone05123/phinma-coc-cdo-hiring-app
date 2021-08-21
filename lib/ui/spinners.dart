import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget spinnerRotatingCircle({required double size, required Color color}) {
  return SpinKitRotatingCircle(
    color: color,
    size: size,
  );
}

Widget spinnerChasingDots({required double size, required Color color}) {
  return SpinKitChasingDots(
    color: color,
    size: size,
  );
}
