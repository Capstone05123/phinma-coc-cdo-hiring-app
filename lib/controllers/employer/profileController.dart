import 'dart:convert';

import 'package:cdo_hiring_app/controllers/account/accountController.dart';
import 'package:cdo_hiring_app/controllers/global.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final _accountController = Get.find<AccountController>();

  RxMap profileObj = {}.obs;

  post({
    required String firstName,
    required String lastName,
    required String companyAddress,
    required String companyName,
  }) async {
    try {
      await http.post(Uri.parse(baseUrl + "api/create/employer"), body: {
        "uid": "${_accountController.userObj!.id}",
        "accountType": "Employer",
        "firstName": "$firstName",
        "lastName": "$lastName",
        "companyAddress": "$companyAddress",
        "companyName": "$companyName",
        "isVisible": "true",
        "reports": "0",
      });
      Get.back();
      Get.back();
    } catch (e) {
      print("@post $e");
    }
  }

  Future fetchEmployerProfile() async {
    try {
      var result = await http.get(Uri.parse(baseUrl + "api/get/employer/${_accountController.userObj!.id}"));
      if (result.statusCode == 200) {
        var data = jsonDecode(result.body);
        profileObj.value = data;
        profileObj.refresh();
      }
      if (result.statusCode == 400) {
        Get.toNamed("/createprofile-view-screen");
      }
      return;
    } catch (e) {
      print("@fetchEmployerProfile $e");
    }
  }
}
