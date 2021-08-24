import 'package:cdo_hiring_app/controllers/employees/messageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ScreenOpenMessage extends StatefulWidget {
  const ScreenOpenMessage({Key? key}) : super(key: key);

  @override
  _ScreenOpenMessageState createState() => _ScreenOpenMessageState();
}

class _ScreenOpenMessageState extends State<ScreenOpenMessage> {
  var _from, _date, _message, _leadingTitle;

  var _messageId;

  final _messageController = Get.put(MessageController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _from = Get.arguments["from"];
    _date = Get.arguments["date"];
    _message = Get.arguments["message"];
    _leadingTitle = Get.arguments["leadingTitle"];
    _messageId = Get.arguments["messageId"];
  }

  _handleDelete() {
    Alert(
      context: context,
      title: "",
      buttons: [
        DialogButton(
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
          child: Text(
            "Cancel",
            style: GoogleFonts.roboto(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
          ),
        ),
        DialogButton(
          color: Colors.red,
          onPressed: () {
            _messageController.deleteMessage(_messageId);
            Get.back();
          },
          child: Text(
            "Delete",
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
          ),
        )
      ],
      content: Container(
        width: 300.0,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delete this mail?",
              style: GoogleFonts.roboto(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 18.0,
              ),
            ),
            Text(
              "This action is cannot be undone",
              style: GoogleFonts.roboto(
                color: Colors.black87,
                fontWeight: FontWeight.w300,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
      style: AlertStyle(
        isOverlayTapDismiss: false,
        titleStyle: TextStyle(height: 0),
        isCloseButton: false,
        backgroundColor: Colors.white,
        overlayColor: Colors.black.withOpacity(0.9),
        alertElevation: 0,
        buttonsDirection: ButtonsDirection.row,
        alertBorder: Border(
          top: BorderSide.none,
          bottom: BorderSide.none,
          left: BorderSide.none,
          right: BorderSide.none,
        ),
        animationType: AnimationType.grow,
      ),
    ).show();
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
          title: Text(
            _from,
            style: GoogleFonts.roboto(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          actionsIconTheme: IconThemeData(color: Colors.black87),
          actions: [
            IconButton(onPressed: () => Get.back(), icon: Icon(LineIcons.times)),
          ],
          //iconTheme: IconThemeData(color: Colors.black87),
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _message,
                      style: GoogleFonts.roboto(
                        color: Colors.black87,
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Best,",
                            style: GoogleFonts.roboto(
                              color: Colors.black54,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            _from + " team",
                            style: GoogleFonts.roboto(
                              color: Colors.black54,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          elevation: 0.0,
          tooltip: 'Delete mail',
          child: Icon(LineIcons.alternateTrash, color: Colors.white),
          onPressed: () => _handleDelete(),
        ),
      ),
    );
  }
}
