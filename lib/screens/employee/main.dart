import 'package:cdo_hiring_app/controllers/account/accountController.dart';
import 'package:cdo_hiring_app/controllers/employees/messageController.dart';
import 'package:cdo_hiring_app/screens/employee/screens/jobPostings.dart';
import 'package:cdo_hiring_app/screens/employee/screens/my_messages.dart';
import 'package:cdo_hiring_app/screens/employee/screens/my_proposals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:badges/badges.dart';

class ScreenEmployeeMain extends StatefulWidget {
  const ScreenEmployeeMain({Key? key}) : super(key: key);

  @override
  _ScreenEmployeeMainState createState() => _ScreenEmployeeMainState();
}

class _ScreenEmployeeMainState extends State<ScreenEmployeeMain> {
  final _accountController = Get.put(AccountController());
  final _messageController = Get.put(MessageController());

  PageController? _pageController = PageController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var _selectedPage = "Feed";
  var _selectedIndex = 0;

  _handleSignOut() {
    _accountController.signOutGoogle();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageController.fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leadingWidth: 0,
          title: Text(
            _selectedPage,
            style: GoogleFonts.roboto(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(LineIcons.bars),
              onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
              color: Colors.black87,
            ),
          ],
        ),
        endDrawer: Drawer(
          child: Column(
            // Important: Remove any padding from the ListView.
            children: [
              SizedBox(height: 100.0),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 70,
                child: ClipOval(
                  child: Image.network(
                    _accountController.userObj!.photoUrl.toString(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  _accountController.userGoogleName(),
                  style: GoogleFonts.roboto(
                    fontSize: 16.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LineIcons.envelope,
                      color: Colors.black54,
                      size: 14,
                    ),
                    SizedBox(width: 2.0),
                    Text(
                      _accountController.userObj!.email.substring(0, _accountController.userObj!.email.indexOf("@")),
                      style: GoogleFonts.roboto(
                        fontSize: 14.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Spacer(flex: 5),
              Spacer(flex: 5),
              Divider(),
              Container(
                width: Get.width,
                child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.all(20.0)),
                  onPressed: () => Get.toNamed("/contact-view-screen"),
                  child: Text(
                    'Contact us',
                    style: GoogleFonts.roboto(
                      fontSize: 16.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Container(
                width: Get.width,
                child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.all(20.0)),
                  onPressed: () => _handleSignOut(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign out',
                        style: GoogleFonts.roboto(
                          fontSize: 16.0,
                          color: Colors.black45,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Icon(Icons.logout, size: 16, color: Colors.black45),
                    ],
                  ),
                ),
              ),
              Spacer(),
            ],
          ), // Populate the Drawer in the next step.
        ),
        body: PageView(
          controller: _pageController,
          children: [
            PageJobPostings(),
            PageEmployeeProposals(),
            PageMyMessages(),
          ],
        ),
        bottomNavigationBar: TitledBottomNavigationBar(
          indicatorColor: Colors.black87,
          activeColor: Colors.black87,
          currentIndex: _selectedIndex, // Use this to update the Bar giving a position
          onTap: (index) {
            if (index == 0) {
              setState(() {
                _selectedPage = "Feed";
                _selectedIndex = 0;
              });
              _pageController?.jumpToPage(0);
            }
            if (index == 1) {
              setState(() {
                _selectedPage = "My Proposals";
                _selectedIndex = 1;
              });
              _pageController?.jumpToPage(1);
            }
            if (index == 2) {
              setState(() {
                _selectedPage = "Mail";
                _selectedIndex = 2;
              });
              _pageController?.jumpToPage(2);
            }

            print("Selected Index: $index");
          },
          items: [
            TitledNavigationBarItem(title: Text('Feed'), icon: Icon(LineIcons.rssSquare)),
            TitledNavigationBarItem(title: Text('My Proposals'), icon: Icon(LineIcons.inbox)),
            TitledNavigationBarItem(
              title: Obx(() => Badge(
                    showBadge: _messageController.messages.length == 0 ? false : true,
                    badgeContent: Text(_messageController.messages.length.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: 10.0,
                          color: Colors.white,
                        )),
                    child: Text('Mail'),
                  )),
              icon: Icon(LineIcons.envelopeAlt),
            )
          ],
        ),
      ),
    );
  }
}
