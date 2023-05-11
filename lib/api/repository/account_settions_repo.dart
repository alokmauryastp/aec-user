// @dart=2.9

import 'dart:convert';
import 'package:aec_medical/model/tpa_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../AppUrlConstant.dart';

class AccountSettingsRepo extends ChangeNotifier {


  /// termand condition , privacy policy, aboutus ////////////////////////////////////////////

  Future<List<TPAModel>> tpaApi() async {
    List<TPAModel> tPAModel = [];
    List list;
    Dio dio = Dio();
    try {
      final response = await dio.get(AppUrlConstant.baseUrlUser + AppUrlConstant.webView);
      print("hhkhjk");
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
          tPAModel = list.map((data) => new TPAModel.fromJson(data)).toList();
          // Fluttertoast.showToast(msg: list[0]['msg'],
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
      return tPAModel;
    } catch (e) {
      print(e);
    }
  }
}