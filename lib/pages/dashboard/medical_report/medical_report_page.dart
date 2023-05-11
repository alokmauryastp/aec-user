import 'dart:async';
import 'dart:io';

import 'package:aec_medical/api/repository/medicalrecord_repo.dart';
import 'package:aec_medical/model/medicalrecordModel/showmedicalrecord_model.dart';
import 'package:aec_medical/pages/dashboard/medical_report/downloadfile_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class MedicalRecordsPage extends StatefulWidget {
  const MedicalRecordsPage({Key? key}) : super(key: key);

  @override
  _MedicalRecordsPageState createState() => _MedicalRecordsPageState();
}

class _MedicalRecordsPageState extends State<MedicalRecordsPage> {

  List<ShowMedicalRecordData> showMedicalRecordData = [];
  late Timer timer;
  late Future future;
  var _index = "Lab Test";
  @override
  void initState() {
    super.initState();
   // downloadFile();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) async {
        this.setState(() {
          MedicalRecordRepo medicalRecordRepo = new MedicalRecordRepo();
          future = medicalRecordRepo.showMedicalRecordApi(_index);
          future.then((value){
            setState(() {
              showMedicalRecordData = value;
            });
          });
        });
      });
    });
  }

  bool _isLoad = false;
  void _deleterecord(medicalReportId)async{
    MedicalRecordRepo medicalRecordRepo = new MedicalRecordRepo();
    medicalRecordRepo.deleteMedicalHistoryApi(medicalReportId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColors.whitetextColor,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        _heading(),
                        SizedBox(height: 5),
                       // _searchbox(),
                      ]),
                ),
              ),
              SizedBox(height: 2),
              _listview(),
              SizedBox(height: 30),
            ],
          ),
        ));
  }

  _heading() {
    return Container(
        width: Get.width,
        child: Text(Strings.MEDICAL_RECORDS, style: TextStyle(
            color: AppColors.appbarbackgroundColor,
            fontSize: 20,
            letterSpacing: 0.5,
            fontWeight: FontWeight.bold))
    );
  }

  _searchbox() {
    return Container(
      height: 50,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.whitetextColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(3, 3))
        ],
      ),
      child: TextFormField(
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
              hintText: 'search',
              hintStyle: TextStyle(
                color: Colors.black38,
              ),
              suffixIcon: Icon(
                Icons.search,
                size: 30,
                color: Colors.black38,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.yellow, width: 1),
                  borderRadius: BorderRadius.circular(10)))),
    );
  }


  BoxDecoration myBoxinActive() {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColorDark, width: 1),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
      ),
    );
  }

  BoxDecoration myBoxActive() {
    return BoxDecoration(
      color: Theme.of(context).primaryColorDark,
      border: Border.all(color: Theme.of(context).primaryColorDark, width: 1),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
      ),
    );
  }

  activeStyle() {
    return TextStyle(
      color: AppColors.whitetextColor,
      fontSize: 15,
      letterSpacing: 0.2,
      fontWeight: FontWeight.bold,
    );
  }

  inactiveStyle() {
    return TextStyle(color: Theme.of(context).primaryColorDark);
  }

  _listview() {
    return Container(
        color: AppColors.whitetextColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 1, right: 1),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        splashColor: AppColors.appbarbackgroundColor,
                        onTap: () {
                          setState(() {
                            _index = "Lab Test";
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.3,
                          height: 40,
                          alignment: Alignment.center,
                          decoration:_index == "Lab Test" ? myBoxActive() : myBoxinActive(),
                          child: _index == "Lab Test"
                              ? Text("Lab tests",
                                  style: activeStyle())
                              : Text("Lab tests",
                                  style: inactiveStyle()),
                        )),
                    InkWell(
                        splashColor: AppColors.appbarbackgroundColor,
                        onTap: () {
                          setState(() {
                            _index = "Prescription";
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.3,
                          height: 40,
                          alignment: Alignment.center,
                          decoration:_index == "Prescription" ? myBoxActive() : myBoxinActive(),
                          child: _index == "Prescription"
                              ? Text("Prescription",
                                  style: activeStyle())
                              : Text("Prescription",
                                  style: inactiveStyle()),
                        )),
                    InkWell(
                        splashColor: AppColors.appbarbackgroundColor,
                        onTap: () {
                          setState(() {
                            _index = "Other";
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.3,
                          height: 40,
                          alignment: Alignment.center,
                          decoration:_index == "Other" ? myBoxActive() : myBoxinActive(),
                          child: _index == "Other"
                              ? Text("Others",
                              style: activeStyle())
                              : Text("Others",
                              style: inactiveStyle()),
                        )),
                  ]),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.grey),
            if(showMedicalRecordData.isNull)
              Visibility(
                visible: _index == "Other",
                child: Center(child: Container(
                    height: 250,
                    alignment: Alignment.center,
                    child: Text("Sorry! No Consultation record found."))),
              )
           else if(showMedicalRecordData.isEmpty)
             Text("")
             //Center(child: CircularProgressIndicator())
            else Visibility(
                visible: _index == "Other",
                child: Container(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        primary: true,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: showMedicalRecordData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                      color: AppColors.whitetextColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                alignment: Alignment.topRight,
                                                child:InkWell(
                                                    onTap: (){
                                                      Get.defaultDialog(
                                                        radius: 5,
                                                        backgroundColor: Colors.white,
                                                        title: 'Are you sure you want to delete this record?',
                                                        titleStyle: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold),
                                                        content: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceAround,
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _deleterecord(showMedicalRecordData[index].medicalReportId);
                                                                  });
                                                                  Get.back();
                                                                  Get.snackbar("Your record delete",
                                                                      "Successfully");
                                                                },
                                                                child: Center(
                                                                  child: Container(
                                                                      height: 45,
                                                                      width: 100,
                                                                      decoration: BoxDecoration(
                                                                          gradient: LinearGradient(colors: [
                                                                            Color(0xffED816E),
                                                                            Color(0xffB93342),
                                                                          ]),
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              20)),
                                                                      child: Center(
                                                                          child: Text(
                                                                            "Yes",
                                                                            style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Colors.white,
                                                                              fontWeight:
                                                                              FontWeight.bold,
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
                                                                          ]),
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              20)),
                                                                      child: Center(
                                                                          child: Text(
                                                                            "No",
                                                                            style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Colors.white,
                                                                              fontWeight:
                                                                              FontWeight.bold,
                                                                            ),
                                                                          ))),
                                                                )),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: Icon(Icons.cancel)),
                                              ),
                                              Text(showMedicalRecordData[index].date,
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .lighttextColor,
                                                      fontSize: 12)),
                                              SizedBox(height: 5),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                            "Disease: ${showMedicalRecordData[index].disease}",
                                                            style:
                                                                TextStyle(
                                                              color: AppColors
                                                                  .darktextColor,
                                                              letterSpacing:
                                                                  0.5,
                                                            )),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        Get.to(DownloadFile(),arguments: showMedicalRecordData[index].medicalReport,
                                                            transition: Transition.rightToLeftWithFade,
                                                            duration: Duration(milliseconds: 600));
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10),
                                                              child: Icon(
                                                                  Icons
                                                                      .download_outlined,
                                                                  color: AppColors
                                                                      .appbarbackgroundColor)),
                                                          Text("Download",
                                                              style:
                                                                  TextStyle(
                                                                color: AppColors
                                                                    .appbarbackgroundColor,
                                                                letterSpacing:
                                                                    0.5,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ]),
                                            ]),
                                      )),
                                  Divider(color: Colors.grey)
                                ],
                              ),
                            ),
                          );
                        }),
                )
              ),
            if(showMedicalRecordData.isNull)
              Visibility(
                visible: _index == "Lab Test",
                child: Center(child: Container(
                    height: 250,
                    alignment: Alignment.center,
                    child: Text("Sorry! No Lab Test records found."))),
              )
            else if(showMedicalRecordData.isEmpty)
              Text("")
              //Center(child: CircularProgressIndicator())
            else Visibility(
                visible: _index == "Lab Test",
                child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          primary: true,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: showMedicalRecordData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                        color: AppColors.whitetextColor,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.topRight,
                                                  child:InkWell(
                                                      onTap: (){
                                                        Get.defaultDialog(
                                                          radius: 5,
                                                          backgroundColor: Colors.white,
                                                          title: 'Are you sure you want to delete this record?',
                                                          titleStyle: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.bold),
                                                          content: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.spaceAround,
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      _deleterecord(showMedicalRecordData[index].medicalReportId);
                                                                    });
                                                                    Get.back();
                                                                    Get.snackbar("Your record delete",
                                                                        "Successfully");
                                                                  },
                                                                  child: Center(
                                                                    child: Container(
                                                                        height: 45,
                                                                        width: 100,
                                                                        decoration: BoxDecoration(
                                                                            gradient: LinearGradient(colors: [
                                                                              Color(0xffED816E),
                                                                              Color(0xffB93342),
                                                                            ]),
                                                                            borderRadius:
                                                                            BorderRadius
                                                                                .circular(
                                                                                20)),
                                                                        child: Center(
                                                                            child: Text(
                                                                              "Yes",
                                                                              style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.white,
                                                                                fontWeight:
                                                                                FontWeight.bold,
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
                                                                            ]),
                                                                            borderRadius:
                                                                            BorderRadius
                                                                                .circular(
                                                                                20)),
                                                                        child: Center(
                                                                            child: Text(
                                                                              "No",
                                                                              style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.white,
                                                                                fontWeight:
                                                                                FontWeight.bold,
                                                                              ),
                                                                            ))),
                                                                  )),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      child: Icon(Icons.cancel)),
                                                ),
                                                Text(showMedicalRecordData[index].date,
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .lighttextColor,
                                                        fontSize: 12)),
                                                SizedBox(height: 5),
                                                Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "Disease: ${showMedicalRecordData[index].disease}",
                                                              style:
                                                              TextStyle(
                                                                color: AppColors
                                                                    .darktextColor,
                                                                letterSpacing:
                                                                0.5,
                                                              )),
                                                        ],
                                                      ),
                                                      InkWell(
                                                        onTap: (){
                                                          Get.to(DownloadFile(),arguments: showMedicalRecordData[index].medicalReport,
                                                              transition: Transition.rightToLeftWithFade,
                                                              duration: Duration(milliseconds: 600));
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right:
                                                                    10),
                                                                child: Icon(
                                                                    Icons
                                                                        .download_outlined,
                                                                    color: AppColors
                                                                        .appbarbackgroundColor)),
                                                            Text("Download",
                                                                style:
                                                                TextStyle(
                                                                  color: AppColors
                                                                      .appbarbackgroundColor,
                                                                  letterSpacing:
                                                                  0.5,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ]),
                                              ]),
                                        )),
                                    Divider(color: Colors.grey)
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                )
            ),
            // Visibility(
            //     visible: _index == 0,
            //     child: Padding(
            //         padding: const EdgeInsets.only(top: 5.0),
            //         child: Container(
            //             child: ListView.builder(
            //                 scrollDirection: Axis.vertical,
            //                 primary: true,
            //                 shrinkWrap: true,
            //                 physics: NeverScrollableScrollPhysics(),
            //                 itemCount: 3,
            //                 itemBuilder: (BuildContext context, int index) {
            //                   return Padding(
            //                     padding: const EdgeInsets.all(2.0),
            //                     child: Container(
            //                       child: Column(
            //                         children: [
            //                           Container(
            //                               color: AppColors.whitetextColor,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.all(10.0),
            //                                 child: Column(
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment.start,
            //                                     children: [
            //                                       Text("19/02/2020",
            //                                           style: TextStyle(
            //                                               color: AppColors
            //                                                   .lighttextColor,
            //                                               fontSize: 12)),
            //                                       SizedBox(height: 5),
            //                                       Row(
            //                                           mainAxisAlignment:
            //                                               MainAxisAlignment
            //                                                   .spaceBetween,
            //                                           children: [
            //                                             Row(
            //                                               children: [
            //                                                 Text(
            //                                                     "Dentist - Docter Name",
            //                                                     style:
            //                                                         TextStyle(
            //                                                       color: AppColors
            //                                                           .darktextColor,
            //                                                       letterSpacing:
            //                                                           0.5,
            //                                                     )),
            //                                               ],
            //                                             ),
            //                                             Row(
            //                                               children: [
            //                                                 Padding(
            //                                                     padding:
            //                                                         const EdgeInsets
            //                                                                 .only(
            //                                                             right:
            //                                                                 10),
            //                                                     child: Icon(
            //                                                         Icons
            //                                                             .download_outlined,
            //                                                         color: AppColors
            //                                                             .appbarbackgroundColor)),
            //                                                 Text("Download",
            //                                                     style:
            //                                                         TextStyle(
            //                                                       color: AppColors
            //                                                           .appbarbackgroundColor,
            //                                                       letterSpacing:
            //                                                           0.5,
            //                                                     )),
            //                                               ],
            //                                             ),
            //                                           ]),
            //                                     ]),
            //                               )),
            //                           Divider(color: Colors.grey)
            //                         ],
            //                       ),
            //                     ),
            //                   );
            //                 })))),

            if(showMedicalRecordData.isNull)
              Visibility(
                visible: _index == "Prescription",
                child: Center(child: Container(
                    height: 250,
                    alignment: Alignment.center,
                    child: Text("Sorry! No Lab Test records found."))),
              )
            else if(showMedicalRecordData.isEmpty)
              Center(child: CircularProgressIndicator())
            else Visibility(
                visible: _index == "Prescription",
                child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          primary: true,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: showMedicalRecordData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                        color: AppColors.whitetextColor,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.topRight,
                                                  child:InkWell(
                                                      onTap: (){
                                                        Get.defaultDialog(
                                                          radius: 5,
                                                          backgroundColor: Colors.white,
                                                          title: 'Are you sure you want to delete this record?',
                                                          titleStyle: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.bold),
                                                          content: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.spaceAround,
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      _deleterecord(showMedicalRecordData[index].medicalReportId);
                                                                    });
                                                                    Get.back();
                                                                    Get.snackbar("Your record delete",
                                                                        "Successfully");
                                                                  },
                                                                  child: Center(
                                                                    child: Container(
                                                                        height: 45,
                                                                        width: 100,
                                                                        decoration: BoxDecoration(
                                                                            gradient: LinearGradient(colors: [
                                                                              Color(0xffED816E),
                                                                              Color(0xffB93342),
                                                                            ]),
                                                                            borderRadius:
                                                                            BorderRadius
                                                                                .circular(
                                                                                20)),
                                                                        child: Center(
                                                                            child: Text(
                                                                              "Yes",
                                                                              style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.white,
                                                                                fontWeight:
                                                                                FontWeight.bold,
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
                                                                            ]),
                                                                            borderRadius:
                                                                            BorderRadius
                                                                                .circular(
                                                                                20)),
                                                                        child: Center(
                                                                            child: Text(
                                                                              "No",
                                                                              style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.white,
                                                                                fontWeight:
                                                                                FontWeight.bold,
                                                                              ),
                                                                            ))),
                                                                  )),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      child: Icon(Icons.cancel)),
                                                ),
                                                Text(showMedicalRecordData[index].date,
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .lighttextColor,
                                                        fontSize: 12)),
                                                SizedBox(height: 5),
                                                Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "Disease: ${showMedicalRecordData[index].disease}",
                                                              style:
                                                              TextStyle(
                                                                color: AppColors
                                                                    .darktextColor,
                                                                letterSpacing:
                                                                0.5,
                                                              )),
                                                        ],
                                                      ),
                                                      InkWell(
                                                        onTap: (){
                                                          Get.to(DownloadFile(),arguments: showMedicalRecordData[index].medicalReport,
                                                              transition: Transition.rightToLeftWithFade,
                                                              duration: Duration(milliseconds: 600));
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right:
                                                                    10),
                                                                child: Icon(
                                                                    Icons
                                                                        .download_outlined,
                                                                    color: AppColors
                                                                        .appbarbackgroundColor)),
                                                            Text("Download",
                                                                style:
                                                                TextStyle(
                                                                  color: AppColors
                                                                      .appbarbackgroundColor,
                                                                  letterSpacing:
                                                                  0.5,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ]),
                                              ]),
                                        )),
                                    Divider(color: Colors.grey)
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                )
            ),
            // Visibility(
            //     visible: _index == 0,
            //     child: Padding(
            //         padding: const EdgeInsets.only(top: 5.0),
            //         child: Container(
            //             child: ListView.builder(
            //                 scrollDirection: Axis.vertical,
            //                 primary: true,
            //                 shrinkWrap: true,
            //                 physics: NeverScrollableScrollPhysics(),
            //                 itemCount: 3,
            //                 itemBuilder: (BuildContext context, int index) {
            //                   return Padding(
            //                     padding: const EdgeInsets.all(2.0),
            //                     child: Container(
            //                       child: Column(
            //                         children: [
            //                           Container(
            //                               color: AppColors.whitetextColor,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.all(10.0),
            //                                 child: Column(
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment.start,
            //                                     children: [
            //                                       Text("19/02/2020",
            //                                           style: TextStyle(
            //                                               color: AppColors
            //                                                   .lighttextColor,
            //                                               fontSize: 12)),
            //                                       SizedBox(height: 5),
            //                                       Row(
            //                                           mainAxisAlignment:
            //                                               MainAxisAlignment
            //                                                   .spaceBetween,
            //                                           children: [
            //                                             Row(
            //                                               children: [
            //                                                 Text(
            //                                                     "Dentist - Docter Name",
            //                                                     style:
            //                                                         TextStyle(
            //                                                       color: AppColors
            //                                                           .darktextColor,
            //                                                       letterSpacing:
            //                                                           0.5,
            //                                                     )),
            //                                               ],
            //                                             ),
            //                                             Row(
            //                                               children: [
            //                                                 Padding(
            //                                                     padding:
            //                                                         const EdgeInsets
            //                                                                 .only(
            //                                                             right:
            //                                                                 10),
            //                                                     child: Icon(
            //                                                         Icons
            //                                                             .download_outlined,
            //                                                         color: AppColors
            //                                                             .appbarbackgroundColor)),
            //                                                 Text("Download",
            //                                                     style:
            //                                                         TextStyle(
            //                                                       color: AppColors
            //                                                           .appbarbackgroundColor,
            //                                                       letterSpacing:
            //                                                           0.5,
            //                                                     )),
            //                                               ],
            //                                             ),
            //                                           ]),
            //                                     ]),
            //                               )),
            //                           Divider(color: Colors.grey)
            //                         ],
            //                       ),
            //                     ),
            //                   );
            //                 })))),
          ]),
        ));
  }
}
