import 'dart:convert';
import 'package:cdo_hiring_app/controllers/account/accountController.dart';
import 'package:cdo_hiring_app/controllers/global.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FeedController extends GetxController {
  RxList jobPostings = [].obs;
  RxBool isLoading = true.obs;

  fetchJobPostings() async {
    try {
      var result = await http.get(Uri.parse(baseUrl + "api/get/employer/posts/all"));
      if (result.statusCode == 200) {
        var data = jsonDecode(result.body);
        jobPostings.value = data;
        jobPostings.refresh();
        isLoading.value = false;
      }
    } catch (e) {
      print("@fetchJobPostings $e");
      isLoading.value = false;
    }
  }

  clearJobPostingsData() {
    jobPostings.value = [];
    jobPostings.refresh();
  }
}
