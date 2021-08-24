import 'package:cdo_hiring_app/controllers/employer/hiredController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class PageHired extends StatefulWidget {
  const PageHired({Key? key}) : super(key: key);

  @override
  _PageHiredState createState() => _PageHiredState();
}

class _PageHiredState extends State<PageHired> {
  final _hiredController = Get.put(HiredController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hiredController.fetchHiredPeople();
  }
  // "id": 10,
  // "employeeUid": "113608371961700040422",
  // "employerUid": "112442316652359971542",
  // "employeeApproved": "true",
  // "employeePhotoUrl": "https://www.upwork.com/profile-portraits/c1Q_kv5NasyBCkJ86oYcaOOOto-jabbh4iYHUGZM_YiKBeAsigJAJ9wYu3i4k_5RIU",
  // "employeeFirstName": "Alex",
  // "employeeLastName": "Snow",
  // "employeelAddress": "Ulyanovsk, Russia",
  // "employeeEmailAddress": "example@gmail.com",
  // "employeeEmailContactNo": "09759458371"

  List<ListTile> _mapHired(value) {
    List<ListTile> items = [];
    for (var i = 0; i < value.length; i++) {
      var widget = ListTile(
        onTap: () {},
        leading: CircleAvatar(
          backgroundImage: NetworkImage(value[i]["employeePhotoUrl"]), // no matter how big it is, it won't overflow
        ),
        title: Text(value[i]["employeeFirstName"],
            style: GoogleFonts.roboto(
              color: Colors.black87,
            )),
        subtitle: Row(
          children: [
            Icon(LineIcons.mapMarker, size: 14.0),
            Text(value[i]["employeelAddress"],
                style: GoogleFonts.roboto(
                  color: Colors.black45,
                )),
          ],
        ),
      );
      items.add(widget);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => _hiredController.isLoading.value
            ? SpinKitChasingDots(
                color: Colors.blue[300],
                size: 16.0,
              )
            : _hiredController.hired.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                    children: _mapHired(_hiredController.hired.reversed.toList()),
                  )),
      ),
    );
  }
}
