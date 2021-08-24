import 'package:cdo_hiring_app/controllers/employees/messageController.dart';
import 'package:cdo_hiring_app/controllers/employer/proposalController.dart';
import 'package:cdo_hiring_app/helpers/destroyTextFieldFocus.dart';
import 'package:cdo_hiring_app/screens/employer/screens/sendmessage-components/letter.dart';
import 'package:cdo_hiring_app/ui/spinnerOverlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class ScreenSendApproveMessage extends StatefulWidget {
  const ScreenSendApproveMessage({Key? key}) : super(key: key);

  @override
  _ScreenSendApproveMessageState createState() => _ScreenSendApproveMessageState();
}

class _ScreenSendApproveMessageState extends State<ScreenSendApproveMessage> {
  var _employeeName, _proposalId, _employeeId, _companyName, _leadingTitle;

  final _proposalController = Get.put(ProposalController());
  final _messageController = Get.put(MessageController());

  TextEditingController _letterController = TextEditingController();
  FocusNode _letterFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _employeeName = Get.arguments["employeeName"];
    _employeeId = Get.arguments["employeeId"];
    _proposalId = Get.arguments["proposalId"];
    _companyName = Get.arguments["companyName"];
    _leadingTitle = Get.arguments["leadingTitle"];
  }

  _handleSubmitLetter(value) {
    toggleOverlay(context: context);
    _proposalController.updateApproveProposal(value);
    _messageController.post(
      employeeId: _employeeId,
      message: _letterController.text,
      companyName: _companyName,
      leadingTitle: _leadingTitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => destroyTextFieldFocus(context),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            leadingWidth: 0,
            backgroundColor: Colors.white,
            actionsIconTheme: IconThemeData(color: Colors.black87),
            actions: [
              IconButton(onPressed: () => Get.toNamed("/employer-main-screen"), icon: Icon(LineIcons.times)),
            ],
            //iconTheme: IconThemeData(color: Colors.black87),
          ),
          body: Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Write a letter",
                        style: GoogleFonts.roboto(
                          fontSize: 30.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Write a congratulations letter to notify ${_employeeName.toString().split(" ").sublist(0, 1).join()} that their application letter was approved",
                        style: GoogleFonts.roboto(
                          fontSize: 15.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: textFieldResponseLetter(
                          textFieldController: _letterController,
                          textFieldFocusNode: _letterFocusNode,
                          hasError: false,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 40.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.all(15.0),
                            primary: Colors.black87,
                            // side: BorderSide(width: 0.5, color: blue),
                          ),
                          onPressed: () => _handleSubmitLetter(_proposalId),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Send letter",
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Icon(
                                LineIcons.envelope,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
