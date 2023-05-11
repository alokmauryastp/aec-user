import 'dart:async';

import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/consultation_repo.dart';
import 'package:aec_medical/api/repository/offers_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/consultationModel/slider_model.dart';
import 'package:aec_medical/model/consultationModel/speciality_model.dart';
import 'package:aec_medical/model/consultationModel/symptoms_model.dart';
import 'package:aec_medical/model/offermodel/offers_model.dart';
import 'package:aec_medical/pages/dashboard/consultation/fill_personal_details_page.dart';
import 'package:aec_medical/pages/dashboard/consultation/find_doctors_page.dart';
import 'package:aec_medical/pages/dashboard/consultation/select_diseases_page.dart';
import 'package:aec_medical/pages/dashboard/consultation/select_specialist_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectSpecialityPage extends StatefulWidget {
  const SelectSpecialityPage({Key? key}) : super(key: key);

  @override
  _SelectSpecialityPageState createState() => _SelectSpecialityPageState();
}

class _SelectSpecialityPageState extends State<SelectSpecialityPage> {
  late List<SliderData> sliderData = [];
  // late List<SpecialityData> specialityData = [];
  late List<OffersData> offersData = [];

  late bool indx = false;
  late bool indxsymptoms = false;
  late bool indxspeciality = false;

  // void _checkcoupon(){
  //   OffersRepo offersRepo = new OffersRepo();
  //   Future future = offersRepo.checkcouponApi("FIRST10");
  //   future.then((value){
  //     setState(() {
  //       offersData = value;
  //     });
  //     print("fffffffffffffssffff"+checkCouponModel[0].data.couponCode);
  //   });
  // }
  late Timer timer;

  List<String> SelectedList = ["0", "0", "0"];
  List<String> SelectedList1 = ["0", "0", "0"];

  @override
  void initState() {
    super.initState();
    OffersRepo offersRepo = new OffersRepo();
    Future future3 = offersRepo.couponApi();
    future3.then((value) {
      setState(() {
        offersData = value;
      });
      print("fffffffffffffffff" + offersData[0].couponCode);
    });
    ConsultationRepo consultationRepo = new ConsultationRepo();
    Future future = consultationRepo.sliderApi();
    future.then((value) {
      setState(() {
        sliderData = value;
        print("kktitle" + sliderData[0].title.toString());
      });
    });


    // Future future2 = consultationRepo.specialityApi();
    // future2.then((value) {
    //   setState(() {
    //     specialityData = value;
    //     print("ssspeciality" + specialityData[0].speciality);
    //   });
    // });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          centerTitle: true,
          title: Text(
            Strings.SELECTSPECIALITYTITLE,
            style: StringsStyle.pagetitlestyle,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
        ),
        body: SafeArea(
          child: sliderData.isNull
              ? Text("")
              : (sliderData.isEmpty)
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _slider(),
                            SizedBox(
                              height: 20,
                            ),
                            _symptoms(),
                            SizedBox(
                              height: 30,
                            ),
                            // _speciality(),
                            SizedBox(
                              height: 0,
                            ),
                            _consultwithgeneralphysician(),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    )),
        ));
  }

  _slider() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        child: CarouselSlider(
          options: CarouselOptions(
            //height: MediaQuery.of(context).size.height*0.3,
            disableCenter: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2),
            autoPlayAnimationDuration: Duration(milliseconds: 1000),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            // onPageChanged: callbackFunction,
            scrollDirection: Axis.horizontal,
          ),
          items: sliderData
              .map((item) => Container(
                    child: Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              item.image,
                              fit: BoxFit.fill,
                              height: Get.height / 5,
                              width: Get.width / 1,
                            ))),
                  ))
              .toList(),
        ),
      ),
    );
  }

  _consultwithgeneralphysician() {
    return InkWell(
      onTap: () async {
        setState(() async {
          await SharedPrefManager.savePrefString(AppConstant.FROMPAGE, '');
          await SharedPrefManager.savePrefString(
              AppConstant.TABLE, "General Physician");
          await SharedPrefManager.savePrefString(
              AppConstant.VALUE, "General Physician");
          await SharedPrefManager.savePrefString(AppConstant.SPEVALUE, "");
          await SharedPrefManager.savePrefString(AppConstant.SYMVALUE, "");
          await SharedPrefManager.savePrefString(
              AppConstant.GENERALPHYSICIAN, "General Physician");
          await SharedPrefManager.savePrefString(
              AppConstant.TYPE, "General Physician");
          await SharedPrefManager.savePrefString(
              AppConstant.PRICE, 150.toString());
          String type =
              await SharedPrefManager.getPrefrenceString(AppConstant.TYPE);
          print("sfsgfs" + indx.toString());
          Get.to(
            FindDoctorsPage(),
              // FillPersonalDetailPage(),
              arguments: [type,""],
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));
        });
      },
      child: Card(
          color: AppColors.whitetextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Container(
                        decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/physician.png"),
                        fit: BoxFit.cover,
                      ),
                    ))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Consult with Our Experienced ",
                              style: TextStyle(
                                color: AppColors.darktextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "General Physician ",
                              style: TextStyle(
                                color: AppColors.appbarbackgroundColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "(MBBS)",
                              style: TextStyle(
                                color: AppColors.appbarbackgroundColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      // Container(
                      //   // alignment: Alignment.centerLeft,
                      //   child: Text("Consultation Fee. 150",
                      //     // textAlign: TextAlign.start,
                      //     style: TextStyle(
                      //       color:AppColors.appbarbackgroundColor,
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // Container(
                //   child: Text(
                //     "Rs. ",
                //     textAlign: TextAlign.left,
                //     style: TextStyle(
                //       color:AppColors.appbarbackgroundColor,
                //       fontSize: 15,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
              ],
            ),
          )),
    );
  }

  _symptoms() {
    return InkWell(
      onTap: () async {
        await SharedPrefManager.savePrefString(AppConstant.FROMPAGE, 'Speciality');
        Get.to(SelectSpecialistPage(),
            arguments: "1",
            transition: Transition.rightToLeftWithFade,
            duration: Duration(milliseconds: 600));
      },
      child: Card(
          color: AppColors.whitetextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: 200,
                    child: RichText(
                      text: TextSpan(children: [
                        // TextSpan(
                        //   text:"If you know about the doctors Speciality? you may ",
                        //   style: TextStyle(
                        //     color:AppColors.appbarbackgroundColor,
                        //     fontSize: 15,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        TextSpan(
                          text: "Select Speciality",
                          style: TextStyle(
                            color: AppColors.appbarbackgroundColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.lato().fontFamily
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red.shade700,
                  child: Icon(
                    Icons.arrow_forward,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _speciality() {
    return InkWell(
      onTap: () async {
        await SharedPrefManager.savePrefString(AppConstant.FROMPAGE, 'Symptoms');

        Get.to(SelectDiseasesPage(),
            arguments: "1",
            transition: Transition.rightToLeftWithFade,
            duration: Duration(milliseconds: 600));
      },
      child: Card(
          color: AppColors.whitetextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: 200,
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Select Symptoms",
                          style: TextStyle(
                            color: AppColors.appbarbackgroundColor,
                            fontSize: 18,
                            fontFamily: GoogleFonts.lato().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red.shade700,
                  child: Icon(
                    Icons.arrow_forward,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
