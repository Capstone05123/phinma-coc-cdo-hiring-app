import 'package:cdo_hiring_app/controllers/account/accountController.dart';
import 'package:cdo_hiring_app/preferences/account.dart';
import 'package:cdo_hiring_app/ui/colors.dart';
import 'package:cdo_hiring_app/ui/spinners.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenPreloadUserCredentials extends StatefulWidget {
  const ScreenPreloadUserCredentials({Key? key}) : super(key: key);

  @override
  _ScreenPreloadUserCredentialsState createState() => _ScreenPreloadUserCredentialsState();
}

class _ScreenPreloadUserCredentialsState extends State<ScreenPreloadUserCredentials> {
  final _accountController = Get.put(AccountController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _accountController.prefsReadUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: spinnerChasingDots(color: Color(0xFF64B5F6), size: 18.0),
        ),
      ),
    );
  }
}
