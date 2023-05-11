import 'dart:async';

import 'package:aec_medical/api/repository/consultation_repo.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/consultationModel/booking_payment_model.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bottom_navigation_bar_page.dart';
import '../notification_page.dart';
import 'medical_history_page.dart';

class PaymentConfirmedPage extends StatefulWidget {
  const PaymentConfirmedPage({Key? key}) : super(key: key);

  @override
  _PaymentConfirmedPageState createState() => _PaymentConfirmedPageState();
}

class _PaymentConfirmedPageState extends State<PaymentConfirmedPage> {

  List<BookingPaymentModel> bookingPaymentModel = [];

  var d = Get.arguments;

  late var paymentId = d[0];
  late var orderId = d[1];
  late var price = d[2];


  @override
  void initState() {
    super.initState();
    ConsultationRepo consultationRepo = new ConsultationRepo();
    print("orderid");
    print(orderId);
    Future future= consultationRepo.bookingPaymentApi(paymentId, orderId,);
    future.then((value){
      setState(() {
        bookingPaymentModel = value;
      });
      print("fffffffffffffssffff"+bookingPaymentModel[0].data.time);
    });

    Timer(Duration(seconds: 5), (){
      print('gotoMedicalHistoryPage');

      Get.to(MedicalHistoryPage(),
          transition: Transition.rightToLeftWithFade,
          duration: Duration(milliseconds: 600));
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined,
                  size: 30, color: AppColors.appbarbackgroundColor)),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(NotificationPage(),
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 600));
                },
                icon: Icon(Icons.notifications,
                    size: 30, color: AppColors.appbarbackgroundColor)),
          ],
        ),
        body: SingleChildScrollView(
            child: bookingPaymentModel.isEmpty?Padding(
              padding: const EdgeInsets.only(top:30.0),
              child: Center(child: CircularProgressIndicator()),
            ):Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            _paymentconfirmation(),
            SizedBox(height: 60),
            _timeofconsultation(),
            SizedBox(height: 50),
            Text(
              "Consultation Fee:  Rs."+price.toString(),
              style: TextStyle(
                color: AppColors.appbarbackgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.3,
              ),
            ),

            SizedBox(height: 10),
            Text(
              "Transaction Id: "+paymentId,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                letterSpacing: 0.3,
              ),
            ),
            // SizedBox(height: 10),
            // Row(
            //   children: [
            //     Icon(Icons.location_on_outlined,
            //         color: AppColors.lighttextColor, size: 20),
            //     Text(
            //       "Fortis escorts jaipur.",
            //       style: TextStyle(
            //         color: AppColors.lighttextColor,
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 5),
            Divider(),
            SizedBox(height: 5),
            Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/paymentimage.png")))),
            SizedBox(height: 10),
            _medicalhistorypage(),
            SizedBox(height: 10),
          ]),
        )));
  }

  _paymentconfirmation() {
    return Row(children: [
      Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/paymentsuccess.png"),
                  fit: BoxFit.cover))),
      SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Confirmed!",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 3),
          Text(
            "Dr. ${bookingPaymentModel[0].data.doctor} will connect you soon",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.appbarbackgroundColor),
          ),
        ],
      )
    ]);
  }

  _timeofconsultation() {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 50),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Date: ${bookingPaymentModel[0].data.date}",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 2),
              Text("Time: ${bookingPaymentModel[0].data.time}",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: AppColors.appbarbackgroundColor),
              ),
            ]),
          ),
        ));
  }

  _medicalhistorypage() {
    // ignore: deprecated_member_use
    return FlatButton(
        onPressed: () {

          Get.to(MedicalHistoryPage(),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));
        },
        child: CustomButton(
            text1: "",
            text2: "Continue",
            width: Get.width,
            height: 50));
  }
}
