import 'package:cdo_hiring_app/controllers/global.dart';
import 'package:cdo_hiring_app/preferences/account.dart';
import 'package:cdo_hiring_app/ui/spinnerOverlay.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AccountController extends GetxController {
  RxBool isLoading = false.obs;
  bool _isLoggedIn = false;
  GoogleSignInAccount? _userObj;
  GoogleSignIn _exec = GoogleSignIn();

  prefsReadUserId() async {
    var prefsUserId = await loadUserId();
    if (prefsUserId == null) {
      print("UserId is empty");
      Get.toNamed("/sign-in");
    }
    return prefsUserId;
  }

  //

  signOutGoogle() {
    _exec.signOut();
  }

  Future signInWithGoogle() async {
    try {
      _exec.signIn().then((data) async {
        if (data?.email != null && data?.id != null) {
          Get.toNamed("/global-spinner");
          // --- IF USER HAS SELECTED EMAIL
          // --- ISLOADING SET TO TRUE
          var response = await http.post(Uri.parse(
            baseUrl + "TOKEN?username=${data?.email}&password=${data?.id}",
          ));
          // IF SUCCESS
          // GO TO ANOTHER ROUTE AND CHECK TYPE
          // EG. "EMPLOYEE" AND "EMPLOYER"
          if (response.statusCode == 200) {
            // --- IF LOGIN SUCCESS
            // --- SISLOADING SET TO FALSE
            // --- MUST PROCEED TO ANOTHER ROUTE
          }
          // --- IF ACCOUNT IS NOT YET REGISTERED
          else if (response.statusCode == 400) {
            // --- IF USER/EMAIL IS NOT YET REGISTER
            // --- POST ANOTHER REQUEST AS REGISTRATION
            await http.post(
              Uri.parse(baseUrl + "api/account/register"),
              body: {
                "userName": data?.email.toString(),
                "password": data?.id.toString(),
                "role": "string",
              },
            ).then((value) {
              if (value.statusCode == 200) {
                // -- IF SUCCESS SET IS LOADING TO FALSE
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
      Get.back();
    }
  }
}
