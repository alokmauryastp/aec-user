// @dart=2.9

import 'dart:convert';

import 'package:aec_medical/model/courseModel/buycourse_model.dart';
import 'package:aec_medical/model/courseModel/coursepayment_model.dart';
import 'package:aec_medical/model/courseModel/courses_model.dart';
import 'package:aec_medical/model/courseModel/mycoursesModel/course_counselling_model.dart';
import 'package:aec_medical/model/courseModel/mycoursesModel/mycourses_model.dart';
import 'package:aec_medical/model/courseModel/mycoursesModel/videos_model.dart';
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

class CoursesRepo extends ChangeNotifier{

  /// courses ////////////////////////////////////////////////////

  Future<List<CoursesData>> coursesApi() async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List<CoursesData> coursesData;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.courses, data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        coursesData = list.map((data) => new CoursesData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + coursesData[0].title);
        return coursesData;
      }
    } catch (e) {
      print(e);
    }
  }

  ///  buy course //////////////////////////////////////////////////////

  Future<List<BuyCourseModel>> buycourseApi(String courseId) async {
    String customerId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
   // String storeId = await SharedPrefManager.getPrefrenceString(AppConstant.STOREID);

    List<BuyCourseModel> buyCourseModel = [];
    List list;
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': customerId,
        'CourseId': courseId,
      });
      print("jjjjjjjj"+formData.fields.toString());
      final response = await dio.post(AppUrlConstant.baseUrlUser + AppUrlConstant.buyCourse,data: formData);
      print("kkkjjjj");
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"+list[0]['msg']);
        print(list);
        await SharedPrefManager.savePrefString(AppConstant.STATUS,list[0]['status'].toString());
        String st = await SharedPrefManager.getPrefrenceString(AppConstant.STATUS);
        print("hsdksa"+st);
        if (list[0]['status'] == 1) {
          buyCourseModel = list.map((data) => new BuyCourseModel.fromJson(data)).toList();
          await SharedPrefManager.savePrefString(AppConstant.BUYID, buyCourseModel[0].data.buyId.toString());
          String buyId = await SharedPrefManager.getPrefrenceString(AppConstant.BUYID);
          print("djhss"+buyId);
          // Fluttertoast.showToast(msg: buyCourseModel[0].msg,
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
        return buyCourseModel;
      }
    } catch (e) {
      print(e);
    }
  }


 /// coursePayment ////////////////////////////////////////////

  Future<List<CoursePaymentModel>> coursepaymentApi(var paymentId,var orderId) async {
    String customerId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    String buyId = await SharedPrefManager.getPrefrenceString(AppConstant.BUYID.toString());
    List<CoursePaymentModel> coursePaymentModel = [];
    List list;
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': customerId,
        'RazorpayPaymentId': paymentId,
        'OrderId': orderId,
        'BuyId': buyId,
      });
      print("jjjjjjjj"+formData.fields.toString());
      print(formData.fields);
      final response = await dio.post(AppUrlConstant.baseUrlUser + AppUrlConstant.coursePayment,data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
          print("dsjds");
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



  /// My courses ////////////////////////////////////////////////////

  Future<List<MyCoursesData>> mycoursesApi() async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List<MyCoursesData> myCoursesData;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.myCourse, data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        myCoursesData = list.map((data) => new MyCoursesData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + myCoursesData[0].title);
        return myCoursesData;
      }
    } catch (e) {
      print(e);
    }
  }


  /// videos ////////////////////////////////////////////////////

  Future<List<VideosData>> videoApi() async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    String buyId = await SharedPrefManager.getPrefrenceString(AppConstant.BUYID);
    List<VideosData> videosData;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
        'BuyId': buyId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.videos, data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        videosData = list.map((data) => new VideosData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + videosData[0].title);
        return videosData;
      }
    } catch (e) {
      print(e);
    }
  }




  /// courseCounseling ////////////////////////////////////////////////////

  Future<List<CourseCounselingData>> courseCounselingApi() async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    String buyId = await SharedPrefManager.getPrefrenceString(AppConstant.BUYID);
    List<CourseCounselingData> courseCounselingData;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
        'BuyId': buyId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.courseCounseling, data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        courseCounselingData = list.map((data) => new CourseCounselingData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + courseCounselingData[0].title);
        return courseCounselingData;
      }
    } catch (e) {
      print(e);
    }
  }


}