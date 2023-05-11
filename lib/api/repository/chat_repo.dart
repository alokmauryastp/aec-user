// @dart=2.9

import 'dart:convert';

import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/base/api_response.dart';
import 'package:aec_medical/api/exception/api_error_handler.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/model/consultationModel/chatModel/getchat_model.dart';
import 'package:aec_medical/model/consultationModel/chatModel/messagecount_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../AppUrlConstant.dart';

class ChatRepo extends ChangeNotifier {


  /// showChat api  ///////////////////////////////////////////////////////

  List<GetChatData> getChatData;

  Future<List<GetChatData>> getChatApi() async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    String consultId = await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);

    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'consult_id': consultId,
        'user_id': userId,
      });
      print(formData.fields);
      final response = await dio.post(AppUrlConstant.baseUrlUser + AppUrlConstant.showChat,data: formData);
      // print(response.data);
      if (response.statusCode == 200) {

        list = jsonDecode(response.data);
        // print("getChatApi");
        // Fluttertoast.showToast(msg: list[0]['msg'],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
        list = list[0]['data'];

        // print("dhsdj"+list.toString());
        getChatData = list.map((data) => new GetChatData.fromJson(data)).toList();

       // await SharedPrefManager.savePrefString(AppConstant.PROFILE, getChatData[0].doctorImage);
        return getChatData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// saveDoctorChatMessage api  ///////////////////////////////////////////////////////

  Future<ApiResponse> saveDoctorChatMessageApi(String message, String image) async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    String consultId = await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);
    List list;
    Dio dio = Dio();
    try {

      FormData formData = new FormData.fromMap({
        'message': message,
        'consult_id': consultId,
        'user_id': userId,
        'image': image});

      print(formData.fields);
      print("hdks");
      final response = await dio.post(AppUrlConstant.baseUrlUser + AppUrlConstant.saveUserChatMessage,data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("sssssdf"+list.toString());
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



  /// checkMesagesCount ///////////////////////////////////////////////////////

  Future<List<MessageCountModel>> checkMesagesCountApi() async {
    String consultId = await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);

    List list;
    List<MessageCountModel> messageCountModel;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'consult_id': consultId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.checkMesagesCount, data: formData);
      print("hhkhjk");
      if (response.statusCode == 200) {
        print("dsfds"+response.data);
        list = jsonDecode(response.data);
        messageCountModel = list.map((data) => new MessageCountModel.fromJson(data)).toList();
        print(list);
        if (list[0]['status'] == 1) {
          // Fluttertoast.showToast(msg: list[0]['msg'],
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
          print("dataaaaa"+messageCountModel[0].data.num.toString());
          print("status Code : " + list[0]['status'] .toString());
          print("Massage : " + list[0]['msg'].toString());
        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print(response.data[0]['msg'].toString());
        }
      }
      return messageCountModel;
    } catch (e) {
      print(e);
    }
  }

  /// callingApi ///////////////////////////////////////////////////////

  Future<List<MessageCountModel>> callingApi(consultId,callStatus) async {

    List list;
    List<MessageCountModel> messageCountModel;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'consult_id': consultId,
        'call_status': callStatus,
      });
      print(formData.fields);
      final response = await dio.post(
          'https://apolloeclinic.com/API/V1/Doctor/updateCallStatus', data: formData);
      print("callingApi");
      if (response.statusCode == 200) {
        print("callingApi"+response.data);
        list = jsonDecode(response.data);
        messageCountModel = list.map((data) => new MessageCountModel.fromJson(data)).toList();
        print(list);
        if (list[0]['status'] == 1) {
          // Fluttertoast.showToast(msg: list[0]['msg'],
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
          print("dataaaaa"+messageCountModel[0].data.num.toString());
          print("status Code : " + list[0]['status'] .toString());
          print("Massage : " + list[0]['msg'].toString());
        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print(response.data[0]['msg'].toString());
        }
      }
      return messageCountModel;
    } catch (e) {
      print(e);
    }
  }
}