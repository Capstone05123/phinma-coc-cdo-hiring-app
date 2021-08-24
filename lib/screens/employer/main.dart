import 'package:cdo_hiring_app/controllers/account/accountController.dart';
import 'package:cdo_hiring_app/controllers/employer/profileController.dart';
import 'package:cdo_hiring_app/screens/employer/screens/hired.dart';
import 'package:cdo_hiring_app/screens/employer/screens/mail.dart';
import 'package:cdo_hiring_app/screens/employer/screens/post.dart';
import 'package:cdo_hiring_app/screens/employer/screens/proposals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class ScreenEmployerMain extends StatefulWidget {
  const ScreenEmployerMain({Key? key}) : super(key: key);

  @override
  _ScreenEmployerMainState createState() => _ScreenEmployerMainState();
}

class _ScreenEmployerMainState extends State<ScreenEmployerMain> {
  PageController? _pageController = PageController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String _selectedPage = "Proposals";
  int _selectedIndex = 1;
  final _accountController = Get.put(AccountController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _pageController?.jumpToPage(1);
    });
  }

  _handleSignOut() {
    _accountController.signOutGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: Drawer(
          child: Column(
            // Important: Remove any padding from the ListView.
            children: [
              SizedBox(height: 100.0),
              Hero(
                tag: _accountController.userObj!.photoUrl.toString(),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 70,
                  child: ClipOval(
                    child: Image.network(
                      _accountController.userObj!.photoUrl.toString(),
                    ),
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
                child: Text(
                  _accountController.userObj!.email.substring(0, _accountController.userObj!.email.indexOf("@")),
                  style: GoogleFonts.roboto(
                    fontSize: 14.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(flex: 5),
              Container(
                width: Get.width,
                child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.all(20.0)),
                  onPressed: () => Get.toNamed("/profile-view-screen"),
                  child: Text(
                    'My Profile',
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
                  onPressed: () => Get.toNamed("/postings-view-screen"),
                  child: Text(
                    'My Postings',
                    style: GoogleFonts.roboto(
                      fontSize: 16.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
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
        backgroundColor: Colors.white,
        body: PageView(
          controller: _pageController,
          children: [
            PagePost(),
            PageProposal(),
            PageHired(),
          ],
        ),
        bottomNavigationBar: TitledBottomNavigationBar(
          indicatorColor: Colors.black87,
          activeColor: Colors.black87,
          currentIndex: _selectedIndex, // Use this to update the Bar giving a position
          onTap: (index) {
            if (index == 0) {
              setState(() {
                _selectedPage = "Create post";
                _selectedIndex = 0;
              });
              _pageController?.jumpToPage(0);
            }
            if (index == 1) {
              setState(() {
                _selectedPage = "Proposals";
                _selectedIndex = 1;
              });
              _pageController?.jumpToPage(1);
            }
            // if (index == 2) {
            //   setState(() {
            //     _selectedPage = "Mail";
            //     _selectedIndex = 2;
            //   });
            //   _pageController?.jumpToPage(2);
            // }
            if (index == 2) {
              setState(() {
                _selectedPage = "Hired people";
                _selectedIndex = 2;
              });
              _pageController?.jumpToPage(2);
            }
            print("Selected Index: $index");
          },
          items: [
            TitledNavigationBarItem(title: Text('Post'), icon: Icon(LineIcons.plus)),
            TitledNavigationBarItem(title: Text('Proposals'), icon: Icon(LineIcons.inbox)),
            // TitledNavigationBarItem(title: Text('Mail'), icon: Icon(LineIcons.envelope)),
            TitledNavigationBarItem(title: Text('Hired'), icon: Icon(LineIcons.userCheck)),
          ],
        ),
      ),
    );
  }
}
