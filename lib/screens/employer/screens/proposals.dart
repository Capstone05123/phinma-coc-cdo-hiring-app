import 'package:cdo_hiring_app/controllers/employer/profileController.dart';
import 'package:cdo_hiring_app/controllers/employer/proposalController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class PageProposal extends StatefulWidget {
  const PageProposal({Key? key}) : super(key: key);

  @override
  _PageProposalState createState() => _PageProposalState();
}

class _PageProposalState extends State<PageProposal> {
  final _proposalController = Get.put(ProposalController());
  final _profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _proposalController.fetchProposals();
    _profileController.fetchEmployerProfile();
  }

  List<GestureDetector> _mapProposals(data) {
    List<GestureDetector> items = [];
    for (var i = 0; i < data.length; i++) {
      var widget = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          print(data[i]);
          Get.toNamed("/proposal-view-screen", arguments: {
            "id": data[i]["id"],
            "employeeUid": data[i]["uid"],
            "employerUid": data[i]["employerUid"],
            "dateSubmitted": data[i]["dateSubmitted"],
            "leadingTitle": data[i]["leadingTitle"],
            "employeePhotoUrl": data[i]["employeePhotoUrl"] == null
                ? "https://www.pngitem.com/pimgs/m/557-5578368_empty-profile-picture-icon-hd-png-download.png"
                : data[i]["employeePhotoUrl"],
            "employeeFirstName": data[i]["employeeFirstName"],
            "employeeLastName": data[i]["employeeLastName"],
            "employeeContactNo": data[i]["employeeContactNo"],
            "employeeEmailAddress": data[i]["employeeEmailAddress"],
            "employeeAddress": data[i]["employeeAddress"],
            "coverLetter": data[i]["coverLetter"],
            "isApproved": data[i]["isApproved"],
            "companyName": data[i]["companyName"],
          });
        },
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "From " + data[i]["employeeFirstName"].split(" ").sublist(0, 1).join(" ").toString(),
                style: GoogleFonts.roboto(
                  fontSize: 15.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w300,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                data[i]["leadingTitle"],
                style: GoogleFonts.roboto(
                  fontSize: 18.0,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                data[i]["coverLetter"],
                style: GoogleFonts.roboto(
                  fontSize: 14.0,
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 7.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        LineIcons.mapMarker,
                        color: Colors.black87,
                        size: 13,
                      ),
                      Text(
                        data[i]["employeeAddress"],
                        style: GoogleFonts.roboto(
                          fontSize: 12.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Text(
                    data[i]["dateSubmitted"],
                    style: GoogleFonts.roboto(
                      fontSize: 12.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      if (data[i]["isApproved"] == false) {
        items.add(widget);
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => _proposalController.proposals.length == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LineIcons.inbox,
                        color: Colors.black45,
                        size: 155.0,
                      ),
                      Text(
                        "Empty",
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
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  children: _mapProposals(_proposalController.proposals.reversed.toList()),
                ),
        ),
      ),
    );
  }
}
