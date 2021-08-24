import 'dart:convert';

import 'package:cdo_hiring_app/controllers/account/accountController.dart';
import 'package:cdo_hiring_app/controllers/employer/hiredController.dart';
import 'package:cdo_hiring_app/controllers/global.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProposalController extends GetxController {
  final _accountController = Get.find<AccountController>();

  RxBool hasAvailableProposals = false.obs;
  RxList proposals = [].obs;

  fetchProposals() async {
    var response = await http.get(Uri.parse(
      baseUrl + "api/get/employer/proposal/${_accountController.userObj?.id.toString()}",
    ));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      proposals.value = data;
      proposals.refresh();
    }
  }

  deleteProposal(value) async {
    await http.delete(Uri.parse(baseUrl + "api/remove/employer/proposal/$value"));
    await fetchProposals();
    Get.back();
    Get.back();
  }

  updateApproveProposal(value) async {
    await http.put(Uri.parse(baseUrl + "api/update/employer/proposal?id=$value&isApproved=true"));
    await fetchProposals();
  }
}
