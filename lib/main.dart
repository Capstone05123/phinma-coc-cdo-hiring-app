import 'package:cdo_hiring_app/screens/account/preload.dart';
import 'package:cdo_hiring_app/screens/account/sign-in.dart';
import 'package:cdo_hiring_app/screens/account/type-selection.dart';
import 'package:cdo_hiring_app/screens/employee/main.dart';
import 'package:cdo_hiring_app/screens/employee/screens/extra/open_message.dart';
import 'package:cdo_hiring_app/screens/employee/screens/extra/open_posting.dart';
import 'package:cdo_hiring_app/screens/employee/screens/extra/submit_proposal.dart';
import 'package:cdo_hiring_app/screens/employer/main.dart';
import 'package:cdo_hiring_app/screens/employer/screens/extra/contact_support.dart';
import 'package:cdo_hiring_app/screens/employer/screens/extra/create_profile.dart';
import 'package:cdo_hiring_app/screens/employer/screens/extra/my_postings.dart';
import 'package:cdo_hiring_app/screens/employer/screens/extra/open_proposal.dart';
import 'package:cdo_hiring_app/screens/employer/screens/extra/profile.dart';
import 'package:cdo_hiring_app/screens/employer/screens/extra/reply_teamplates.dart';
import 'package:cdo_hiring_app/screens/employer/screens/extra/send_message.dart';
import 'package:cdo_hiring_app/screens/global/globalScreenSpinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jobhunter',
      defaultTransition: Transition.fade,
      transitionDuration: Duration(milliseconds: 400),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
      initialRoute: "/preload",
      getPages: [
        GetPage(title: 'Preload', name: "/preload", page: () => ScreenPreloadUserCredentials()),
        GetPage(title: 'Sign in', name: "/sign-in", page: () => ScreenSignIn()),
        GetPage(title: 'Type selection', name: "/type-selection", page: () => ScreenTypeSelection()),
        GetPage(title: 'Global spinner', name: "/global-spinner", page: () => ScreenGlobalSpinner()),

        //ScreenOpenProposal
        GetPage(title: 'Employee screen', name: "/employee-main-screen", page: () => ScreenEmployeeMain()),
        GetPage(title: 'Employer screen', name: "/employer-main-screen", page: () => ScreenEmployerMain()),

        ///ScreenContactSupport
        GetPage(title: 'Proposal view-screen', name: "/proposal-view-screen", page: () => ScreenOpenProposal()),
        GetPage(
          title: 'Reply templates view-screen',
          name: "/templates-view-screen",
          page: () => ScreenReplyTemplates(),
        ),
        GetPage(
          title: 'Profile view-screen',
          name: "/profile-view-screen",
          page: () => ScreenProfile(),
        ),
        GetPage(
          title: 'Contact us view-screen',
          name: "/contact-view-screen",
          page: () => ScreenContactSupport(),
        ),
        GetPage(
          title: 'My postings view-screen',
          name: "/postings-view-screen",
          page: () => ScreenMyPostings(),
        ),
        GetPage(
          title: 'Open posting view-screen',
          name: "/openposting-view-screen",
          page: () => ScreenOpenPosting(),
        ),
        GetPage(
          title: 'Submmit view-screen',
          name: "/submitproposal-view-screen",
          page: () => ScreenSubmitProposal(),
        ),
        GetPage(
          title: 'Create profile view-screen',
          name: "/createprofile-view-screen",
          page: () => ScreenCreateProfile(),
        ),
        GetPage(
          title: 'Send message view-screen',
          name: "/sendmessageonapprove-view-screen",
          page: () => ScreenSendApproveMessage(),
        ),
        GetPage(
          title: 'Open message view-screen',
          name: "/openmessage-view-screen",
          page: () => ScreenOpenMessage(),
        ),
      ],
    );
  }
}
