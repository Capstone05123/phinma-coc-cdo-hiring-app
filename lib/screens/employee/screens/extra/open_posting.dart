import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class ScreenOpenPosting extends StatefulWidget {
  const ScreenOpenPosting({Key? key}) : super(key: key);

  @override
  _ScreenOpenPostingState createState() => _ScreenOpenPostingState();
}

class _ScreenOpenPostingState extends State<ScreenOpenPosting> {
  var _datePosted,
      _title,
      _location,
      _details,
      _salary,
      _projectLength,
      _experienceLevel,
      _companyName,
      _employeeContactNo,
      _employerUid,
      _companyAddress,
      _employeeEmailAddress;

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
    _employerUid = Get.arguments["employerUid"];
    _companyName = Get.arguments["companyName"];
    _companyAddress = Get.arguments["companyAddress"];
    _employeeEmailAddress = Get.arguments["employeeEmailAddress"];
    _employeeContactNo = Get.arguments["employeeContactNo"];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Job Details",
                style: GoogleFonts.roboto(
                  fontSize: 30.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _title,
                style: GoogleFonts.roboto(
                  fontSize: 19.0,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
                margin: EdgeInsets.only(top: 2.0, bottom: 7.0),
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
                margin: EdgeInsets.only(top: 5),
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0),
                child: Divider(),
              ),
              Container(
                child: Text(
                  "Expected Salary",
                  style: GoogleFonts.roboto(
                    fontSize: 15.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4.0),
                child: Text(
                  "₱" +
                      _salary
                          .toString()
                          .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                  style: GoogleFonts.roboto(
                    fontSize: 40.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text(
                  "More details",
                  style: GoogleFonts.roboto(
                    fontSize: 15.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Text(
                  _details,
                  style: GoogleFonts.roboto(
                    fontSize: 15.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Spacer(flex: 5),
              Container(
                width: Get.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.all(15.0),
                    primary: Colors.black87,
                    // side: BorderSide(width: 0.5, color: blue),
                  ),
                  onPressed: () {
                    print(_datePosted);
                    print(_title);
                    print(_location);
                    print(_details);
                    print(_salary);
                    print(_projectLength);
                    print(_experienceLevel);
                    print(_companyName);
                    print(_employerUid);
                    print(_employeeContactNo);
                    print(_companyAddress);
                    print(_employeeEmailAddress);
                    Get.toNamed("/submitproposal-view-screen", arguments: {
                      "datePosted": _datePosted,
                      "title": _title,
                      "location": _location,
                      "details": _details,
                      "salary": _salary,
                      "projectLength": _projectLength,
                      "experienceLevel": _experienceLevel,
                      "companyName": _companyName,
                      "employerUid": _employerUid,
                      "employeeContactNo": _employeeContactNo,
                      "companyAddress": _companyAddress,
                      "employeeEmailAddress": _employeeEmailAddress,
                    });
                  },
                  child: Text(
                    "Submit a Proposal",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.all(15.0),
                    primary: Colors.grey[50],
                    // side: BorderSide(width: 0.5, color: blue),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LineIcons.heart,
                        color: Colors.pinkAccent,
                        size: 14.0,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "Save job",
                        style: GoogleFonts.roboto(
                          color: Colors.pinkAccent,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
