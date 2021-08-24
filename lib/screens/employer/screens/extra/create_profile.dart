import 'package:cdo_hiring_app/controllers/account/accountController.dart';
import 'package:cdo_hiring_app/controllers/employer/profileController.dart';
import 'package:cdo_hiring_app/helpers/destroyTextFieldFocus.dart';
import 'package:cdo_hiring_app/screens/employer/screens/post-components/profileCompanyAddress.dart';
import 'package:cdo_hiring_app/screens/employer/screens/post-components/profileCompanyName.dart';
import 'package:cdo_hiring_app/screens/employer/screens/post-components/profileLastName.dart';
import 'package:cdo_hiring_app/screens/employer/screens/post-components/profileName.dart';
import 'package:cdo_hiring_app/ui/spinnerOverlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class ScreenCreateProfile extends StatefulWidget {
  const ScreenCreateProfile({Key? key}) : super(key: key);

  @override
  _ScreenCreateProfileState createState() => _ScreenCreateProfileState();
}

class _ScreenCreateProfileState extends State<ScreenCreateProfile> {
  final _accountController = Get.find<AccountController>();
  final _profileController = Get.put(ProfileController());

  TextEditingController _profileNameController = TextEditingController();
  FocusNode _profileNameFocusNode = FocusNode();

  TextEditingController _profileLastNameController = TextEditingController();
  FocusNode _profileLastNameFocusNode = FocusNode();

  TextEditingController _profileCompanyNameController = TextEditingController();
  FocusNode _profileCompanyNameFocusNode = FocusNode();

  TextEditingController _profileCompanyAddressController = TextEditingController();
  FocusNode _profileCompanyAddressFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _profileNameController.dispose();
    _profileNameFocusNode.dispose();
    _profileCompanyNameController.dispose();
    _profileCompanyNameFocusNode.dispose();
    _profileCompanyAddressController.dispose();
    _profileCompanyAddressFocusNode.dispose();
  }

  _handleCreateProfile() {
    final _firstname = _profileNameController.text.trim();
    final _lastName = _profileLastNameController.text.trim();
    final _companyAddress = _profileCompanyAddressController.text.trim();
    final _companyName = _profileCompanyNameController.text.trim();

    toggleOverlay(context: context);
    _profileController.post(
      firstName: _firstname,
      lastName: _lastName,
      companyAddress: _companyAddress,
      companyName: _companyName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => destroyTextFieldFocus(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 70.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(_accountController.userObj!.photoUrl.toString()),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15.0),
                          child: Text(
                            _accountController.userObj!.displayName.toString(),
                            style: GoogleFonts.roboto(
                              fontSize: 16.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(LineIcons.starAlt, size: 13.0, color: Colors.orange),
                              SizedBox(width: 2.0),
                              Text(
                                "Employer",
                                style: GoogleFonts.roboto(
                                  fontSize: 14.0,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Employer Firstname",
                        style: GoogleFonts.roboto(
                          fontSize: 16.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: textFieldProfileName(
                          textFieldController: _profileNameController,
                          textFieldFocusNode: _profileNameFocusNode,
                          hasError: false,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Employer Lastname",
                          style: GoogleFonts.roboto(
                            fontSize: 16.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: textFieldProfileLastName(
                          textFieldController: _profileLastNameController,
                          textFieldFocusNode: _profileLastNameFocusNode,
                          hasError: false,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Company name",
                          style: GoogleFonts.roboto(
                            fontSize: 16.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: textFieldProfileCompanyName(
                          textFieldController: _profileCompanyNameController,
                          textFieldFocusNode: _profileCompanyNameFocusNode,
                          hasError: false,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Company address",
                          style: GoogleFonts.roboto(
                            fontSize: 16.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: textFieldProfileCompanyAddress(
                          textFieldController: _profileCompanyAddressController,
                          textFieldFocusNode: _profileCompanyAddressFocusNode,
                          hasError: false,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.all(15.0),
                            primary: Colors.blue[300],
                            // side: BorderSide(width: 0.5, color: blue),
                          ),
                          onPressed: () => _handleCreateProfile(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                LineIcons.editAlt,
                                color: Colors.white,
                                size: 14.0,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                "Save changes",
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
