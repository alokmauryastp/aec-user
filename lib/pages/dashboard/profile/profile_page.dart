import 'dart:async';

import 'package:aec_medical/api/repository/home_repo.dart';
import 'package:aec_medical/api/repository/profile_repo.dart';
import 'package:aec_medical/model/profilemodel/getprofile_model.dart';
import 'package:aec_medical/pages/dashboard/drawer/my_account/edit_my_account_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Timer timer;
  late Future future;
  String font = "Roboto";

  var current_index = 3;
  late List<GetProfileModel> getProfileModel = [];

  // @override
  // void initState() {
  //   super.initState();
  // ProfileRepo profileRepo = new ProfileRepo();
  //   Future future = profileRepo.getproifileApi();
  //   future.then((value){
  //     setState(() {
  //       getProfileModel = value;
  //     });
  //     print("fffffffffffffffff"+getProfileModel[0].data.name.toString());
  //   });
  // }

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
    HomeRepo homeRepo = new HomeRepo();
    homeRepo.checkUserAccountApi();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            if (getProfileModel.isNull)
              Center(
                  child: Container(
                      height: 250,
                      alignment: Alignment.center,
                      child: Text("Sorry! No Data found.")))
            else if (getProfileModel.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Center(child: CircularProgressIndicator()),
              )
            else
              Container(
                  child: Column(children: [
                _headingcard(),
                SizedBox(height: 2),
                _personaldetailbanner(),
                SizedBox(height: 2),
                _personaldetails(),
              ])),
          ],
        ))));
  }

  _headingcard() {
    return InkWell(
        splashColor: AppColors.appbarbackgroundColor,
        onTap: () {
          Get.to(EditMyAccountPage(),
              arguments: getProfileModel[0].data,
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));
        },
        child: Container(
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                color: AppColors.profileBg,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(Strings.PROFILEDETAILS,
                          style: StringsStyle.profiletitlestyle),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Hello ${getProfileModel[0].data.name},",
                                      style: TextStyle(
                                          fontFamily: GoogleFonts.montserrat()
                                              .fontFamily,
                                          color: AppColors.darktextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  SizedBox(height: 5),
                                  Text(getProfileModel[0].data.gender,
                                      style: TextStyle(
                                          fontFamily: GoogleFonts.montserrat()
                                              .fontFamily,
                                          color: AppColors.lighttextColor,
                                          fontSize: 14)),
                                ]),
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(getProfileModel[0].data.profile),
                            ),
                          ])
                    ],
                  ),
                )),
          ),
        ));
  }

  _personaldetailbanner() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 3),
              ),
            ],
            gradient: LinearGradient(colors: [
              Color(0xffED816E),
              Color(0xffB93342),
            ]),
          ),
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.PERSONALDETAILBANNERTEXT,
                    style: StringsStyle.personaldetailbannerstyle),
                InkWell(
                  onTap: () {
                    Get.to(EditMyAccountPage(),
                        arguments: getProfileModel[0].data,
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            fontFamily: GoogleFonts.aBeeZee().fontFamily,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  TextStyle profileStyle = TextStyle(
      color: Color(0xff366997),
      fontWeight: FontWeight.bold,
      fontSize: 15,
      fontFamily: GoogleFonts.lato().fontFamily,
      letterSpacing: 0.5);


  TextStyle personaldetailstyle = TextStyle(
    color: AppColors.lighttextColor,
    fontSize: 14,
    letterSpacing: 0.5,
    fontFamily: GoogleFonts.lato().fontFamily,
    fontWeight: FontWeight.w500,
  );

  _personaldetails() {
    return Container(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Strings.NAME,
                              style: personaldetailstyle),
                          Text(getProfileModel[0].data.name, style: profileStyle)
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Strings.EMAIL,
                              style: personaldetailstyle),
                          Text(getProfileModel[0].data.email, style: profileStyle)
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Strings.MOBILENUMBER,
                              style: personaldetailstyle),
                          Text(getProfileModel[0].data.mobile,
                              style: profileStyle)
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Strings.GENDER,
                              style: personaldetailstyle),
                          Text(getProfileModel[0].data.gender,
                              style: profileStyle)
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Strings.DATEOFBIRTH,
                              style: personaldetailstyle),
                          Text(getProfileModel[0].data.dOB, style: profileStyle)
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Strings.BLOODGROUP,
                              style: personaldetailstyle),
                          Text(getProfileModel[0].data.bloodGroup,
                              style: profileStyle)
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Strings.MARITALSTATUS,
                              style: personaldetailstyle),
                          Text(getProfileModel[0].data.marritalStatus,
                              style: profileStyle)
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Strings.HEIGHT,
                              style: personaldetailstyle),
                          Text(getProfileModel[0].data.height,
                              style: profileStyle)
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Strings.WEIGHT,
                              style: personaldetailstyle),
                          Text(getProfileModel[0].data.weight,
                              style: profileStyle)
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Strings.EMERGENCYCONTACT,
                              style: personaldetailstyle),
                          Text(getProfileModel[0].data.alternetContact,
                              style: profileStyle)
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Strings.LOCATION,
                              style: personaldetailstyle),
                          Container(
                            //width: 150,
                            child: Text(getProfileModel[0].data.address,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: profileStyle),
                          )
                        ],
                      ),
                    ],
                  ))),
        ));
  }
}
