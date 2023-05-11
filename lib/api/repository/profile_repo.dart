// @dart=2.9

import 'dart:convert';

import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/base/api_response.dart';
import 'package:aec_medical/api/exception/api_error_handler.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/model/profilemodel/getprofile_model.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as gets;
// import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import '../AppUrlConstant.dart';

class ProfileRepo extends ChangeNotifier {


  /// get profile ///////////////////////////////////////////////////////

  Future<List<GetProfileModel>> getproifileApi() async {

    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);

    List list;
    List<GetProfileModel> getProfileModel;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.getprofile, data: formData);
      if (response.statusCode == 200) {
        // print("getproifileApi"+response.data);
        list = jsonDecode(response.data);
        getProfileModel = list.map((data) => new GetProfileModel.fromJson(data)).toList();
        // print(list);
        if (list[0]['status'] == 1) {
          // Fluttertoast.showToast(msg: list[0]['msg'],
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
          // print("dataaaaa"+getProfileModel[0].data.mobile);
          // print("status Code : " + list[0]['status'] .toString());
          // print("Massage : " + list[0]['msg'].toString());
        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print(response.data[0]['msg'].toString());
        }
       }
      return getProfileModel;
    } catch (e) {
      print(e);
    }
  }






  /// update profile ////////////////////////////////////////////////////

  Future<ApiResponse> updateproifileApi(String name , String gender ,String mobile , String email ,
      var dob , String bloodgroup , String marritalstatus , String height , String weight , String alternatecontact , String address) async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'userid': userId,
        'name': name,
        'gender':gender,
        'mobile': mobile,
        'email': email,
        'dob': dob,
        'blood_group': bloodgroup,
        'marrital_status': marritalstatus,
        'height': height,
        'weight': weight,
        'alternate_contact': alternatecontact,
        'address': address
      });
      print("hhkhjxsxsk");
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.updateprofile, data: formData);
      print("hhkhjk");
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
          //gets.Get.to(ProfilePage());
          gets.Get.back();
          gets.Get.snackbar("Profile Updated", "Profile changes saved!",
              backgroundColor: AppColors.whitetextColor,
              borderRadius: 10,
              boxShadows: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ],
              snackPosition: SnackPosition.TOP,
              margin: EdgeInsets.all(10),
              colorText: AppColors.appbarbackgroundColor,
              forwardAnimationCurve: Curves.bounceInOut);
          getproifileApi();
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
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  /// update profile Image ////////////////////////////////////////////////////

  Future<MultipartFile> uploadProfileImageApi(String filename) async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
        'profile': filename});

      print("xxxxxxxxxxxxxxxxxxxx"+formData.fields.toString());
      Response response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.uploadProfileImage, data: formData);

      print("ghgghghhggh"+response.toString());
      if (response.statusCode == 200) {
        print(response.data);
        print("dhdjfhdfj");
      }

    } catch (e) {
      print(e);
    }
  }

}