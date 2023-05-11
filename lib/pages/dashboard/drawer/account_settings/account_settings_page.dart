import 'package:aec_medical/pages/dashboard/drawer/account_settings/about_aec.dart';
import 'package:aec_medical/pages/dashboard/drawer/account_settings/privacy_policy_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/account_settings/terms_of_use_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  bool isSwitched1 = false;
  void toggleSwitch1(bool value) {
    if (isSwitched1 == false) {
      setState(() {
        isSwitched1 = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched1 = false;
      });
      print('Switch Button is OFF');
    }
  }

  bool isSwitched2 = false;
  void toggleSwitch2(bool value) {
    if (isSwitched2 == false) {
      setState(() {
        isSwitched2 = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched2 = false;
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          centerTitle: true,
          title: Text(
            Strings.SETTINGSPAGETITLE,
            style: StringsStyle.pagetitlestyle,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
        ),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: 20,),
                _logo(),
                SizedBox(height: 20,),
                Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                //_toggelsettings(),
                _generalbanner(),
                SizedBox(height: 10,),
                _generalsetting(),
          ],
        ),
              ],
            )));
  }

  _toggelsettings() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Strings.NOTIFICATION,
            ),
            Transform.scale(
                scale: 1.2,
                child: Switch(
                  onChanged: toggleSwitch1,
                  value: isSwitched1,
                  activeColor: AppColors.appbarbackgroundColor,
                  activeTrackColor: AppColors.whitetextColor,
                  inactiveThumbColor: AppColors.redColor,
                  inactiveTrackColor: AppColors.whitetextColor,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Strings.HEALTHTIPS,
            ),
            Transform.scale(
                scale: 1.2,
                child: Switch(
                  onChanged: toggleSwitch2,
                  value: isSwitched2,
                  activeColor: AppColors.appbarbackgroundColor,
                  activeTrackColor: AppColors.whitetextColor,
                  inactiveThumbColor: AppColors.redColor,
                  inactiveTrackColor: AppColors.whitetextColor,
                )),
          ],
        ),
      ]),
    );
  }

  _generalbanner() {
    return SizedBox(
      width: Get.width,
      child: Card(
          color: AppColors.appbarbackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(Strings.GENERAL,
                style: TextStyle(
                  color: AppColors.whitetextColor,
                  fontSize: 17,
                )),
          )),
    );
  }

  _generalsetting() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.to(AboutUsPage(),
                  transition: Transition.rightToLeftWithFade,
                  duration: Duration(milliseconds: 600));
            },
            child: Text(
              Strings.ABOUTAEC,
            ),
          ),
          SizedBox(height: 25),
          InkWell(
            onTap: () {
              Get.to(PrivacyPolicyPage(),
                  transition: Transition.rightToLeftWithFade,
                  duration: Duration(milliseconds: 600));
            },
            child: Text(
              Strings.PRIVACYPOLICY,
            ),
          ),
          SizedBox(height: 25),
          InkWell(
              onTap: () {
                Get.to(TermsOfUsePage(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 600));
              },
              child: Text(
                Strings.TERMSOFUSE,
              )),
          SizedBox(height: 25),
          // Text(
          //   Strings.HELPANDSUPPORT,
          // ),
        ],
      ),
    );
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

  _middilebanner() {
    return SizedBox(
      width: Get.width,
      child: Card(
          color: AppColors.appbarbackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(Strings.BANNERTEXT,
                  style: TextStyle(
                    color: AppColors.whitetextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  )),
            ),
          )),
    );
  }
}
