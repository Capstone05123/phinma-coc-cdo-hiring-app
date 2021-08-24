import 'package:cdo_hiring_app/controllers/employer/postingsController.dart';
import 'package:cdo_hiring_app/helpers/destroyTextFieldFocus.dart';
import 'package:cdo_hiring_app/helpers/parseDate.dart';
import 'package:cdo_hiring_app/screens/employer/screens/post-components/details.dart';
import 'package:cdo_hiring_app/screens/employer/screens/post-components/salary.dart';
import 'package:cdo_hiring_app/screens/employer/screens/post-components/title.dart';
import 'package:cdo_hiring_app/ui/spinnerOverlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PagePost extends StatefulWidget {
  const PagePost({Key? key}) : super(key: key);

  @override
  _PagePostState createState() => _PagePostState();
}

class _PagePostState extends State<PagePost> {
  final _postingController = Get.put(PostingsController());

  var _selectedTypeIndex = 0;
  var _selectedLengthIndex = 0;

  TextEditingController _titleController = TextEditingController();
  FocusNode _titleFocusNode = FocusNode();

  TextEditingController _detailsController = TextEditingController();
  FocusNode _detailsFocusNode = FocusNode();

  TextEditingController _salaryController = TextEditingController();
  FocusNode _salaryFocusNode = FocusNode();

  _handleCreatePost() async {
    final String _title = _titleController.text.trim();
    final String _details = _detailsController.text.trim();
    var _salary = _salaryController.text;

    var _level, _length;

    if (_selectedTypeIndex == 0) {
      _level = "new";
    }
    if (_selectedTypeIndex == 1) {
      _level = "mid";
    }
    if (_selectedTypeIndex == 2) {
      _level = "expert";
    }
    if (_selectedLengthIndex == 0) {
      _length = "More than a month";
    }
    if (_selectedLengthIndex == 1) {
      _length = "Full time";
    }
    if (_title.isEmpty) {
      _titleFocusNode.requestFocus();
    } else if (_details.isEmpty) {
      _detailsFocusNode.requestFocus();
    } else if (_salary.isEmpty) {
      _salaryFocusNode.requestFocus();
    }
    if (_title.isNotEmpty && _details.isNotEmpty && _salary.isNotEmpty) {
      toggleOverlay(context: context);
      await _postingController.post(
        title: _title,
        salary: double.parse(_salary),
        details: _details,
        projectLength: _length,
        experienceLevel: _level,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        //onTap: () => destroyTextFieldFocus(context),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Text(
                    "Let's start with a strong title.",
                    style: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
                  child: Text(
                    "This helps your job post stand out to the right candidates. It’s the first thing they’ll see, so make it count!",
                    style: GoogleFonts.roboto(
                      color: Colors.black54,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  child: textFieldPostTitle(
                    textFieldController: _titleController,
                    textFieldFocusNode: _titleFocusNode,
                    hasError: false,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
                  child: Text(
                    "What skills does your company require?",
                    style: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: ToggleSwitch(
                    initialLabelIndex: _selectedTypeIndex,
                    totalSwitches: 3,
                    fontSize: 16.0,
                    minWidth: 100,
                    activeFgColor: Colors.white,
                    curve: Curves.easeInOut,
                    dividerColor: Colors.black12,
                    cornerRadius: 5.0,
                    radiusStyle: true,
                    animate: true,
                    borderWidth: 1.0,
                    activeBgColor: [Colors.black87],
                    inactiveBgColor: Colors.white,
                    labels: ['New', 'Mid level', 'Expert'],
                    onToggle: (index) {
                      setState(() {
                        _selectedTypeIndex = index;
                      });
                      //
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
                  child: Text(
                    "Add more details",
                    style: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  child: textFieldPostDetails(
                    textFieldController: _detailsController,
                    textFieldFocusNode: _detailsFocusNode,
                    hasError: false,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 10.0),
                  child: textFieldPostSalary(
                    textFieldController: _salaryController,
                    textFieldFocusNode: _salaryFocusNode,
                    hasError: false,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Text(
                    "Expected contract length",
                    style: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 10.0,
                  ),
                  child: ToggleSwitch(
                    initialLabelIndex: _selectedLengthIndex,
                    totalSwitches: 2,
                    fontSize: 16.0,
                    minWidth: 150,
                    activeFgColor: Colors.white,
                    curve: Curves.easeInOut,
                    dividerColor: Colors.black12,
                    cornerRadius: 5.0,
                    radiusStyle: true,
                    animate: true,
                    borderWidth: 1.0,
                    activeBgColor: [Colors.black87],
                    inactiveBgColor: Colors.white,
                    labels: ['More than a month', 'Full time'],
                    onToggle: (index) {
                      setState(() {
                        _selectedLengthIndex = index;
                      });
                      //
                    },
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: "Post",
            backgroundColor: Colors.black87,
            onPressed: () => _handleCreatePost(),
            child: Icon(
              LineIcons.share,
            ),
          ),
        ),
      ),
    );
  }
}
