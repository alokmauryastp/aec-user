// @dart=2.9

import 'dart:convert';

import 'package:aec_medical/api/base/api_response.dart';
import 'package:aec_medical/api/exception/api_error_handler.dart';
import 'package:aec_medical/model/medicalrecordModel/showmedicalrecord_model.dart';
import 'package:aec_medical/pages/dashboard/bottom_navigation_bar_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/medical_records_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as gets;
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../AppConstant.dart';
import '../AppUrlConstant.dart';
import '../sharedprefrence.dart';

class MedicalRecordRepo extends ChangeNotifier{


  /// addMedicalRecard ////////////////////////////////////////////////////

  Future<MultipartFile> addMedicalRecardApi(String type, String disease , String description) async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    String filename = await SharedPrefManager.getPrefrenceString(AppConstant.BASE64IMAGE);
    List list;
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
        'Type': type,
        'Disease':disease,
        'Description':description,
        'Image': filename});

      print("xxxxxxxxxxxxxxxxxxxx"+formData.fields.toString());
      Response response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.addMedicalRecard, data: formData);

      print("ghgghghhggh"+response.toString());
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print(list);
        if (list[0]['status'] == 1) {
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
         gets.Get.offAll(BottomNavigationBarPage(),
             transition: Transition.rightToLeftWithFade,
             duration: Duration(milliseconds: 600));
        print(response.data);
        print("dhdjfhdfj");
      }

    } catch (e) {
      print(e);
    }
  }

  /// showMedicalRecord ////////////////////////////////////////////////////

  Future<List<ShowMedicalRecordData>> showMedicalRecordApi(String type) async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List list;
    List<ShowMedicalRecordData> showMedicalRecordData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
        'Type': type
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.showMedicalRecord, data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        // Fluttertoast.showToast(msg: list[0]['msg'],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
        list = list[0]['data'];
        showMedicalRecordData = list.map((data) => new ShowMedicalRecordData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + showMedicalRecordData[0].disease);
        return showMedicalRecordData;
      }
    } catch (e) {
      print(e);
    }
  }


  /// deleteMedicalHistory api ///////////////////////////////

  Future<ApiResponse> deleteMedicalHistoryApi(String medicalReportId) async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
        'MedicalReportId': medicalReportId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.deleteMedicalHistory, data: formData);
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


}