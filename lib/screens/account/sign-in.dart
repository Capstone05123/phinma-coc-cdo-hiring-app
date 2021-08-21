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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Spacer(flex: 5),
              Text(
                "Jobhunter",
                style: GoogleFonts.patrickHand(
                  color: Colors.black87,
                  fontSize: 44.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(flex: 5),
              textFieldUsername(
                textFieldController: _usernameController,
                textFieldFocusNode: _usernameFocusNode,
                hasError: false,
              ),
              SizedBox(height: 10.0),
              textFieldPassword(
                textFieldController: _passwordController,
                textFieldFocusNode: _passwordFocusNode,
                hasError: false,
              ),
              SizedBox(height: 10.0),
              Container(
                width: Get.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.all(15.0),
                    primary: Colors.blue[300],
                    // side: BorderSide(width: 0.5, color: blue),
                  ),
                  onPressed: () => _accountController.signOutGoogle(),
                  child: Text(
                    "Log in",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Divider(
                          color: Colors.black12,
                          height: 30,
                        )),
                  ),
                  Text(
                    "OR",
                    style: GoogleFonts.roboto(
                      color: Colors.black12,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Divider(
                          color: Colors.black12,
                          height: 30,
                        )),
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.all(15.0),
                  primary: Colors.blue[300],
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
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Icon(
                      LineIcons.googleLogo,
                      size: 14,
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
