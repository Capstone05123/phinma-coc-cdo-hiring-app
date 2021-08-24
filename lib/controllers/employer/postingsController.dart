import 'dart:convert';

import 'package:cdo_hiring_app/controllers/account/accountController.dart';
import 'package:cdo_hiring_app/controllers/employer/profileController.dart';
import 'package:cdo_hiring_app/controllers/global.dart';
import 'package:cdo_hiring_app/helpers/parseDate.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PostingsController extends GetxController {
  final _accountController = Get.find<AccountController>();
  final _profileController = Get.put(ProfileController());

  RxList postings = [].obs;
  RxBool isLoading = true.obs;

  Future post({
    required String title,
    required double salary,
    required String details,
    required String projectLength,
    required String experienceLevel,
  }) async {
    try {
      _profileController.fetchEmployerProfile().then((value) async {
        var _companyName = _profileController.profileObj["companyName"];
        var _companyAddress = _profileController.profileObj["companyAddress"];
        if (_companyName != null && _companyAddress != null) {
          await http.post(
            Uri.parse(baseUrl + "api/create/employer/posts"),
            body: {
              "uid": "${_accountController.userObj!.id}",
              "datePosted": await parseDateToString(),
              "companyName": "$_companyName",
              "title": title,
              "location": "$_companyAddress",
              "details": "$details",
              "salary": "$salary",
              "projectLength": "$projectLength",
              "experienceLevel": "$experienceLevel",
              "isVisible": "true",
            },
          );
          Get.back();
          Get.toNamed("/postings-view-screen");
        }
      });
    } catch (e) {
      print("@post $e");
    }
  }

  deletePosting(value) async {
    await http.delete(Uri.parse(baseUrl + "api/remove/employer/posts/$value"));
    await fetchPostings();
    Get.back();
  }

  fetchPostings() async {
    try {
      var response = await http.get(Uri.parse(
        baseUrl + "api/get/employer/posts/${_accountController.userObj?.id.toString()}",
      ));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        postings.value = data;
        postings.refresh();
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print("@fetchPostings $e");
    }
  }
}
