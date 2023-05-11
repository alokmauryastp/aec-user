// @dart=2.9

import 'dart:convert';

import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/base/api_response.dart';
import 'package:aec_medical/api/exception/api_error_handler.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/model/bestcounselor_model.dart';
import 'package:aec_medical/model/homeModel/Counselling/blog_model.dart';
import 'package:aec_medical/model/homeModel/notification_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../AppUrlConstant.dart';

class HomeRepo extends ChangeNotifier {


  /// blog api  ///////////////////////////////////////////////////////

  Future<List<BlogData>> blogApi() async {
    List list;
    List<BlogData> blogData;
    Dio dio = Dio();
    try {
      final response = await dio.get(
          AppUrlConstant.baseUrlUser + AppUrlConstant.blog);
      print("hhkhjk");
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        blogData = list.map((data) => new BlogData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + blogData[0].title);
        // Fluttertoast.showToast(msg: blogData[0].author,
        //           toastLength: Toast.LENGTH_SHORT,
        //           gravity: ToastGravity.CENTER,
        //           backgroundColor: Colors.black,
        //           textColor: Colors.white);
        // if (list[0]['status'] == 1) {
        //   // Fluttertoast.showToast(msg: list[0]['msg'],
        //   //     toastLength: Toast.LENGTH_SHORT,
        //   //     gravity: ToastGravity.CENTER,
        //   //     backgroundColor: Colors.black,
        //   //     textColor: Colors.white);
        //   print("isi"+sliderData[0].title.toString());
        //   print("status Code : " + list[0]['status'].toString());
        //   print("Massage : " + list[0]['msg'].toString());
        //   print("gdhd"+sliderData[0].image);
        // } else {
        //   Fluttertoast.showToast(msg: list[0]['msg'],
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.CENTER,
        //       backgroundColor: Colors.black,
        //       textColor: Colors.white);
        //   print(response.data[0]['msg'].toString());
        // }
        return blogData;
      }
    } catch (e) {
      print(e);
    }
  }


  /// Update token api  ///////////////////////////////

  Future updateTokenApi() async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    String token = await SharedPrefManager.getPrefrenceString(AppConstant.FCMTOKEN);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
        'Token': token,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.updateToken, data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
          // Fluttertoast.showToast(msg: list[0]['msg'],
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
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
    }
  }


  /// checkUserAccount api ///////////////////////////////

  Future<ApiResponse> checkUserAccountApi() async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.checkUserAccount, data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
          // Fluttertoast.showToast(msg: list[0]['msg'],
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
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

  /// notification ////////////////////////////////////////////////////

  Future<List<NotificationData>> notificationApi() async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List list;
    List<NotificationData> notificationData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
      });
      print('notificationApi');
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.notification, data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        notificationData = list.map((data) => new NotificationData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + notificationData[0].message);
        return notificationData;
      }
    } catch (e) {
      print(e);
    }
  }


  /// bestCounselor ////////////////////////////////////////////////////

  Future<List<BestCounselorData>> bestCounselorApi() async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List list;
    List<BestCounselorData> bestCounselorData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.bestCounselor, data: formData);
      if (response.statusCode == 200) {
        print("dsfssds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        bestCounselorData = list.map((data) => new BestCounselorData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + bestCounselorData[0].name);
        return bestCounselorData;
      }
    } catch (e) {
      print(e);
    }
  }



  /// healthConceptVideo api  ///////////////////////////////////////////////////////

  Future<String> healthConceptVideoApi() async {
    List list;
    var v;
    Dio dio = Dio();
    try {
      final response = await dio.get(
          AppUrlConstant.baseUrlUser + AppUrlConstant.healthConceptVideo);
      print("hhkhjk");
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        v = list[0]['data']['Video'];
        print("hhdhdssssss" + v.toString());

        await SharedPrefManager.savePrefString(AppConstant.HEALTHCONCEPTVIDEO, v.toString());
      }
    } catch (e) {
      print(e);
    }
  }

}
