// @dart=2.9
import 'dart:convert';

import 'package:aec_medical/api/base/api_response.dart';
import 'package:aec_medical/api/exception/api_error_handler.dart';
import 'package:aec_medical/model/authmodel/googlelogin_model.dart';
import 'package:aec_medical/model/authmodel/loginotpverify_model.dart';
import 'package:aec_medical/model/homeModel/healthScoreResult_model.dart';
import 'package:aec_medical/model/homeModel/totalHealthquestion_model.dart';
import 'package:aec_medical/pages/authentication/otp_page.dart';
import 'package:aec_medical/pages/dashboard/bottom_navigation_bar_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/totalhealthscore_result_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get.dart' as gets;

import '../AppConstant.dart';
import '../AppUrlConstant.dart';
import '../sharedprefrence.dart';
class AuthRepo extends ChangeNotifier {

  static bool kTry = true;

  ///  Login with otp API ///////////////////////////////////////////////////

  Future loginWithOtp(String mobile) async {
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'mobile': mobile,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.loginwithotp, data: formData);
      print("hhkhjk");
      print("dsfds"+response.data);

      if (response.statusCode == 200) {
        print("dsfds"+response.data);
        list = jsonDecode(response.data);
        print(list);
        if (list[0]['status'] == 1) {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("status Code : " + list[0]['status'] .toString());
          print("Massage : " + list[0]['msg'].toString());
          gets.Get.to(OtpPage(), arguments: mobile,
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));
        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print(response.data[0]['msg'].toString());
        }
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  /// login otp verify /////////////////////////////////////////

  Future<List<LoginOtpVerifyModel>> loginotpVeriryApi(String mobile, String pincode) async {
    List<LoginOtpVerifyModel> otpVerifyModel=[];
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'mobile': mobile,
        'OTP': pincode,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.loginotpverify, data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
         otpVerifyModel = list.map((data) => new LoginOtpVerifyModel.fromJson(data)).toList();
        if (otpVerifyModel[0].status == 1) {
             await SharedPrefManager.savePreferenceBoolean(true);
             await SharedPrefManager.savePrefString(AppConstant.MOBILE, otpVerifyModel[0].data.mobile);
             await SharedPrefManager.savePrefString(AppConstant.CUSTOMERId, otpVerifyModel[0].data.userId);
             await SharedPrefManager.savePrefString(AppConstant.IMAGE, otpVerifyModel[0].data.profile);

          Fluttertoast.showToast(msg: otpVerifyModel[0].msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("Status Code : " + otpVerifyModel[0].status.toString());
          print("Massage : " + otpVerifyModel[0].msg.toString());
             gets.Get.offAll(BottomNavigationBarPage(),
                 transition: Transition.rightToLeftWithFade,
                 duration: Duration(milliseconds: 600));
        }
        }
      return otpVerifyModel;
    } catch (e) {
      // Fluttertoast.showToast(msg: "Something went wrong",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white);
      print(e);
    }
  }

  /// resend api ///////////////////////////////

  Future<ApiResponse> resendOtpApi(String mobile) async {
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'mobile': mobile,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.resendOtp, data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("Status Code : " + list[0]['status'].toString());
          print("Massage : " + list[0]['msg'].toString());
          } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
    } catch (e) {
      print(e);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// google Login /////////////////////////////////////////

  Future<List<GoogleLoginModel>> googleLoginApi() async {
    String name = await SharedPrefManager.getPrefrenceString(AppConstant.NAME);
    String email = await SharedPrefManager.getPrefrenceString(AppConstant.EMAIL);
    String picture = await SharedPrefManager.getPrefrenceString(AppConstant.IMAGE);

    print("namess"+name);
    print("emailss"+email);
    print("picturess"+picture);
    List<GoogleLoginModel> googleLoginModel=[];
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'name': name,
        'email': email,
        'picture': picture
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.googleLogin, data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("shjkl"+list.toString());
        print(list[0]['status'].toString());
        if (list[0]['status'].toString() == "1") {
          googleLoginModel = list.map((data) => new GoogleLoginModel.fromJson(data)).toList();
          await SharedPrefManager.savePreferenceBoolean(true);
          await SharedPrefManager.savePrefString(AppConstant.MOBILE, googleLoginModel[0].data.mobile);
          await SharedPrefManager.savePrefString(AppConstant.CUSTOMERId, googleLoginModel[0].data.userId);
          await SharedPrefManager.savePrefString(AppConstant.IMAGE, googleLoginModel[0].data.profile);
          Fluttertoast.showToast(msg: googleLoginModel[0].msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("Status Code : " + googleLoginModel[0].status.toString());
          print("Massage : " + googleLoginModel[0].msg.toString());
          gets.Get.offAll(BottomNavigationBarPage(),
              duration: Duration(milliseconds: 600));
        } else {
          Fluttertoast.showToast(msg: "Your account blocked by admin.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
      return googleLoginModel;
    } catch (e) {
      print(e);
    }
  }


  /// totalhealthquestion api  ///////////////////////////////////////////////////////

  Future<List<HealthScoreQuestionData>> healthScoreQuestionApi() async {
    List list;
    List<HealthScoreQuestionData> healthScoreQuestionData;
    Dio dio = Dio();
    try {
      final response = await dio.get(
          AppUrlConstant.baseUrlUser + AppUrlConstant.healthScoreQuestion);
      print("hhkhjk");
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        healthScoreQuestionData = list.map((data) => new HealthScoreQuestionData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + healthScoreQuestionData[0].questionId);
        return healthScoreQuestionData;
      }
    } catch (e) {
      print(e);
    }
  }
  /// getDistrict api  ///////////////////////////////////////////////////////

  Future<List> getDistrict() async {
    List list;
    Dio dio = Dio();
    try {
      final response = await dio.get(
          AppUrlConstant.baseUrlUser + AppUrlConstant.getDistrict);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        list = list[0]['data'];
        // cityModel = list.map((data) => new CityModel.fromJson(data)).toList();
        // print("gdgd" + cityModel[0].data[0].district);
        return list;
      }
    } catch (e) {
      print(e);
    }
  }

  /// healthScoreResult /////////////////////////////////////////

  Future<List<HealthScoreResultModel>> healthScoreResultApi(String name, String age,gender) async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    String mobiletoken = await SharedPrefManager.getPrefrenceString(AppConstant.MOBILTOKEN);
    String answernumber = await SharedPrefManager.getPrefrenceString(AppConstant.ANSWERNUMBER);
    List<HealthScoreResultModel> healthScoreResultModel=[];
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'mobiletoken': mobiletoken,
        'userid': userId,
        'answernumber': answernumber,
        'name': name,
        'age': age,
        'gender': gender,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.healthScoreResult, data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("hdsdbksj"+list.toString());
        healthScoreResultModel = list.map((data) => new HealthScoreResultModel.fromJson(data)).toList();
        if (healthScoreResultModel[0].status == 1) {
          gets.Get.off(HealthScoreResultPage(),arguments: healthScoreResultModel,
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));
          print("gvvdj"+healthScoreResultModel[0].data.name);
          Fluttertoast.showToast(msg: healthScoreResultModel[0].msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("Status Code : " + healthScoreResultModel[0].status.toString());
          print("Massage : " + healthScoreResultModel[0].msg.toString());
        } else {
          Fluttertoast.showToast(msg: healthScoreResultModel[0].msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
      return healthScoreResultModel;
    } catch (e) {
      print(e);
    }
  }



}