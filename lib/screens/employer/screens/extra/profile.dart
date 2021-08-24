import 'package:cdo_hiring_app/controllers/account/accountController.dart';
import 'package:cdo_hiring_app/controllers/employer/profileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({Key? key}) : super(key: key);

  @override
  _ScreenProfileState createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  final _accountController = Get.find<AccountController>();
  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leadingWidth: 0,
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(LineIcons.times),
          ),
        ],
        //iconTheme: IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30.0),
              child: Hero(
                tag: _accountController.userObj!.photoUrl.toString(),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: Image.network(
                    _accountController.userObj!.photoUrl.toString(),
                    width: 200,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _profileController.profileObj["firstName"] + " " + _profileController.profileObj["lastName"],
                    style: GoogleFonts.roboto(
                      fontSize: 24.0,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LineIcons.mapMarker,
                        size: 13.0,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 3.0),
                      Text(
                        _profileController.profileObj["companyAddress"],
                        style: GoogleFonts.roboto(
                          fontSize: 16.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LineIcons.buildingAlt,
                        size: 13.0,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 3.0),
                      Text(
                        _profileController.profileObj["companyName"],
                        style: GoogleFonts.roboto(
                          fontSize: 14.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.all(15.0),

                  //primary: Colors.blue[300],
                  // side: BorderSide(width: 0.5, color: blue),
                ),
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Edit available after 30 days",
                      style: GoogleFonts.roboto(
                        color: Colors.black45,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Icon(
                      LineIcons.editAlt,
                      size: 14,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
