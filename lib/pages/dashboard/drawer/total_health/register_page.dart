import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/payment_successful_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          centerTitle: true,
          title: Text(
            Strings.REGISTERTITLE,
            style: StringsStyle.pagetitlestyle,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _card(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(Strings.REGISTERHEAD,
                                style: StringsStyle.registerheadstyle),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(children: [
                              _usernametxtfield(),
                              SizedBox(height: 15),
                              _phonenumbertxtfield(),
                              SizedBox(height: 15),
                              _idtxtfield(),
                              SizedBox(height: 15),
                              _gendertxtfield(),
                              SizedBox(height: 15),
                              _dateofbirthtxtfield(),
                              SizedBox(height: 50),
                              _registerbutton(),
                            ]),
                          )
                        ])))));
  }

  _card() {
    return SizedBox(
      width: Get.width,
      child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Get online\nconsultation\nat your",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.appbarbackgroundColor)),
                    SizedBox(height: 5),
                    Text("#Home",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColors.appbarbackgroundColor)),
                  ],
                ),
                Container(
                  height: 140,
                    width: 180,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/register.png"),
                            fit: BoxFit.cover))),
              ],
            ),
          )),
    );
  }

  _usernametxtfield() {
    return Container(
        height: 50,
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
            Colors.white,
            Colors.white54,
          ]),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: "Name",
            labelStyle: TextStyle(
              color: AppColors.lighttextColor,
              fontSize: 14,
            ),
          ),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Please, enter your name";
            }

            return null;
          },
        ));
  }

  _idtxtfield() {
    return Container(
        height: 50,
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
            Colors.white,
            Colors.white54,
          ]),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: "Email Id",
            labelStyle: TextStyle(
              color: AppColors.lighttextColor,
              fontSize: 14,
            ),
          ),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Please, enter your emailid";
            }

            return null;
          },
        ));
  }

  _phonenumbertxtfield() {
    return Container(
        height: 50,
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
            Colors.white,
            Colors.white54,
          ]),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          keyboardType: TextInputType.number,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: "Mobile number",
            labelStyle: TextStyle(
              color: AppColors.lighttextColor,
              fontSize: 14,
            ),
          ),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Please, enter your mobile number";
            }
            if (value.trim().length < 10) {
              return "mobile number have must be atleast 10 digits";
            }
            return null;
          },
        ));
  }

  _gendertxtfield() {
    return Container(
        height: 50,
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
            Colors.white,
            Colors.white54,
          ]),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: "Gender",
            labelStyle: TextStyle(
              color: AppColors.lighttextColor,
              fontSize: 14,
            ),
          ),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Please, enter your gender";
            }

            return null;
          },
        ));
  }

  _dateofbirthtxtfield() {
    return Container(
        height: 50,
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
            Colors.white,
            Colors.white54,
          ]),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: "Date Of Birth",
            labelStyle: TextStyle(
              color: AppColors.lighttextColor,
              fontSize: 14,
            ),
          ),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Please, enter your date of birth";
            }

            return null;
          },
        ));
  }

  _registerbutton() {
    // ignore: deprecated_member_use
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              Get.off(PaymentSuccessfulPage(),
                  transition: Transition.zoom,
                  curve: Curves.bounceInOut,
                  duration: Duration(milliseconds: 600));
            }
          },
          child: CustomButton(
              text1: "", text2: "Pay Now", width: Get.width, height: 50)),
    );
  }
}
