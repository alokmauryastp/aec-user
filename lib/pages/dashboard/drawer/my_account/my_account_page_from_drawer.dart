import 'dart:async';

import 'package:aec_medical/api/repository/profile_repo.dart';
import 'package:aec_medical/model/profilemodel/getprofile_model.dart';
import 'package:aec_medical/pages/dashboard/drawer/my_account/edit_my_account_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../notification_page.dart';

class MyAccountPageFromDrawer extends StatefulWidget {
  const MyAccountPageFromDrawer({Key? key}) : super(key: key);

  @override
  _MyAccountPageFromDrawerState createState() =>
      _MyAccountPageFromDrawerState();
}

class _MyAccountPageFromDrawerState extends State<MyAccountPageFromDrawer> {


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
          future.then((value){
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
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(NotificationPage(),
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 600));
                }, icon: Icon(Icons.notifications, size: 30)),
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(getProfileModel.isNull)
                      Center(child: Container(
                          height: 250,
                          alignment: Alignment.center,
                          child: Text("Sorry! No Data found.")))
                    else  if(getProfileModel.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else Container(
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
          Get.to(EditMyAccountPage(),arguments: getProfileModel[0].data,
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));
        },
        child: Container(
          width: Get.width,
          child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(Strings.PROFILETITLE,
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
                                        color: AppColors.darktextColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16)),
                                SizedBox(height: 5),
                                Text("How're you today?",
                                    style: TextStyle(
                                        color: AppColors.darktextColor,
                                        fontSize: 12)),
                              ]),
                          CircleAvatar(radius: 40,
                            backgroundImage: NetworkImage(getProfileModel[0].data.profile),
                          ),
                        ])
                  ],
                ),
              )),
        ));
  }

  _personaldetailbanner() {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
          gradient: LinearGradient(colors: [
            Colors.red.shade500,
            AppColors.redColor,
          ]),
        ),
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(Strings.PERSONALDETAILBANNERTEXT,
              style: StringsStyle.personaldetailbannerstyle),
        ));
  }

  _personaldetails() {
    return Container(
        width: Get.width,
        child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
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
                            style: StringsStyle.personaldetailstyle),
                        Text(getProfileModel[0].data.name,
                            style: TextStyle(color: AppColors.lighttextColor))
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.EMAIL,
                            style: StringsStyle.personaldetailstyle),
                        Text(getProfileModel[0].data.email,
                            style: TextStyle(color: AppColors.lighttextColor))
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.MOBILENUMBER,
                            style: StringsStyle.personaldetailstyle),
                        Text(getProfileModel[0].data.mobile,
                            style: TextStyle(color: AppColors.lighttextColor))
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.GENDER,
                            style: StringsStyle.personaldetailstyle),
                        Text(getProfileModel[0].data.gender,
                            style: TextStyle(color: AppColors.lighttextColor))
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.DATEOFBIRTH,
                            style: StringsStyle.personaldetailstyle),
                        Text(getProfileModel[0].data.dOB,
                            style: TextStyle(color: AppColors.lighttextColor))
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.BLOODGROUP,
                            style: StringsStyle.personaldetailstyle),
                        Text(getProfileModel[0].data.bloodGroup,
                            style: TextStyle(color: AppColors.lighttextColor))
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.MARITALSTATUS,
                            style: StringsStyle.personaldetailstyle),
                        Text(getProfileModel[0].data.marritalStatus,
                            style: TextStyle(color: AppColors.lighttextColor))
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.HEIGHT,
                            style: StringsStyle.personaldetailstyle),
                        Text(getProfileModel[0].data.height,
                            style: TextStyle(color: AppColors.lighttextColor))
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.WEIGHT,
                            style: StringsStyle.personaldetailstyle),
                        Text(getProfileModel[0].data.weight,
                            style: TextStyle(color: AppColors.lighttextColor))
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.EMERGENCYCONTACT,
                            style: StringsStyle.personaldetailstyle),
                        Text(getProfileModel[0].data.alternetContact,
                            style: TextStyle(color: AppColors.lighttextColor))
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.LOCATION,
                            style: StringsStyle.personaldetailstyle),
                        Container(
                          //width: 150,
                          child: Text(getProfileModel[0].data.address,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(color: AppColors.lighttextColor)),
                        )
                      ],
                    ),
                  ],
                ))));
  }
}
