import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/counselling_repo.dart';
import 'package:aec_medical/api/repository/home_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/homeModel/Counselling/blog_model.dart';
import 'package:aec_medical/model/homeModel/Counselling/allCounseleing_model.dart';
import 'package:aec_medical/model/homeModel/Counselling/buy_counselling_model.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/healthquestions_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/payment_successful_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/register_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:aec_medical/utils/webview_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'health_blogs_tips_page.dart';
import 'health_description_page.dart';
import 'totalhealthquestion_page.dart';
import 'totalhealthscore_result_page.dart';

class RazorPayPage extends StatefulWidget {
  const RazorPayPage({Key? key}) : super(key: key);

  @override
  _RazorPayPageState createState() => _RazorPayPageState();
}

class _RazorPayPageState extends State<RazorPayPage> {

  var pricepay = Get.arguments;


  List<BuyCounselingModel> buyCounselingModel = [];


  bool _isLoad = false;

  late Razorpay _razorpay;
  late Future future;


  @override
  void initState() {
    super.initState();
   setState(() async{
    await openCheckout();
   });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  static const platform = const MethodChannel("razorpay_flutter");




  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

   openCheckout() async {
    var options = {
      'key': 'rzp_test_vQOXAJXDVlhsQ4',
      'amount': ((int.parse(pricepay.offerPrice))*100),
      'name': 'AEC_App.',
      'description': pricepay.name.toString(),
      'prefill': {'contact': '8650965058', 'email': 'rajeev.kumar@aaratechnologies.in'},
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    var paymentid = response.paymentId;
    var orderId = response.orderId;
    print("sghgjaks"+paymentid.toString());
    Get.defaultDialog(
      radius: 5,
      backgroundColor: Colors.white,
      title: 'Your payment Successful.',
      titleStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold),
      content: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceAround,
        children: [
          if(_isLoad)
            CircularProgressIndicator()
          else InkWell(
              onTap: () async{
                setState(() {
                  // _trySubmit();
                  Get.offAll(PaymentSuccessfulPage1(),arguments: [paymentid,orderId,pricepay],
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 600));
                });
              },
              child: Center(
                child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius:
                        BorderRadius.circular(
                            20)),
                    child: Center(
                        child: Text(
                          "OK",
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
            "RazorPay",
            style: StringsStyle.pagetitlestyle,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
        ),
    );
  }
}
