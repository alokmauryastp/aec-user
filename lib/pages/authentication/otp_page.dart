import 'dart:async';

import 'package:aec_medical/api/repository/auth_repo.dart';
import 'package:aec_medical/pages/prefferred_language_picker/prefferred_langauge_picker_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();

  var mobileno= Get.arguments;

  var pincode ;
  bool _isLoad = false;


  void _trySubmit()async{
    if(pincode!=null){
      setState(() {
        _isLoad = true;
      });
      AuthRepo authRepo = new AuthRepo();
      await authRepo.loginotpVeriryApi(mobileno,pincode);
      setState(() {
        _isLoad = false;
      });
    }
  }

  void _resendOtp()async{
    setState(() {
      _isLoad = true;
    });
    AuthRepo authRepo = new AuthRepo();
    authRepo.resendOtpApi(mobileno);
    setState(() {
      _isLoad = false;
    });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 20,),
                _logo(),
                SizedBox(height: 50),
                _welcometext(),
                SizedBox(height: 30),
                _otpfield(),
                SizedBox(height: 5,),
                if(_isLoad)
                  CircularProgressIndicator()
                else _continuebutton(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: Text("Resend code",
                          style: TextStyle(
                              color: AppColors.appbarbackgroundColor)),
                      onPressed: _resendOtp,
                    ),
                    FlatButton(
                      child: Text("Change number",
                          style: TextStyle(
                              color: AppColors.appbarbackgroundColor)),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  _logo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 5),
        Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png")))),
        Text(
          Strings.LOGO_TITLE,
          style: StringsStyle.redlogotitlestyle,
        ),
      ],
    );
  }

  _welcometext() {
    return Column(
      children: [
        SizedBox(height: 100),
        Text(
          Strings.OTPPAGE_HEADLINE1,
          style: StringsStyle.otpheadline1style,
        ),
        SizedBox(height: 5),
        Text(
          Strings.OTPPAGE_HEADLINE2,
          style: StringsStyle.otpheadline2style,
        ),
      ],
    );
  }

  _otpfield() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 50,
          width: Get.width,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 30,
              style: TextStyle(
                  fontSize: 17
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onChanged: (pin) {
                print("Changed: " + pin);
              },

              onCompleted: (pin) {
                pincode=pin;
                print("Completed: " + pin);
                print("pincode"+pincode);
              },
            ),
          ),
        ),
      ),
    );
  }

  _continuebutton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: _trySubmit,
        child: Container(
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
              Color(0xffED816E),
              Color(0xffB93342),
              // Colors.red.shade500,
              // AppColors.redColor,
            ]),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 50,
          width: Get.width,
          child: Center(
            child: Text("Continue",
                style: TextStyle(
                  color: AppColors.whitetextColor,
                  fontSize: 15,
                  letterSpacing: 0.5,
                )),
          ),
        ),
      ),
    );
  }
}
