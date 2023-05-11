import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/pages/dashboard/bottom_navigation_bar_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrefferredLanguagePickerPage extends StatefulWidget {
  const PrefferredLanguagePickerPage({Key? key}) : super(key: key);

  @override
  _PrefferredLanguagePickerPageState createState() =>
      _PrefferredLanguagePickerPageState();
}

class _PrefferredLanguagePickerPageState
    extends State<PrefferredLanguagePickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                      _logo(),
                      _middiletext(),
                      _weelcometext(),
                      SizedBox(height: 50),
                      _englishbuttoon(),
                      SizedBox(height: 15),
                      _hindibuttoon(),
                      SizedBox(height: 10),
                    ]))))));
  }

  _logo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 5),
        Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png")))),
        Text(
          Strings.LOGO_TITLE,
          style: StringsStyle.redlogotitlestyle,
        ),
      ],
    );
  }

  _middiletext() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(height: 80),
              // Text(
              //   "“",
              //   style: TextStyle(
              //     color: AppColors.appbarbackgroundColor,
              //     fontSize: 45,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Text(
                Strings.MIDDILE_TEXT1,
                style: StringsStyle.languagepagetextstyle,
              ),
              Text(
                Strings.MIDDILE_TEXT2,
                style: StringsStyle.languagepagetextstyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _weelcometext() {
    return Center(
      child: Column(children: [
        SizedBox(height: 80),
        Text(
          Strings.WELCOME_TITLE1,
          style: StringsStyle.languagepagetextstyle,
        ),
        Text(
          Strings.WELCOME_TITLE2,
          style: StringsStyle.languagepagetextstyle,
        ),
      ]),
    );
  }

  _englishbuttoon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {
          Get.to(BottomNavigationBarPage(selectIndex: 0,),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));
        },
        child: CustomButton(
            text1: "", text2: "English", width: Get.width, height: 50),
      ),
    );
  }

  _hindibuttoon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
          onTap: () {},
          child: CustomButton(
              text1: "", text2: "हिंदी", width: Get.width, height: 50)),
    );
  }
}
