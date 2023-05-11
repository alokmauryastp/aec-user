import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/consultation_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/consultationModel/symptoms_model.dart';
import 'package:aec_medical/pages/dashboard/consultation/find_doctors_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'fill_personal_details_page.dart';

class SelectDiseasesPage extends StatefulWidget {
  const SelectDiseasesPage({Key? key}) : super(key: key);

  @override
  _SelectDiseasesPageState createState() => _SelectDiseasesPageState();
}

class _SelectDiseasesPageState extends State<SelectDiseasesPage> {
  late List<SymptomsData> symptomsData = [];

  String enable = "List";
  int _index = 0;
  var from = Get.arguments;

  // if(symptomsData.isNull)
  // Center(child: Container(
  // height: 50,
  // alignment: Alignment.center,
  // child: Text("Sorry! No Data found.")))
  // else  if(symptomsData.isEmpty)
  // Center(child: CircularProgressIndicator())
  // else

  List<String> SelectedList = [
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ConsultationRepo consultationRepo = new ConsultationRepo();
    Future future1 = consultationRepo.symptomsApi();
    future1.then((value) {
      setState(() {
        symptomsData = value;
        print("ssssymptoms" + symptomsData[0].symptoms);

        SharedPrefManager.savePrefString(AppConstant.TABLE, "symptoms");
        SharedPrefManager.savePrefString(AppConstant.GENERALPHYSICIAN, "");
        SharedPrefManager.savePrefString(AppConstant.SPEVALUE, "");
        SharedPrefManager.savePrefString(
            AppConstant.SYMVALUE, symptomsData[0].symptomsId);
        SharedPrefManager.savePrefString(
            AppConstant.VALUE, symptomsData[0].symptomsId);
        SharedPrefManager.savePrefString(
            AppConstant.SYMPTOMS, symptomsData[0].symptoms);
        SharedPrefManager.savePrefString(AppConstant.PRICE, symptomsData[0].price);
        SharedPrefManager.savePrefString(AppConstant.TYPE, symptomsData[0].symptoms);
        SharedPrefManager.savePrefString(AppConstant.TYPEIMAGE, symptomsData[0].image);

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appbarbackgroundColor,
        centerTitle: true,
        title: Text(
          "Select disease",
          style: StringsStyle.pagetitlestyle,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
      ),
      body: Column(
        children: [
          Container(
              height: 70,
              width: Get.width / 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("All Symptoms",
                        style: TextStyle(
                          color: AppColors.appbarbackgroundColor,
                          fontSize: 22,
                          letterSpacing: 0.3,
                          fontWeight: FontWeight.bold,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("View",
                            style: TextStyle(
                              color: AppColors.darktextColor,
                              fontSize: 15,
                              letterSpacing: 0.3,
                              fontWeight: FontWeight.w500,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                enable = enable == "List" ? "Grid" : "List";
                              });
                            },
                            icon: Icon(
                              enable == "List"
                                  ? Icons.grid_view
                                  : Icons.view_list,
                              size: 30,
                            ))
                      ],
                    ),
                  ],
                ),
              )),
          Expanded(
              child: enable == "List"
                  ? getListViewContext()
                  : getGridViewContext()),
          _nextbutton(),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget getListViewContext() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
          itemCount: symptomsData.length,
          itemBuilder: (BuildContext context, index) {
            return InkWell(
              onTap: () async {
                setState(() async {
                  _index = index;
                  // SelectedList[index] = SelectedList[index] == "0" ? "1" : "0";
                  await SharedPrefManager.savePrefString(
                      AppConstant.TABLE, "symptoms");
                  await SharedPrefManager.savePrefString(
                      AppConstant.GENERALPHYSICIAN, "");
                  await SharedPrefManager.savePrefString(
                      AppConstant.SPEVALUE, "");
                  await SharedPrefManager.savePrefString(
                      AppConstant.SYMVALUE, symptomsData[index].symptomsId);
                  await SharedPrefManager.savePrefString(
                      AppConstant.VALUE, symptomsData[index].symptomsId);
                  await SharedPrefManager.savePrefString(
                      AppConstant.SYMPTOMS, symptomsData[index].symptoms);
                  await SharedPrefManager.savePrefString(
                      AppConstant.PRICE, symptomsData[index].price);
                  await SharedPrefManager.savePrefString(AppConstant.TYPE, symptomsData[index].symptoms);
                  await SharedPrefManager.savePrefString(AppConstant.TYPEIMAGE, symptomsData[index].image);
                  String table = await SharedPrefManager.getPrefrenceString(
                      AppConstant.TABLE.toString());
                  String value = await SharedPrefManager.getPrefrenceString(
                      AppConstant.VALUE.toString());
                  String SYMVALUE = await SharedPrefManager.getPrefrenceString(
                      AppConstant.SYMVALUE.toString());
                  print("sjashj" + table);
                  print("sjashj" + value);
                  print("sjashj" + SYMVALUE);
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                Icon(
                                  // SelectedList[index] == "0"
                                  _index != index
                                      ? Icons.circle_outlined
                                      : Icons.album,
                                  size: 25,
                                  color:
                                      // SelectedList[index] == "0"
                                      _index != index
                                          ? Colors.black
                                          : Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(symptomsData[index].symptoms,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.darktextColor,
                                      fontSize: 15,
                                      letterSpacing: 0.3,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ])),
                          CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.white38,
                              child: Container(
                                  decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:NetworkImage(symptomsData[index].image,scale: 1.0),
                                  fit: BoxFit.cover,
                                ),
                              ))),
                        ],
                      ),
                    )),
              ),
            );
          }),
    );
  }

  Widget getGridViewContext() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1,
        children: List.generate(symptomsData.length, (index) {
          return InkWell(
              onTap: () {
                setState(() async {
                  _index = index;
                  // SelectedList[index] = SelectedList[index] == "0" ? "1" : "0";
                  await SharedPrefManager.savePrefString(
                      AppConstant.TABLE, "symptoms");
                  await SharedPrefManager.savePrefString(
                      AppConstant.GENERALPHYSICIAN, "");
                  await SharedPrefManager.savePrefString(
                      AppConstant.SPEVALUE, "");
                  await SharedPrefManager.savePrefString(
                      AppConstant.SYMVALUE, symptomsData[index].symptomsId);
                  await SharedPrefManager.savePrefString(
                      AppConstant.VALUE, symptomsData[index].symptomsId);
                  await SharedPrefManager.savePrefString(
                      AppConstant.SYMPTOMS, symptomsData[index].symptoms);
                  await SharedPrefManager.savePrefString(
                      AppConstant.PRICE, symptomsData[index].price);
                  await SharedPrefManager.savePrefString(AppConstant.TYPE, symptomsData[index].symptoms);
                  await SharedPrefManager.savePrefString(AppConstant.TYPEIMAGE, symptomsData[index].image);
                  String table = await SharedPrefManager.getPrefrenceString(
                      AppConstant.TABLE.toString());
                  String value = await SharedPrefManager.getPrefrenceString(
                      AppConstant.VALUE.toString());
                  print("sjashj" + table);
                  print("sjashj" + value);
                });
              },
              child:
                  // SelectedList[index]=="0"
                  _index != index
                      ? Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Container(
                                      decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          symptomsData[index].image),
                                      // AssetImage(
                                      //     "assets/images/physician.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ))),
                              // Container(
                              //     decoration: BoxDecoration(
                              //         shape: BoxShape.circle, color: Colors.red),
                              //     alignment: Alignment.center,
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(15),
                              //       child:
                              //           Icon(Icons.person, size: 30, color: Colors.white),
                              //     )),
                              Center(
                                child: Text(symptomsData[index].symptoms,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.darktextColor,
                                      letterSpacing: 0.3,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ],
                          ))
                      : Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.red.shade400,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Container(
                                      decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          symptomsData[index].image),
                                      fit: BoxFit.cover,
                                    ),
                                  ))),
                              // Container(
                              //     decoration: BoxDecoration(
                              //         shape: BoxShape.circle, color: Colors.red),
                              //     alignment: Alignment.center,
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(15),
                              //       child:
                              //           Icon(Icons.person, size: 30, color: Colors.white),
                              //     )),
                              Center(
                                child: Text(symptomsData[index].symptoms,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.whitetextColor,
                                      letterSpacing: 0.3,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ],
                          )));
        }),
      ),
    );
  }

  _nextbutton() {
    return Align(
      alignment: Alignment.bottomRight,
      // ignore: deprecated_member_use
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: InkWell(
            onTap: () async {
              String table = await SharedPrefManager.getPrefrenceString(
                  AppConstant.TABLE.toString());
              String value = await SharedPrefManager.getPrefrenceString(
                  AppConstant.VALUE.toString());
              String type = await SharedPrefManager.getPrefrenceString(AppConstant.TYPE);
              String typeimage = await SharedPrefManager.getPrefrenceString(AppConstant.TYPEIMAGE);
              if (value.isNull) {
                Fluttertoast.showToast(
                    msg: "Please Select a Symptoms",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.black,
                    textColor: Colors.white);
              } else {
                from=='1'?
                Get.to(
                  FindDoctorsPage(),
                    // FillPersonalDetailPage(),
                    arguments: [type,typeimage],
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 600)):
                Get.back();
              }
            },
            child:
                CustomButton(text1: "", text2: "Next", width: 150, height: 50)),
      ),
    );
  }
}
