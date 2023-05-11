import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {

  TextStyle redlogotitlestyle = TextStyle(
      color: AppColors.redColor,
      fontSize: 22,
      letterSpacing: 1,
      fontFamily: GoogleFonts.lato().fontFamily,
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    Strings.LOGO_TITLE,
                    style: redlogotitlestyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 2.5,
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("High Quality Online\nConsultation",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.appbarbackgroundColor,
                          fontSize: 20,
                          letterSpacing: 0.5,
                          fontFamily: GoogleFonts.lato().fontFamily,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 2.5,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
              Container(
                  height: Get.height / 3.5,
                  width: Get.width / 2,
                  child: Image.asset("assets/images/onboard1.png",)),
            ],
          ),
        ));
  }
}
