import 'package:cdo_hiring_app/controllers/employees/proposalController.dart';
import 'package:cdo_hiring_app/helpers/destroyTextFieldFocus.dart';
import 'package:cdo_hiring_app/screens/employee/screens/post-components/cover-letter.dart';
import 'package:cdo_hiring_app/ui/spinnerOverlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class ScreenSubmitProposal extends StatefulWidget {
  const ScreenSubmitProposal({Key? key}) : super(key: key);

  @override
  _ScreenSubmitProposalState createState() => _ScreenSubmitProposalState();
}

class _ScreenSubmitProposalState extends State<ScreenSubmitProposal> {
  final _proposalEmployeeController = Get.put(ProposalEmployeeController());
  var _datePosted, _title, _location, _details, _salary, _projectLength, _experienceLevel, _companyName;
  var _employerUid, _employeeContactNo, _companyAddress, _employeeEmailAddress;

  TextEditingController _coverLetterController = TextEditingController();
  FocusNode _coverLetterFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _datePosted = Get.arguments["datePosted"];
    _title = Get.arguments["title"];
    _location = Get.arguments["location"];
    _details = Get.arguments["details"];
    _salary = Get.arguments["salary"];
    _projectLength = Get.arguments["projectLength"];
    _experienceLevel = Get.arguments["experienceLevel"];
    _companyName = Get.arguments["companyName"];
    _employerUid = Get.arguments["employerUid"];
    _employeeContactNo = Get.arguments["employeeContactNo"];
    _companyAddress = Get.arguments["companyAddress"];
    _employeeEmailAddress = Get.arguments["employeeEmailAddress"];
  }

  _handleSubmitProposal() {
    final _coverLeter = _coverLetterController.text.toString();
    if (_coverLeter.isEmpty) {
      _coverLetterFocusNode.requestFocus();
      return;
    }
    if (_coverLeter.isNotEmpty) {
      toggleOverlay(context: context);
      _proposalEmployeeController.post(
        companyName: _companyName,
        employerUid: _employerUid,
        leadingTitle: _title,
        employeeContactNo: _employeeContactNo,
        companyAddress: _companyAddress,
        coverLetter: _coverLeter,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _coverLetterFocusNode.dispose();
    _coverLetterController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => destroyTextFieldFocus(context),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
          backgroundColor: Colors.white,
          body: CustomScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Submit a proposal",
                        style: GoogleFonts.roboto(
                          fontSize: 30.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        child: Text(
                          _title,
                          style: GoogleFonts.roboto(
                            fontSize: 19.0,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2.0),
                        child: Text(
                          "Posted on " + _datePosted,
                          style: GoogleFonts.roboto(
                            fontSize: 12.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 7.0),
                        child: Row(
                          children: [
                            Icon(
                              LineIcons.building,
                              size: 12.0,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              _companyName,
                              style: GoogleFonts.roboto(
                                fontSize: 12.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.w300,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(LineIcons.mapMarker, size: 12.0, color: Colors.black54),
                            Container(
                              child: Text(
                                _location,
                                style: GoogleFonts.roboto(
                                  fontSize: 12.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    LineIcons.hashtag,
                                    size: 14,
                                    color: Colors.black87,
                                  ),
                                  Text(
                                    _projectLength,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  )),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        LineIcons.hashtag,
                                        size: 14,
                                        color: Colors.black87,
                                      ),
                                      Text(
                                        _experienceLevel + "-level",
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 25.0),
                        child: Text(
                          "Cover Letter",
                          style: GoogleFonts.roboto(
                            fontSize: 16.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3.0),
                        child: Text(
                          "Introduce yourself and explain why you’re a strong candidate for this job.",
                          style: GoogleFonts.roboto(
                            fontSize: 14.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.0),
                        child: textFieldPostCoverLetter(
                          textFieldController: _coverLetterController,
                          textFieldFocusNode: _coverLetterFocusNode,
                          hasError: false,
                        ),
                      ),
                      Container(height: 10.0),
                      Container(
                        width: Get.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.all(15.0),
                            primary: Colors.black87,
                            // side: BorderSide(width: 0.5, color: blue),
                          ),
                          onPressed: () => _handleSubmitProposal(),
                          child: Text(
                            "Submit Proposal",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
