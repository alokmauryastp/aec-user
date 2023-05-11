import 'dart:math';

import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/consultation_repo.dart';
import 'package:aec_medical/api/repository/offers_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/consultationModel/consultbook_model.dart';
import 'package:aec_medical/model/offermodel/check_coupon_model.dart';
import 'package:aec_medical/model/offermodel/offers_model.dart';
import 'package:aec_medical/pages/dashboard/consultation/payment_confirmed_page.dart';
import 'package:aec_medical/pages/dashboard/consultation/payment_confirmed_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/account_settings/terms_of_use_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/offers_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  var index = "Hindi";
  var currentindex = "Voice Call";
  bool isExpand = false;
  late List<OffersData> offersData = [];

  late List<CheckCouponModel> checkCouponModel = [];

  final _formKey = GlobalKey<FormState>();
  final _mobile = TextEditingController();
  bool _isLoad = false;

  // late var d = Get.arguments;
  int price = 0;

  // d[0];
  String type = "";

  // = d[1];

  void _checkcoupon() async {
    setState(() {
      _isLoad = true;
    });
    OffersRepo offersRepo = new OffersRepo();
    Future future = offersRepo.checkcouponApi(_textEditingController.text);
    future.then((value) {
      setState(() {
        checkCouponModel = value;
      });
      print("fffffffffffffssffff" + checkCouponModel[0].data.couponCode);
    });
    setState(() {
      _isLoad = false;
    });
  }

  List<ConsultBookModel> consultBookModel = [];

  _consultBook() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoad = true;
    });
    await Provider.of<ConsultationRepo>(context, listen: false).consultbookApi(
        index,
        currentindex,
        ((checkCouponModel.isEmpty) ? "" : checkCouponModel[0].data.couponCode),
        ((checkCouponModel.isEmpty) ? "" : checkCouponModel[0].data.discount),
        ((checkCouponModel.isEmpty) ? "" : checkCouponModel[0].data.couponId),
        ((checkCouponModel.isEmpty)
            ? ""
            : "${(((price) * ((int.parse(checkCouponModel[0].data.discount))) / 100))}"),
        price);
    setState(() {
      _isLoad = false;
    });
  }

  // void _consultBook()async{
  //   var price = await SharedPrefManager.getPrefrenceString(AppConstant.PRICE);
  //   setState(() {
  //     _isLoad = true;
  //   });
  //  ConsultationRepo consultationRepo = new ConsultationRepo();
  //    Future future = consultationRepo.consultbookApi(index, currentindex,((checkCouponModel.isEmpty)?"":checkCouponModel[0].data.couponCode),((checkCouponModel.isEmpty)?"":checkCouponModel[0].data.discount),((checkCouponModel.isEmpty)?"":checkCouponModel[0].data.couponId),((checkCouponModel.isEmpty)?"":"${(((500)*((int.parse(checkCouponModel[0].data.discount)))/100))}"),"500");
  //  // Future future = consultationRepo.consultbookApi(index, currentindex,"","","","","500");
  //
  //   future.then((value){
  //     setState(() {
  //       consultBookModel = value;
  //     });
  //     print("fffffffffffffssffff"+consultBookModel[0].data.counsultId.toString());
  //   });
  //   setState(() {
  //     _isLoad = false;
  //   });
  // }

  TextEditingController _textEditingController = new TextEditingController();

  //var price = coursesData.price;

  late Razorpay _razorpay;

  // late String _type;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getdata();
  }

  getdata() async {
    String img = await SharedPrefManager.getPrefrenceString(AppConstant.TYPE);
    String pricee =
        await SharedPrefManager.getPrefrenceString(AppConstant.PRICE);
    setState(() {
      type = img;
      price = int.parse(pricee);
    });
  }

  static const platform = const MethodChannel("razorpay_flutter");

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_vQOXAJXDVlhsQ4',
      'amount': ((price) * 100),
      'name': 'AEC_App',
      'description': "Patients",
      'prefill': {
        'contact': '8650965058',
        'email': 'rajeev.kumar@aaratechnologies.in'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    var paymentid = response.paymentId;
    // var orderId = response.orderId;
    var orderId = "Order" +
        DateFormat("ddMMyyyy").format(new DateTime.now()) +
        new Random().nextInt(9999).toString();
    Get.defaultDialog(
      radius: 5,
      backgroundColor: Colors.white,
      title: 'Your payment Successful.',
      titleStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (_isLoad)
            CircularProgressIndicator()
          else
            InkWell(
                onTap: () async {
                  print("orderId");
                  print(orderId);
                  setState(() {
                    Get.offAll(PaymentConfirmedPage(),
                        arguments: [paymentid, orderId, price],
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  });
                },
                child: Center(
                  child: Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        "OK",
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
    // Get.offAll(OrderSuccessfulPage(),arguments: [checkoutModel[0].data,paymentid],
    //   transition: Transition.zoom,
    //   curve: Curves.bounceOut,
    //   duration: Duration(milliseconds: 600),
    // );
    // Fluttertoast.showToast(
    //     msg: "Your payment successfully completed ", toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
    //     toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: " + response.walletName!, toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          centerTitle: true,
          title: Text(
            "Payment Page",
            style: StringsStyle.pagetitlestyle,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
        ),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _consultationfor(),
          _preferedlanguage(),
          _coupons(),
          _audioandvideocall(),
          SizedBox(height: 5),
          _termsandcondition(),
          SizedBox(height: 10),
          _paymentdetail(),
        ])));
  }

  _consultationfor() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 8,
            child: Text(
              "Consultation for ${type}",
              style: TextStyle(
                color: AppColors.darktextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.backgroundColor,
                child: Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/physician.png"),
                    fit: BoxFit.cover,
                  ),
                ))),
          ),
        ],
      ),
    );
  }

  _preferedlanguage() {
    return Card(
        elevation: 2,
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Preferred Language for consultation",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darktextColor)),
            SizedBox(height: 10),
            Row(
              children: [
                InkWell(
                  splashColor: Colors.red.shade400,
                  onTap: () {
                    setState(() {
                      index = "Hindi";

                      // Fluttertoast.showToast(msg: index,
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.CENTER,
                      //     backgroundColor: Colors.black,
                      //     textColor: Colors.white);
                    });
                  },
                  child: Card(
                      elevation: 5,
                      color: index == "Hindi"
                          ? Colors.red.shade400
                          : AppColors.whitetextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                          height: 40,
                          width: 100,
                          child: Center(
                            child: Text("Hindi",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: index == "Hindi"
                                        ? AppColors.whitetextColor
                                        : AppColors.darktextColor)),
                          ))),
                ),
                SizedBox(width: 20),
                InkWell(
                    splashColor: Colors.red.shade400,
                    onTap: () {
                      setState(() {
                        index = "English";
                      });
                    },
                    child: Card(
                        color: index == "English"
                            ? Colors.red.shade400
                            : AppColors.whitetextColor,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          height: 40,
                          width: 100,
                          child: Center(
                            child: Text("English",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: index == "English"
                                        ? AppColors.whitetextColor
                                        : AppColors.darktextColor)),
                          ),
                        ))),
              ],
            ),
          ]),
        )));
  }

  _coupons() {
    return Card(
        elevation: 2,
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () {
              setState(() {
                isExpand = isExpand ? false : true;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                        color: isExpand
                            ? Colors.white
                            : AppColors.appbarbackgroundColor,
                        width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.ac_unit,
                                  color: AppColors.appbarbackgroundColor,
                                )),
                            Text(
                              "Apply coupon code",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              // Get.to(CouponPage(),
                              //     transition: Transition.rightToLeftWithFade,
                              //     duration: Duration(milliseconds: 600));
                              // setState(() {
                              //   isExpand = isExpand ? false : true;
                              // });
                            },
                            child: Container(
                                child: isExpand
                                    ? Container()
                                    : IconButton(
                                        onPressed: () {
                                          Get.to(OffersPage(),
                                              transition: Transition
                                                  .rightToLeftWithFade,
                                              duration:
                                                  Duration(milliseconds: 600));
                                          // Get.snackbar(
                                          //   "Coupon is added successfully",
                                          //   "just now",
                                          //   snackPosition: SnackPosition.BOTTOM,
                                          //   colorText: AppColors.redColor,
                                          //   backgroundColor:
                                          //       AppColors.whitetextColor,
                                          //   boxShadows: [
                                          //     BoxShadow(
                                          //       blurRadius: 1,
                                          //       color: Colors.grey.shade200,
                                          //       offset: Offset(0, 2),
                                          //       spreadRadius: 2,
                                          //     ),
                                          //   ],
                                          //   margin: EdgeInsets.all(15),
                                          // );
                                        },
                                        icon: Icon(
                                            Icons.keyboard_arrow_right_outlined,
                                            size: 30))))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Visibility(
                      visible: isExpand,
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 50,
                              width: Get.width / 1 - 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: Colors.white,
                                border: Border.all(
                                    color: AppColors.appbarbackgroundColor,
                                    width: 1.5),
                              ),
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                    controller: _textEditingController,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 1),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.grey, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.grey, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        border: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.yellow, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)))),
                              )),
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: AppColors.appbarbackgroundColor,
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  _checkcoupon();
                                },
                                child: Text(
                                  "Apply",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))),
                )
              ],
            ),
          ),
        )));
  }

  _audioandvideocall() {
    return Card(
        elevation: 2,
        child: Container(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "We are connecting through chat and audio/video call",
                            // child: Text("Preferred Voice or Video call for Consultation",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darktextColor)),
                      ),
                      SizedBox(height: 10),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     InkWell(
                      //         splashColor: Colors.red.shade400,
                      //         onTap: () {
                      //           setState(() {
                      //             currentindex = "Voice Call";
                      //           });
                      //         },
                      //         child: Card(
                      //           elevation: 5,
                      //           color: currentindex == "Voice Call"
                      //               ? Colors.red.shade400
                      //               : AppColors.whitetextColor,
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(8.0),
                      //           ),
                      //           child: Column(
                      //             children: [
                      //               Container(
                      //                 height: 100,
                      //                 width: 110,
                      //                 child: Center(
                      //                   child: CircleAvatar(
                      //                       radius: 40,
                      //                       backgroundColor: AppColors.backgroundColor,
                      //                       child: Container(
                      //                           decoration: BoxDecoration(
                      //                         image: DecorationImage(
                      //                           image: AssetImage(
                      //                               "assets/images/audio_call.png"),
                      //                           fit: BoxFit.cover,
                      //                         ),
                      //                       ))),
                      //                 ),
                      //               ),
                      //                Center(
                      //                 child: Text("Voice Call",
                      //                     style: TextStyle(
                      //                         fontSize: 13,
                      //                         fontWeight: FontWeight.w500,
                      //                         color: currentindex == "Voice Call"
                      //                             ? AppColors.whitetextColor
                      //                             : AppColors.darktextColor)),
                      //               ),
                      //               SizedBox(height: 3,),
                      //             ],
                      //           ),
                      //         )),
                      //     InkWell(
                      //         splashColor: AppColors.redColor,
                      //         onTap: () {
                      //           setState(() {
                      //             currentindex = "Video Call";
                      //           });
                      //         },
                      //         child: Card(
                      //             color: currentindex == "Video Call"
                      //                 ? Colors.red.shade400
                      //                 : AppColors.whitetextColor,
                      //             elevation: 5,
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(8.0),
                      //             ),
                      //             child: Column(
                      //               children: [
                      //                 Container(
                      //                   height: 100,
                      //                   width: 110,
                      //                   child: Center(
                      //                     child: CircleAvatar(
                      //                         radius: 40,
                      //                         backgroundColor:
                      //                             AppColors.backgroundColor,
                      //                         child: Container(
                      //                             decoration: BoxDecoration(
                      //                           image: DecorationImage(
                      //                             image: AssetImage(
                      //                                 "assets/images/video_call.png"),
                      //                             fit: BoxFit.cover,
                      //                           ),
                      //                         ))),
                      //                   ),
                      //                 ),
                      //                 Center(
                      //                   child: Text("Video Call",
                      //                       style: TextStyle(
                      //                           fontSize: 13,
                      //                           fontWeight: FontWeight.w500,
                      //                           color: currentindex == "Video Call"
                      //                               ? AppColors.whitetextColor
                      //                               : AppColors.darktextColor)),
                      //                 ),
                      //                 SizedBox(height: 3,),
                      //               ],
                      //             ))),
                      //   ],
                      // ),
                    ],
                  ),
                ))));
  }

  _termsandcondition() {
    return InkWell(
      onTap: () {
        Get.to(TermsOfUsePage());
      },
      child: Column(children: [
        Text(
          "By Clicking on Pay & consultation",
        ),
        Text(
          "are confirming that you are agree",
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "with",
          ),
          SizedBox(width: 2),
          Text("terms & condition",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColors.blueColor)),
        ])
      ]),
    );
  }

  _paymentdetail() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Container(
          width: Get.width / 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            color: AppColors.whitetextColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Payment details",
                    style: TextStyle(
                      color: AppColors.darktextColor,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    )),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Consultation Fee",
                        style: TextStyle(
                          color: AppColors.darktextColor,
                        )),
                    Text("Rs. $price",
                        style: TextStyle(
                            color: AppColors.darktextColor,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Coupon",
                        style: TextStyle(
                          color: AppColors.darktextColor,
                        )),
                    if (checkCouponModel.isEmpty)
                      Text("Rs. 00")
                    else
                      Text(
                          "Rs.${(((price) * ((int.parse(checkCouponModel[0].data.discount))) / 100))}",
                          style: TextStyle(
                              color: AppColors.appbarbackgroundColor,
                              fontSize: 15,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.black,
                  thickness: 1.2,
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Amount to pay",
                        style: TextStyle(
                            color: AppColors.darktextColor,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold)),
                    if (checkCouponModel.isEmpty)
                      Text("Rs. $price")
                    else
                      Text(
                          "Rs.${(price) - ((((price) * ((int.parse(checkCouponModel[0].data.discount))) / 100)))}",
                          style: TextStyle(
                              color: AppColors.darktextColor,
                              fontSize: 15,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (checkCouponModel.isEmpty)
                        Text("Rs.$price")
                      else
                        Text(
                            "Rs.${(price) - ((((price) * ((int.parse(checkCouponModel[0].data.discount))) / 100)))}",
                            style: TextStyle(
                                color: AppColors.darktextColor,
                                fontSize: 15,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold)),
                      FlatButton(
                          onPressed: () async {
                            await _consultBook();
                            print("dhsjdscd");
                            String status =
                                await SharedPrefManager.getPrefrenceString(
                                    AppConstant.STATUS);
                            print("djkdd" + status);
                            if (status == "1") {
                              Get.defaultDialog(
                                radius: 5,
                                backgroundColor: Colors.white,
                                title: 'Are you sure you want to Pay?',
                                titleStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          setState(() async {
                                            openCheckout();
                                          });
                                        },
                                        child: Center(
                                          child: Container(
                                              height: 45,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    Color(0xffED816E),
                                                    Color(0xffB93342),
                                                    // Colors.red.shade500,
                                                    // AppColors.redColor,
                                                  ]),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
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
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    Color(0xffED816E),
                                                    Color(0xffB93342),
                                                    // Colors.red.shade500,
                                                    // AppColors.redColor,
                                                  ]),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
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
                            } else {}
                          },
                          child: CustomButton(
                              text1: "",
                              text2: "Pay Now",
                              width: 150,
                              height: 50)),
                    ])
              ],
            ),
          )),
    );
  }
}
