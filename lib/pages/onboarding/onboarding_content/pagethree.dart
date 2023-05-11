import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class PageThree extends StatefulWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {





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
                  Text("Comfort of\nYour Home",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.appbarbackgroundColor,
                          fontSize: 20,
                          fontFamily: GoogleFonts.lato().fontFamily,
                          letterSpacing: 0.5,
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
                  child: Image.asset("assets/images/onboard3.png",)),
            ],
          ),
        ));
  }
}
