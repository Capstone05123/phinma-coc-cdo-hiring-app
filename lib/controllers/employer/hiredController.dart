import 'dart:convert';
import 'package:cdo_hiring_app/controllers/account/accountController.dart';
import 'package:cdo_hiring_app/controllers/global.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HiredController extends GetxController {
  final _accountController = Get.find<AccountController>();
  RxList hired = [].obs;
  RxBool isLoading = true.obs;
  post({
    required String employeeUid,
    required String employerUid,
    required String photoUrl,
    required String firstName,
    required String lastName,
    required String address,
    required String emailAddress,
    required String contactNo,
  }) async {
    try {
      await http.post(Uri.parse(baseUrl + "api/create/employer/hired"), body: {
        "employeeUid": "$employeeUid",
        "employerUid": "$employerUid",
        "employeeApproved": "true",
        "employeePhotoUrl": "$photoUrl",
        "employeeFirstName": "$firstName",
        "employeeLastName": "$lastName",
        "employeelAddress": "$address",
        "employeeEmailAddress": "$emailAddress",
        "employeeEmailContactNo": "$contactNo"
      });
    } catch (e) {
      print("@futurePostHired $e");
    }
  }

  fetchHiredPeople() async {
    try {
      var result = await http.get(Uri.parse(
        baseUrl + "api/create/employer/hired/${_accountController.userObj!.id}",
      ));
      if (result.statusCode == 200) {
        var data = jsonDecode(result.body);
        hired.value = data;
        hired.refresh();
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;

      print("@fetchHiredPeople $e");
    }
  }
}
