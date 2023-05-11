import 'package:aec_medical/api/repository/offers_repo.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/offermodel/check_coupon_model.dart';
import 'package:aec_medical/model/offermodel/offers_model.dart';
import 'package:aec_medical/utils/KidsAge.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:google_fonts/google_fonts.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final _formKey = GlobalKey<FormState>();

  late List<OffersData> offersData = [];

  late List<CheckCouponModel> checkCouponModel = [];

  TextEditingController _textEditingController = new TextEditingController();


  void _checkcoupon() {
    OffersRepo offersRepo = new OffersRepo();
    Future future = offersRepo.checkcouponApi(_textEditingController.text);
    future.then((value) {
      setState(() {
        checkCouponModel = value;
      });
      print("fffffffffffffssffff" + checkCouponModel[0].data.couponCode);
    });
  }

  @override
  void initState() {
    super.initState();
    OffersRepo offersRepo = new OffersRepo();
    Future future = offersRepo.couponApi();
    // offersRepo.checkcouponApi("FIRST10");
    future.then((value) {
      setState(() {
        offersData = value;
      });
      print("fffffffffffffffff" + offersData[0].couponCode);
    });
  }

  String _copy = "Copy Me";

  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          centerTitle: true,
          title: Text(
            Strings.OFFERSPAGETITLE,
            style: StringsStyle.pagetitlestyle,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(Strings.AVAILABLE_OFFERS, style: StringsStyle.heading),
                SizedBox(height: 10),
                if (offersData.isNull)
                  Center(
                      child: Container(
                          height: 250,
                          alignment: Alignment.center,
                          child: Text("Sorry! No Data found.")))
                else if (offersData.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  _availableoffer(),
                SizedBox(height: 30),
                //_applycoupon(),
              ],
            ),
          ),
        ));
  }

  _availableoffer() {
    return Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            primary: true,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: offersData.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isExpand = isExpand ? false : true;
                    });
                  },
                  child: CouponCard(
                      height: 110,
                      curveRadius: 20,
                      clockwise: true,
                      width: Get.width,
                      curveAxis: Axis.vertical,
                      firstChild: Container(
                        height: 150,
                        color: isCouponValid(offersData[index].validTill)
                            ? AppColors.COUPONCOLOR
                            : AppColors.lighttextColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Center(
                            child: Text(
                              offersData[index].discount + "%\nOFF\n",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.lato().fontFamily),
                            ),
                          ),
                        ),
                      ),
                      secondChild: Container(
                        height: 150,
                        color: isCouponValid(offersData[index].validTill)
                            ? AppColors.COUPONCOLORLIGHT
                            : AppColors.extralightColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offersData[index].title,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.darktextColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.lato().fontFamily),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Coupon Code",
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        offersData[index].couponCode,
                                        style: TextStyle(
                                            letterSpacing: 1.5,
                                            color: isCouponValid(
                                                    offersData[index].validTill)
                                                ? AppColors.COUPONCOLOR
                                                : AppColors.lighttextColor,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                GoogleFonts.lato().fontFamily,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      isCouponValid(offersData[index].validTill)
                                          ? InkWell(
                                              onTap: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: offersData[index]
                                                        .couponCode));
                                                Fluttertoast.showToast(
                                                    msg: 'Coupon Code Copied!');
                                              },
                                              child: Icon(
                                                Icons.copy,
                                                size: 24,
                                                color: AppColors.COUPONCOLOR,
                                              ))
                                          : SizedBox()
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                              RotatedBox(
                                quarterTurns: 1,
                                child: isCouponValid(offersData[index].validTill)
                                        ? Text(
                                            'Valid Till \n' +
                                                offersData[index].validTill,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.lighttextColor,
                                              fontFamily:
                                                  GoogleFonts.lato().fontFamily,
                                            ),
                                          )
                                        : Text(
                                            'Expired'.toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.lighttextColor,
                                              fontFamily:
                                                  GoogleFonts.lato().fontFamily,
                                            ),
                                          ),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
              );
            }));
  }


  _applycoupon() {
    return Visibility(
        visible: isExpand,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Strings.APPLYCOUPONCARD, style: StringsStyle.normaltextstyle),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 50,
                    width: Get.width / 1 - 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whitetextColor,
                      border: Border.all(color: Colors.grey, width: 1.5),
                    ),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                          controller: _textEditingController,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                              hintText: 'Enter your details here',
                              hintStyle: TextStyle(
                                  color: AppColors.appbarbackgroundColor,
                                  fontSize: 12),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: AppColors.whitetextColor, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: AppColors.whitetextColor, width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.yellow, width: 1),
                                  borderRadius: BorderRadius.circular(10)))),
                    )),
                SizedBox(width: 10),
                InkWell(
                  onTap: _checkcoupon,
                  child: CustomButton(
                      text1: "", text2: "Apply Now", width: 150, height: 50),
                )
              ],
            ),
          ],
        ));
  }
}
