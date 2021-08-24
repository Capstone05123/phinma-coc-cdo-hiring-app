import 'package:cdo_hiring_app/controllers/employees/proposalController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class PageEmployeeProposals extends StatefulWidget {
  const PageEmployeeProposals({Key? key}) : super(key: key);

  @override
  _PageEmployeeProposalsState createState() => _PageEmployeeProposalsState();
}

class _PageEmployeeProposalsState extends State<PageEmployeeProposals> {
  final _proposalController = Get.put(ProposalEmployeeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _proposalController.fetchMyProposals();
  }

  List<Container> _mapItems(data) {
    List<Container> items = [];
    for (var i = 0; i < data.length; i++) {
      var widget = Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data[i]["leadingTitle"],
              style: GoogleFonts.roboto(
                color: Colors.black87,
                fontSize: 19.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Submitted on " + data[i]["dateSubmitted"],
              style: GoogleFonts.roboto(
                color: Colors.black54,
                fontSize: 13.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: data[i]["isApproved"] == true ? Colors.green : Colors.grey[100],
              ),
              child: Text(
                data[i]["isApproved"] == true ? "Approved" : "Waiting",
                style: GoogleFonts.roboto(
                  color: data[i]["isApproved"] == true ? Colors.white : Colors.black87,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Divider(),
          ],
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
      body: Container(
        child: Obx(() => _proposalController.isLoading.value
            ? SpinKitChasingDots(
                color: Colors.blue[300],
                size: 16.0,
              )
            : _proposalController.proposals.length == 0
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
                          "No proposals submitted",
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
                    children: _mapItems(
                      _proposalController.proposals.reversed.toList(),
                    ),
                  )),
      ),
    );
  }
}
