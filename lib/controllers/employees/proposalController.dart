import 'dart:convert';
import 'package:cdo_hiring_app/controllers/account/accountController.dart';
import 'package:cdo_hiring_app/controllers/global.dart';
import 'package:cdo_hiring_app/helpers/parseDate.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProposalEmployeeController extends GetxController {
  final _accountController = Get.find<AccountController>();
  RxList proposals = [].obs;
  RxBool isLoading = true.obs;

  post({
    required String employerUid,
    required String leadingTitle,
    required String employeeContactNo,
    required String companyAddress,
    required String companyName,
    required String coverLetter,
  }) async {
    try {
      await http.post(Uri.parse(baseUrl + "/api/create/employer/proposal"), body: {
        "uid": "${_accountController.userObj!.id}",
        "dateSubmitted": await parseDateToString(),
        "employerUid": "$employerUid",
        "companyName": "$companyName",
        "leadingTitle": "$leadingTitle",
        "employeePhotoUrl": "${_accountController.userObj!.photoUrl}",
        "employeeContactNo": "$employeeContactNo",
        "employeeEmailAddress": "${_accountController.userObj!.email}",
        "employeeFirstName": "${_accountController.userObj!.displayName}",
        "employeeLastName": "None",
        "employeeAddress": "Cagayan de Oro, Philippines",
        "coverLetter": "$coverLetter",
        "isApproved": "false"
      });
      Get.back();
      Get.back();
      Get.back();
    } catch (e) {
      print("@post $e");
    }
  }

  fetchMyProposals() async {
    try {
      var result = await http.get(Uri.parse(
        baseUrl + "api/get/employee/proposal/${_accountController.userObj!.id}",
      ));
      if (result.statusCode == 200) {
        var data = jsonDecode(result.body);
        proposals.value = data;
        proposals.refresh();
        isLoading.value = false;
      }
    } catch (e) {
      print("@fetchMyProposals $e");
      isLoading.value = false;
    }
  }

  clearProposalData() {
    proposals.value = [];
    proposals.refresh();
  }
}
