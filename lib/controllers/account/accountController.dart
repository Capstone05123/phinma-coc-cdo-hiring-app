import 'dart:convert';
import 'package:cdo_hiring_app/controllers/employees/feedController.dart';
import 'package:cdo_hiring_app/controllers/employees/proposalController.dart';
import 'package:cdo_hiring_app/controllers/global.dart';
import 'package:cdo_hiring_app/preferences/account.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class AccountController extends GetxController {
  String accountId = "";
  RxBool isLoading = false.obs;
  bool _isLoggedIn = false;

  GoogleSignInAccount? userObj;
  GoogleSignIn _exec = GoogleSignIn();

  userGoogleName() {
    if (userObj!.displayName!.split(" ").length > 1) {
      return userObj!.displayName!.split(" ").sublist(0, 2).join(" ");
    }
    return userObj!.displayName;
  }

  prefsReadUserId() async {
    try {
      var prefsUserId = await loadUserId();
      if (prefsUserId == null) {
        print("UserId is empty");
        Get.toNamed("/sign-in");
      }
      return prefsUserId;
    } catch (e) {
      print("Catch exeption @prefsReadUserId");
    }
  }

  //

  signOutGoogle() {
    _exec.signOut();
    accountId = "";
    userObj = null;

    Get.toNamed("/sign-in");
  }

  Future signInWithGoogle() async {
    try {
      _exec.signIn().then((data) async {
        userObj = data;
        if (userObj != null) {
          Get.toNamed("/global-spinner");
          // --- IF USER HAS SELECTED EMAIL
          var response = await http.post(Uri.parse(
            baseUrl + "TOKEN?username=${data?.email}&password=${data?.id}",
          ));
          // IF SUCCESS
          // GO TO ANOTHER ROUTE AND CHECK TYPE
          // EG. "EMPLOYEE" AND "EMPLOYER"
          if (response.statusCode == 200) {
            var _readUserType = await http.get(Uri.parse(
              baseUrl + "api/get/user-type/${data?.id}",
            ));
            var _userType = jsonDecode(_readUserType.body);
            redirectUser(userType: _userType["type"]);
          }
          // --- IF ACCOUNT IS NOT YET REGISTERED
          else if (response.statusCode == 400) {
            // --- IF USER/EMAIL IS NOT YET REGISTERED
            // --- POST ANOTHER REQUEST AS REGISTRATION
            await http.post(
              Uri.parse(baseUrl + "api/account/register"),
              body: {
                "userName": data?.email.toString(),
                "password": data?.id.toString(),
                "role": "none",
              },
            ).then((value) {
              if (value.statusCode == 200) {
                Get.toNamed("/type-selection", arguments: {
                  "email": data?.email.toString(),
                  "name": data?.displayName.toString(),
                  "password": data?.id.toString(),
                  "photoUrl": data?.photoUrl.toString(),
                });
              }
            });
          }
        }
      });
    } catch (e) {
      print("Catch exeption @signInWithGoogle");
    }
  }

  Future createProfile({required selectedValue}) async {
    try {
      var type = selectedValue.toString().toLowerCase();
      await http.post(
        Uri.parse(baseUrl + "api/create/user-type"),
        body: {
          "uid": userObj?.id.toString(),
          "type": type,
        },
      );
      redirectUser(userType: type);
    } catch (e) {
      print("Catch exeption @createProfile");
    }
  }

  // Refactored
  redirectUser({required String userType}) {
    if (userType == "employee") {
      Get.toNamed("/employee-main-screen");
    }
    if (userType == "employer") {
      Get.toNamed("/employer-main-screen");
    }
  }
}
