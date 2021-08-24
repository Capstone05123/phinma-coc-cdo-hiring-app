import 'package:cdo_hiring_app/controllers/employees/messageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class PageMyMessages extends StatefulWidget {
  const PageMyMessages({Key? key}) : super(key: key);

  @override
  _PageMyMessagesState createState() => _PageMyMessagesState();
}

class _PageMyMessagesState extends State<PageMyMessages> {
  final _messagesController = Get.put(MessageController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messagesController.fetchMessages();
  }

  List<GestureDetector> _mapItems(data) {
    List<GestureDetector> items = [];
    for (var i = 0; i < data.length; i++) {
      var widget = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Get.toNamed("/openmessage-view-screen", arguments: {
            "messageId": data[i]["id"],
            "from": data[i]["companyName"],
            "date": data[i]["date"],
            "message": data[i]["message"],
            "leadingTitle": data[i]["leadingTitle"],
          });
        },
        child: Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data[i]["companyName"],
                style: GoogleFonts.roboto(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
              Text(
                data[i]["date"].toString(),
                style: GoogleFonts.roboto(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2.0),
                child: Text(
                  data[i]["message"],
                  style: GoogleFonts.roboto(
                    color: Colors.black54,
                    fontWeight: FontWeight.w300,
                    fontSize: 13.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Divider(),
              )
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
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Obx(
          () => _messagesController.isLoading.value
              ? SpinKitChasingDots(
                  color: Colors.blue[300],
                  size: 16.0,
                )
              : _messagesController.messages.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LineIcons.envelopeOpenAlt,
                            color: Colors.black45,
                            size: 155.0,
                          ),
                          Text(
                            "No messages",
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
                      children: _mapItems(
                        _messagesController.messages.reversed.toList(),
                      ),
                    ),
        ),
      ),
    );
  }
}
