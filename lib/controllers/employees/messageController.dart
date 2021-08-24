import 'dart:convert';
import 'package:cdo_hiring_app/controllers/account/accountController.dart';
import 'package:cdo_hiring_app/controllers/global.dart';
import 'package:cdo_hiring_app/helpers/parseDate.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MessageController extends GetxController {
  final _accountController = Get.find<AccountController>();
  RxList messages = [].obs;
  RxBool isLoading = true.obs;

  post({
    required String employeeId,
    required String message,
    required String companyName,
    required String leadingTitle,
  }) async {
    try {
      await http.post(Uri.parse(baseUrl + "api/create/employer/message"), body: {
        "uid": "$employeeId",
        "date": await parseDateToString(),
        "status": "Letter approved",
        "message": "$message",
        "isOpened": "false",
        "companyName": "$companyName",
        "LeadingTitle": "$leadingTitle",
      });

      Get.back();
      Get.toNamed("/employer-main-screen");
    } catch (e) {
      print("@post $e");
    }
  }

  fetchMessages() async {
    try {
      var result = await http.get(Uri.parse(
        baseUrl + "api/get/employer/message/${_accountController.userObj!.id}",
      ));
      if (result.statusCode == 200) {
        var data = jsonDecode(result.body);
        messages.value = data;
        messages.refresh();
        isLoading.value = false;
      }

      print(result.body);
    } catch (e) {
      isLoading.value = false;

      print("@fetchMessages $e");
    }
  }

  deleteMessage(value) async {
    try {
      await http.delete(Uri.parse(baseUrl + "/api/remove/employer/message/$value"));
      await fetchMessages();
      Get.back();
    } catch (e) {
      print("@deleteMessage $e");
    }
  }
}
