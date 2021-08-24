import 'package:cdo_hiring_app/controllers/account/accountController.dart';
import 'package:cdo_hiring_app/screens/account/password/password.dart';
import 'package:cdo_hiring_app/screens/account/username/username.dart';
import 'package:cdo_hiring_app/ui/colors.dart';
import 'package:cdo_hiring_app/ui/spinnerOverlay.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';

class ScreenSignIn extends StatefulWidget {
  const ScreenSignIn({Key? key}) : super(key: key);

  @override
  _ScreenSignInState createState() => _ScreenSignInState();
}

class _ScreenSignInState extends State<ScreenSignIn> {
  final _accountController = Get.put(AccountController());

  TextEditingController _usernameController = TextEditingController();
  FocusNode _usernameFocusNode = FocusNode();

  TextEditingController _passwordController = TextEditingController();
  FocusNode _passwordFocusNode = FocusNode();

  _handleSignInUsingGoogle() {
    _accountController.signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            Spacer(),
            Container(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jobhunter",
                    style: GoogleFonts.rancho(
                      color: Colors.black87,
                      fontSize: 55.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Take your career to",
                    style: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "the next level",
                    style: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(flex: 5),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.all(15.0),

                //primary: Colors.blue[300],
                // side: BorderSide(width: 0.5, color: blue),
              ),
              onPressed: () => _handleSignInUsingGoogle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Log in with google",
                    style: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Icon(
                    LineIcons.googleLogo,
                    size: 14,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                "After you sign in with your Google Account you’ll be offered two options between employer and employee, Google account must be active and valid",
                style: GoogleFonts.roboto(
                  color: Colors.black54,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300,
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
