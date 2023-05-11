import 'dart:async';

import 'package:aec_medical/api/repository/profile_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/model/profilemodel/getprofile_model.dart';
import 'package:aec_medical/pages/dashboard/bottom_navigation_bar_page.dart';
import 'package:aec_medical/pages/dashboard/consultation/medical_history_page.dart';
import 'package:aec_medical/pages/dashboard/consultation/select_speciality_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/AllBookCounsellingPage.dart';
import 'package:aec_medical/pages/dashboard/drawer/account_settings/account_settings_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/medical_records_page.dart';

import 'package:aec_medical/pages/dashboard/drawer/my_courses_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/offers_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/health_blogs_tips_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/total_health_page.dart';
import 'package:aec_medical/pages/onboarding/onborading_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share/share.dart';


class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  GoogleSignIn _googleSignIn = GoogleSignIn();

  late Timer timer;
  late Future future;
  var current_index = 3;

  late List<GetProfileModel> getProfileModel = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) async {
        this.setState(() {
          ProfileRepo profileRepo = new ProfileRepo();
          future = profileRepo.getproifileApi();
          future.then((value) {
            setState(() {
              getProfileModel = value;
            });
          });
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Column(
            children: [
              InkWell(
                splashColor: AppColors.appbarbackgroundColor,
                onTap: () {
                  // Get.to(HomePageDrawer(),
                  //     transition: Transition.rightToLeftWithFade,
                  //     duration: Duration(milliseconds: 600));
                  print("homeeeeeeeee");
                  // Get.to(BottomNavigationBarPage());
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder) =>
                      // MedicalHistoryPage()
                          BottomNavigationBarPage(selectIndex: 0)
                  ));
                },
                child: ListTile(
                  title: Text(Strings.HOME),
                  horizontalTitleGap: 0,
                  leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(Icons.home,size: 20,)),
                ),
              ),
              InkWell(
                  splashColor: AppColors.appbarbackgroundColor,
                  onTap: () {
                    print("cosulationsssss");
                    // Get.to(BottomNavigationBarPage(),arguments: 1);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (builder) =>
                            BottomNavigationBarPage(selectIndex: 2)));
                    // Get.to(MyConsultationPage(),
                    //     transition: Transition.rightToLeftWithFade,
                    //     duration: Duration(milliseconds: 600));
                  },
                  child: ListTile(
                    title: Text(Strings.MY_CONSULTATION),
                    horizontalTitleGap: 0,
                    leading: SizedBox(
                        height: 20,
                        width: 20,
                        child:
                            Icon(Icons.event_available,size: 20,)),
                  )),
              InkWell(
                  splashColor: AppColors.appbarbackgroundColor,
                  onTap: () {
                    Get.to(MedicalRecordsPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                  child: ListTile(
                    title: Text(Strings.MEDICAL_RECORDS),
                    horizontalTitleGap: 0,
                    leading: SizedBox(
                        height: 20,
                        width: 20,
                        child: Icon(Icons.receipt_long,size: 20,)),
                  )),
              InkWell(
                  splashColor: AppColors.appbarbackgroundColor,
                  onTap: () {
                    Get.to(TotalHealthPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                  child: ListTile(
                    title: Text(Strings.TOTAL_HEALTH),
                    horizontalTitleGap: 0,
                    leading: SizedBox(
                        height: 20,
                        width: 20,
                        child: Icon(Icons.medical_services,size: 20,)),
                  )),
              ListTile(
                onTap: () {
                  Get.to(SelectSpecialityPage(),
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 600));
                },
                title: Text(Strings.ONLINE_CONSULTATION),
                horizontalTitleGap: 0,
                leading: SizedBox(
                    height: 20,
                    width: 20,
                    child:Icon(Icons.headset_mic,size: 20,)),
              ),

              // InkWell(
              //     splashColor: AppColors.appbarbackgroundColor,
              //     onTap: () {
              //       Get.to(BestCounselorPage(),
              //           transition: Transition.rightToLeftWithFade,
              //           duration: Duration(milliseconds: 600));
              //     },
              //     child: ListTile(
              //       title: Text("Best Counselor"),
              //       horizontalTitleGap: 0,
              //       leading: SizedBox(
              //           height: 20,
              //           width: 20,
              //           child: Image.asset("assets/images/counselor.png",color: AppColors.appbarbackgroundColor)),
              //     )),
              InkWell(
                  splashColor: AppColors.appbarbackgroundColor,
                  onTap: () {
                    Get.to(AllBookCounsellingPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                  child: ListTile(
                    title: Text("My Counselling"),
                    horizontalTitleGap: 0,
                    leading: SizedBox(
                        height: 20,
                        width: 20,
                        child: Icon(Icons.question_answer,size: 20,)),
                  )),
              InkWell(
                  splashColor: AppColors.appbarbackgroundColor,
                  onTap: () {
                    Get.to(HealthBlogsTipsPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                  child: ListTile(
                    title: Text("All Health Blogs & Tips"),
                    horizontalTitleGap: 0,
                    leading: SizedBox(
                        height: 20,
                        width: 20,
                        child: Icon(Icons.health_and_safety,size: 20,)),
                  )),
              // InkWell(
              //     splashColor: AppColors.appbarbackgroundColor,
              //     onTap: () {
              //       // Get.to(MyAccountPageFromDrawer(),
              //       //     transition: Transition.rightToLeftWithFade,
              //       //     duration: Duration(milliseconds: 600));
              //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>BottomNavigationBarPage(selectIndex:3)));
              //     },
              //     child: ListTile(
              //       title: Text(Strings.MY_ACCOUNT),
              //       horizontalTitleGap: 0,
              //       leading: SizedBox(
              //           height: 20,
              //           width: 20,
              //           child: Image.asset("assets/images/my_account.png")),
              //     )),
              InkWell(
                  splashColor: AppColors.appbarbackgroundColor,
                  onTap: () {
                    Get.to(MyCoursesPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                  child: ListTile(
                    title: Text(Strings.My_COURSES),
                    horizontalTitleGap: 0,
                    leading: SizedBox(
                        height: 20,
                        width: 20,
                        child: Icon(Icons.queue,size: 20,)),
                  )),
              InkWell(
                  splashColor: AppColors.appbarbackgroundColor,
                  onTap: () {
                    Get.to(OffersPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                  child: ListTile(
                    title: Text(Strings.OFFERS),
                    horizontalTitleGap: 0,
                    leading: SizedBox(
                        height: 20,
                        width: 20,
                        child: Icon(
                          Icons.local_offer,
                          size: 20,
                        ),),
                  )),
              InkWell(
                  splashColor: AppColors.appbarbackgroundColor,
                  onTap: () {
                    Get.to(AccountSettingsPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                  child: ListTile(
                    title: Text(Strings.ACCOUNT_SETTINGS),
                    horizontalTitleGap: 0,
                    leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 20,
                      ),
                    ),
                  )),
              ListTile(
                onTap: () {
                  Share.share(
                      "Online and telephonic availability of medicine and health related consultations\n\nApollo E-Clinic - Apps on Google Play \n\n https://play.google.com/store/apps/details?id=com.aaragroups.aecuser");
                },
                title: Text(Strings.SHARE),
                horizontalTitleGap: 0,
                leading: Icon(
                  Icons.share,
                  size: 20,
                ),
              ),
              InkWell(
                splashColor: AppColors.appbarbackgroundColor,
                onTap: () {
                  Get.defaultDialog(
                    radius: 5,
                    backgroundColor: Colors.white,
                    title: 'Are you sure you want to logout?',
                    titleStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: () async {
                              setState(() async {
                                await SharedPrefManager.clearPrefs();
                                _googleSignIn.signOut();
                              });
                              Get.back();
                              Get.snackbar("Logout", "Successfully");
                            },
                            child: Center(
                              child: Container(
                                  height: 45,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color(0xffED816E),
                                        Color(0xffB93342),
                                        // Colors.red.shade500,
                                        // AppColors.redColor,
                                      ]),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                      child: Text(
                                    "Yes",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                            )),
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Center(
                              child: Container(
                                  height: 45,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color(0xffED816E),
                                        Color(0xffB93342),
                                        // Colors.red.shade500,
                                        // AppColors.redColor,
                                      ]),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                      child: Text(
                                    "No",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                            )),
                      ],
                    ),
                  );
                },
                child: ListTile(
                  title: Text(Strings.LOGOUT),
                  horizontalTitleGap: 0,
                  leading: SizedBox(
                    height: 20,
                    width: 20,
                    child: Icon(
                      Icons.logout,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
