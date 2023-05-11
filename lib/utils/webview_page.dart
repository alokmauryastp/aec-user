import 'dart:async';

import 'package:aec_medical/api/repository/counselling_repo.dart';
import 'package:aec_medical/api/repository/courses_repo.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/pages/dashboard/bottom_navigation_bar_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PaymentSuccessfulPage1 extends StatefulWidget {
  const PaymentSuccessfulPage1({Key? key}) : super(key: key);

  @override
  _PaymentSuccessfulPage1State createState() => _PaymentSuccessfulPage1State();
}

class _PaymentSuccessfulPage1State extends State<PaymentSuccessfulPage1> {

  var d = Get.arguments;
  late var paymentId = d[0];
  late var orderId = d[1];
  late var courseprice = d[2];
  late Future future;

  @override
  void initState() {
    super.initState();
    CounsellingRepo counsellingRepo = new CounsellingRepo();
    future = counsellingRepo.counselingVerifyApi(paymentId);
    future.then((value){
      setState(() {
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.green[100],
                child: Center(
                  child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/paymentsuccess.png"),
                              fit: BoxFit.cover))),
                ),
              ),
              SizedBox(height: 30,),
              Center(
                child: Text("Payment Successfull",
                    style: TextStyle(
                      color: AppColors.appbarbackgroundColor,
                      fontSize: 22,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text("Payment Amount: Rs. "+courseprice,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text("Transaction Id: "+paymentId,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.bold,
                    )),
              ),

              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: InkWell(
                    onTap:(){

                      Get.offAll(BottomNavigationBarPage(selectIndex: 0,),
                          transition: Transition.rightToLeftWithFade,
                          duration: Duration(milliseconds: 600));

                    },
                    child: CustomButton(
                        text1: "", text2: "Continue", width: Get.width, height: 45)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
