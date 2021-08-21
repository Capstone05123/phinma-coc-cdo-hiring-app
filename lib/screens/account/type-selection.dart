import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ScreenTypeSelection extends StatefulWidget {
  const ScreenTypeSelection({Key? key}) : super(key: key);

  @override
  _ScreenTypeSelectionState createState() => _ScreenTypeSelectionState();
}

class _ScreenTypeSelectionState extends State<ScreenTypeSelection> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(Get.arguments["photoUrl"]),
              ),
              SizedBox(height: 30.0),
              Container(
                child: Text(
                  Get.arguments["name"],
                  style: GoogleFonts.roboto(
                    color: Colors.black54,
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Container(
                child: Text(
                  Get.arguments["email"],
                  style: GoogleFonts.roboto(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Spacer(),
              ToggleSwitch(
                initialLabelIndex: 0,
                totalSwitches: 2,
                fontSize: 16.0,
                minWidth: Get.width * 0.40,
                activeFgColor: Colors.white,
                curve: Curves.easeInOut,
                dividerColor: Colors.black12,
                cornerRadius: 5.0,
                radiusStyle: true,
                animate: true,
                borderWidth: 1.0,
                activeBgColor: [Color(0xFF64B5F6)],
                inactiveBgColor: Colors.white,
                labels: ['Find a job', 'Hire people'],
                onToggle: (index) {
                  print('switched to: $index');
                },
              ),
              Spacer(),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: false,
                title: Text(
                  "Send me genuinely useful emails every now and then to help me get the most out of Jobhunter.",
                  style: GoogleFonts.roboto(
                    color: Colors.black87,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                onChanged: (value) {},
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: false,
                title: Text(
                  "I understand and agree to the Jobhunter Terms of Service and Privacy Policy.",
                  style: GoogleFonts.roboto(
                    color: Colors.black87,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                onChanged: (value) {},
              ),
              Spacer(),
              Container(
                width: Get.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.all(15.0),
                    primary: Colors.blue[300],
                    // side: BorderSide(width: 0.5, color: blue),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Create my account",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
