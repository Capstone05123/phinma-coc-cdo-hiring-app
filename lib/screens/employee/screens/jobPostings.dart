import 'package:cdo_hiring_app/controllers/account/accountController.dart';
import 'package:cdo_hiring_app/controllers/employees/feedController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class PageJobPostings extends StatefulWidget {
  const PageJobPostings({Key? key}) : super(key: key);

  @override
  _PageJobPostingsState createState() => _PageJobPostingsState();
}

class _PageJobPostingsState extends State<PageJobPostings> {
  final _feedController = Get.put(FeedController());
  final _accountController = Get.put(AccountController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _feedController.fetchJobPostings();
  }

  List<GestureDetector> _mapItems(data) {
    List<GestureDetector> items = [];
    for (var i = 0; i < data.length; i++) {
      var widget = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Get.toNamed("/openposting-view-screen", arguments: {
            "datePosted": data[i]["datePosted"],
            "title": data[i]["title"],
            "location": data[i]["location"],
            "details": data[i]["details"],
            "salary": data[i]["salary"],
            "projectLength": data[i]["projectLength"],
            "experienceLevel": data[i]["experienceLevel"],
            "companyName": data[i]["companyName"],
            "employerUid": data[i]["uid"],
            "employeeContactNo": "None",
            "companyAddress": data[i]["location"],
            "employeeEmailAddress": "${_accountController.userObj!.email.toString()}",
          });
        },
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data[i]["title"],
                style: GoogleFonts.roboto(
                  fontSize: 19.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.0, top: 3.0),
                child: Text(
                  "Salary ₱" +
                      data[i]["salary"]
                          .toString()
                          .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                  style: GoogleFonts.roboto(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                data[i]["details"],
                style: GoogleFonts.roboto(
                  fontSize: 15.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w300,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
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
                      data[i]["companyName"],
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
                margin: EdgeInsets.only(bottom: 7.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(LineIcons.mapMarker, size: 12.0, color: Colors.black54),
                    Container(
                      child: Text(
                        data[i]["location"],
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
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 4.0, top: 4.0),
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[i]["projectLength"],
                          style: GoogleFonts.roboto(
                            fontSize: 14.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          data[i]["projectLength"],
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
                              data[i]["experienceLevel"] + "-level",
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
              Divider(),
            ],
          ),
        ),
      );
      items.add(widget);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => _feedController.isLoading.value
          ? SpinKitChasingDots(
              color: Colors.blue[300],
              size: 16.0,
            )
          : _feedController.jobPostings.length == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LineIcons.building,
                        color: Colors.black45,
                        size: 155.0,
                      ),
                      Text(
                        "No job posting available",
                        style: GoogleFonts.roboto(
                          color: Colors.black45,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  children: _mapItems(_feedController.jobPostings.reversed.toList()),
                )),
    );
  }
}
