// @dart=2.9

import 'dart:convert';

import 'package:aec_medical/model/courseModel/buycourse_model.dart';
import 'package:aec_medical/model/courseModel/coursepayment_model.dart';
import 'package:aec_medical/model/courseModel/courses_model.dart';
import 'package:aec_medical/model/courseModel/mycoursesModel/mycourses_model.dart';
import 'package:aec_medical/model/courseModel/mycoursesModel/videos_model.dart';
import 'package:aec_medical/model/homeModel/Counselling/allCounseleing_model.dart';
import 'package:aec_medical/model/homeModel/Counselling/buy_counselling_model.dart';
import 'package:aec_medical/model/homeModel/Counselling/counselling_verify_model.dart';
import 'package:aec_medical/model/homeModel/Counselling/newCounselling_model.dart';
import 'package:aec_medical/model/homeModel/Counselling/oldCounselling_model.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/payment_successful_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../AppConstant.dart';
import '../AppUrlConstant.dart';
import '../sharedprefrence.dart';
import 'package:get/get.dart' as gets;

class CounsellingRepo extends ChangeNotifier{

  /// All Counselling  ////////////////////////////////////////////////////

  Future<List<AllCounselingData>> counsellingApi(String doctorId) async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    //String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List<AllCounselingData> allCounselingData;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
        'dr_id': doctorId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.doctorCounseling, data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        allCounselingData = list.map((data) => new AllCounselingData.fromJson(data)).toList();
        print("hhdwdjdkhd" + list.toString());
        print("gdgd" + allCounselingData[0].title);
        return allCounselingData;
      }
    } catch (e) {
      print(e);
    }
  }


  ///  buyCounseling //////////////////////////////////////////////////////

  Future<List<BuyCounselingModel>> buyCounselingApi(String drcounselingId,amount) async {
    String customerId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    // String storeId = await SharedPrefManager.getPrefrenceString(AppConstant.STOREID);

    List<BuyCounselingModel> buyCounselingModel = [];
    List list;
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': customerId,
        'dr_counseling_id': drcounselingId,
        'amount': amount,
      });
      print("jjjjjjjj"+formData.fields.toString());
      final response = await dio.post(AppUrlConstant.baseUrlUser + AppUrlConstant.buyCounseling,data: formData);
      print("kkkjjjj");
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"+list[0]['msg']);
        print(list);
        await SharedPrefManager.savePrefString(AppConstant.STATUS,list[0]['status'].toString());
        String st = await SharedPrefManager.getPrefrenceString(AppConstant.STATUS);
        print("hsdksa"+st);
        if (list[0]['status'] == 1) {
          buyCounselingModel = list.map((data) => new BuyCounselingModel.fromJson(data)).toList();
          await SharedPrefManager.savePrefString(AppConstant.BUYCOUNSELLINGID, buyCounselingModel[0].data.buyCounselingId.toString());
          String buyId = await SharedPrefManager.getPrefrenceString(AppConstant.BUYCOUNSELLINGID);
          print("djhss"+buyId);
          print("djhss"+ buyCounselingModel[0].data.buyCounselingId.toString());
          // Fluttertoast.showToast(msg: buyCounselingModel[0].msg,
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
        } else {
          print("bjdshfk");
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          // return checkCouponModel;
        }
        return buyCounselingModel;
      }
    } catch (e) {
      print(e);
    }
  }

  /// counselingVerify ////////////////////////////////////////////

  Future<List<CounselingVerifyModel>> counselingVerifyApi(var razorpaypaymentId) async {
    String customerId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    String buycounsellingID = await SharedPrefManager.getPrefrenceString(AppConstant.BUYCOUNSELLINGID);
    List<CounselingVerifyModel> counselingVerifyModel = [];
    List list;
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': customerId,
        'buy_counseling_id': buycounsellingID,
        'razorpay_payment_id': razorpaypaymentId,
      });
      print(formData.fields);
      final response = await dio.post(AppUrlConstant.baseUrlUser + AppUrlConstant.counselingVerify,data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
          print("dsjdsxxx"+list[0]['msg']);
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);

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
    }
  }


  /// newCounseling  ////////////////////////////////////////////////////

  Future<List<NewCounselingData>> newCounselingApi() async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List<NewCounselingData> newCounselingData;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.newCounseling, data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        newCounselingData = list.map((data) => new NewCounselingData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + newCounselingData[0].title);
        return newCounselingData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// oldCounseling  ////////////////////////////////////////////////////

  Future<List<OldCounselingData>> oldCounselingApi() async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List<OldCounselingData> oldCounselingData;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.oldCounseling, data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        oldCounselingData = list.map((data) => new OldCounselingData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + oldCounselingData[0].title);
        return oldCounselingData;
      }
    } catch (e) {
      print(e);
    }
  }

}