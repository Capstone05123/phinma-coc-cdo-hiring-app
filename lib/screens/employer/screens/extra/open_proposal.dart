import 'package:cdo_hiring_app/controllers/employees/messageController.dart';
import 'package:cdo_hiring_app/controllers/employer/hiredController.dart';
import 'package:cdo_hiring_app/controllers/employer/postingsController.dart';
import 'package:cdo_hiring_app/controllers/employer/proposalController.dart';
import 'package:cdo_hiring_app/ui/spinnerOverlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class ScreenOpenProposal extends StatefulWidget {
  const ScreenOpenProposal({Key? key}) : super(key: key);

  @override
  _ScreenOpenProposalState createState() => _ScreenOpenProposalState();
}

class _ScreenOpenProposalState extends State<ScreenOpenProposal> {
  final _proposalController = Get.put(ProposalController());

  final _hiredController = Get.put(HiredController());

  var _proposalId;
  var _employeeUid;
  var _employerUid;
  var _address;
  var _contactNo;
  var _emailAddress;
  var _photoUrl;
  var _firstName;
  var _lastName;
  var _companyName;
  var _leadingTitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _proposalId = Get.arguments["id"];
    _employeeUid = Get.arguments["employeeUid"];
    _employerUid = Get.arguments["employerUid"];
    _address = Get.arguments["employeeAddress"];
    _contactNo = Get.arguments["employeeContactNo"];
    _emailAddress = Get.arguments["employeeEmailAddress"];
    _firstName = Get.arguments["employeeFirstName"];
    _lastName = Get.arguments["employeeLastName"];
    _photoUrl = Get.arguments["employeePhotoUrl"];
    _companyName = Get.arguments["companyName"];
    _leadingTitle = Get.arguments["leadingTitle"];
  }

  _handleDeleteProposal(value) {
    toggleOverlay(context: context);
    _proposalController.deleteProposal(value);
  }

  _handleAppoveProposal(value) {
    toggleOverlay(context: context);

    Get.toNamed("/sendmessageonapprove-view-screen", arguments: {
      "employeeName": _firstName == null ? "this person" : _firstName,
      "proposalId": value,
      "employeeId": _employeeUid,
      "companyName": _companyName,
      "leadingTitle": _leadingTitle,
    });
    //_messageController.post();
  }

  _handleHireAfterApprove(
      {required String employeeUid,
      required String employerUid,
      required String photoUrl,
      required String firstName,
      required String lastName,
      required String address,
      required String emailAddress,
      required String contactNo}) {
    try {
      _hiredController.post(
        employeeUid: employeeUid,
        employerUid: employerUid,
        photoUrl: photoUrl,
        firstName: firstName,
        lastName: lastName,
        address: address,
        emailAddress: emailAddress,
        contactNo: contactNo,
      );
    } catch (e) {
      print("@_handleHireAfterApprove $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leadingWidth: 0,
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Colors.black87),
        actions: [
          IconButton(onPressed: () => Get.back(), icon: Icon(LineIcons.times)),
        ],
        //iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Container(
        child: Column(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundImage: NetworkImage(Get.arguments["employeePhotoUrl"]),
            ),
            SizedBox(height: 20.0),
            Container(
              width: Get.width * 0.60,
              child: Text(
                Get.arguments["employeeFirstName"],
                style: GoogleFonts.roboto(
                  fontSize: 25.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w300,
                ),
                softWrap: true,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Container(
                width: Get.width * 0.50,
                child: Text(
                  Get.arguments["employeeAddress"],
                  style: GoogleFonts.roboto(
                    fontSize: 13.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
              width: Get.width,
              child: Text(
                Get.arguments["coverLetter"],
                style: GoogleFonts.roboto(
                  fontSize: 16.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Container(
              width: Get.width,
              padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.all(15.0),
                  primary: Colors.black87,
                  // side: BorderSide(width: 0.5, color: blue),
                ),
                onPressed: () async {
                  _handleAppoveProposal(_proposalId);
                  _handleHireAfterApprove(
                    employeeUid: _employeeUid,
                    employerUid: _employerUid,
                    address: _address,
                    contactNo: _contactNo,
                    emailAddress: _emailAddress,
                    firstName: _firstName,
                    lastName: _lastName,
                    photoUrl: _photoUrl,
                  );
                },
                child: Text(
                  "Approve proposal",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Container(
              width: Get.width,
              padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.all(15.0),
                  // side: BorderSide(width: 0.5, color: blue),
                ),
                onPressed: () => _handleDeleteProposal(Get.arguments["id"]),
                child: Text(
                  "Reject proposal",
                  style: GoogleFonts.roboto(
                    color: Colors.red,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
