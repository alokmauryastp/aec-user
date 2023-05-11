import 'dart:convert';

import 'package:aec_medical/api/AppUrlConstant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

class HealthBlogTipsDescription{

 Future<dynamic> getDescription(blogId) async {
    List responseList;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlUser + AppUrlConstant.singleDescription),
          body: {
            'BlogId': blogId,
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
       
        responseList = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: responseList[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
          

        return responseList;
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return "";
    }
  }

}