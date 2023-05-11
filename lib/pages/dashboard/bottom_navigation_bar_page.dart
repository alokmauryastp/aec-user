import 'dart:async';

import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/profile_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/model/profilemodel/getprofile_model.dart';
import 'package:aec_medical/pages/dashboard/consultation/consultation_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/drawer_page.dart';
import 'package:aec_medical/pages/dashboard/home/home_page.dart';
import 'package:aec_medical/pages/dashboard/profile/profile_page.dart';
import 'package:aec_medical/pages/dashboard/share/share_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

import 'medical_report/medical_report_page.dart';
import 'notification_page.dart';

class BottomNavigationBarPage extends StatefulWidget {
  int selectIndex;

  BottomNavigationBarPage({required this.selectIndex});

  @override
  _BottomNavigationBarPageState createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int currentPage = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var newIn = Get.arguments;

  late List<GetProfileModel> getProfileModel = [];

  late Timer timer;
  late Future future;

  @override
  void initState() {
    if (widget.selectIndex == null) {
    } else {
      currentPage = widget.selectIndex;
    }
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      timer =
          new Timer.periodic(new Duration(seconds: 10), (Timer timer) async {
        this.setState(() {
          ProfileRepo profileRepo = new ProfileRepo();
          future = profileRepo.getproifileApi();
          future.then((value) {
            setState(() {
              getProfileModel = value;
              SharedPrefManager.savePrefString(
                  AppConstant.NAME, getProfileModel[0].data.name);
            });
          });
        });
      });
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      HomePage(),
      //SharePage(),
      MedicalRecordsPage(),
      ConsultationPage(),
      ProfilePage(),
    ];

    final tab = [
      TabData(iconData: Icons.home_outlined, title: "Home"),
      //TabData(iconData: Icons.ios_share, title: "Share"),
      TabData(iconData: Icons.medical_services, title: "Medical"),
      TabData(iconData: Icons.question_answer, title: "Consults"),
      TabData(iconData: Icons.account_box, title: "Profile"),
    ];

    return SafeArea(
      top: false,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: AppColors.appbarbackgroundColor,
            leading: InkWell(
              splashColor: AppColors.appbarbackgroundColor,
              onTap: _openDrawer,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset(
                  "assets/images/drawer_icon.png",
                ),
              ),
            ),
            actions: [
              //IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 30)),
              IconButton(
                  onPressed: () {
                    Get.to(NotificationPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                  icon: Icon(Icons.notifications, size: 30)),
            ],
          ),
          drawer: Drawer(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: AppColors.lightblueColor,
                    ),
                    child: Container(
                      // color: AppColors.lightblueColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            splashColor: AppColors.appbarbackgroundColor,
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                                alignment: Alignment.topRight,
                                // margin: EdgeInsets.only(bottom: 45),
                                child: Icon(Icons.clear)),
                          ),
                          if (getProfileModel.isNull)
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              //backgroundImage: NetworkImage(getProfileModel[0].data.profile),
                            )
                          else if (getProfileModel.isEmpty)
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                            )
                          else
                            Container(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 45,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        getProfileModel[0].data.profile),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        getProfileModel[0].data.name,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              AppColors.appbarbackgroundColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        getProfileModel[0].data.address,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.darktextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 2, child: DrawerPage()),
              ],
            ),
          ),
          body: tabs[currentPage],
          bottomNavigationBar: FancyBottomNavigation(
            circleColor: Colors.red.shade400,
            textColor: Colors.red.shade400,
            initialSelection: currentPage,
            barBackgroundColor: Colors.white,
            inactiveIconColor: Colors.grey,
            tabs: tab,
            onTabChangedListener: (position) {
              setState(() {
                currentPage = position;
                print("ghggghhggh");
                // currentPage = position;
              });
            },
          )),
    );
  }
}
