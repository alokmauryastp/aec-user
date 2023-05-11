// @dart=2.9

import 'dart:convert';

import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/base/api_response.dart';
import 'package:aec_medical/api/exception/api_error_handler.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/model/consultationModel/booking_payment_model.dart';
import 'package:aec_medical/model/consultationModel/consultbook_model.dart';
import 'package:aec_medical/model/consultationModel/find_doctors_model.dart';
import 'package:aec_medical/model/consultationModel/medicalhistoryanswer_model.dart';
import 'package:aec_medical/model/consultationModel/medicalhistoryquestion_model.dart';
import 'package:aec_medical/model/consultationModel/pastconsultaion_model.dart';
import 'package:aec_medical/model/consultationModel/reconsult_model.dart';
import 'package:aec_medical/model/consultationModel/slider_model.dart';
import 'package:aec_medical/model/consultationModel/speciality_model.dart';
import 'package:aec_medical/model/consultationModel/symptoms_model.dart';
import 'package:aec_medical/model/consultationModel/upcomingmyconsultation_model.dart';
import 'package:aec_medical/pages/dashboard/consultation/consultationvideo_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get.dart' as gets;
import '../AppUrlConstant.dart';

class ConsultationRepo extends ChangeNotifier {
  /// slider api  ///////////////////////////////////////////////////////

  Future<List<SliderData>> sliderApi() async {
    // String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List list;
    List<SliderData> sliderData;
    Dio dio = Dio();
    try {
      final response =
          await dio.get(AppUrlConstant.baseUrlUser + AppUrlConstant.slider);
      print("hhkhjk");
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        sliderData = list.map((data) => new SliderData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + sliderData[0].title);
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
        return sliderData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// symptoms ////////////////////////////////////////////////////

  Future<List<SymptomsData>> symptomsApi() async {
    String userId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List<SymptomsData> symptomsData;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.symptoms,
          data: formData);
      if (response.statusCode == 200) {
        print("symptomsApi" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        symptomsData =
            list.map((data) => new SymptomsData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + symptomsData[0].price);
        return symptomsData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// speciality ////////////////////////////////////////////////////

  Future<List<SpecialityData>> specialityApi() async {
    String userId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List list;
    List<SpecialityData> specialityData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.speciality,
          data: formData);

      if (response.statusCode == 200) {
        print("specialityApi" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        specialityData =
            list.map((data) => new SpecialityData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + specialityData[0].speciality);
        return specialityData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// getDoctorDetails ////////////////////////////////////////////////////

  Future<List<FindDoctorsData>> getDoctorDetailsApi() async {
    String userId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    String table = await SharedPrefManager.getPrefrenceString(
        AppConstant.TABLE.toString());
    String value = await SharedPrefManager.getPrefrenceString(
        AppConstant.VALUE.toString());
    List list;
    List<FindDoctorsData> findDoctorsData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'table': table,
        'UserId': userId,
        'value': value,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.getDoctorDetails,
          data: formData);
      if (response.statusCode == 200) {
        print("getDoctorDetailsApi" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        findDoctorsData =
            list.map((data) => new FindDoctorsData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + findDoctorsData[0].name);
        return findDoctorsData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// consultBook /////////////////////////////////////////

  Future<List<ConsultBookModel>> consultbookApi(
      String language,
      String consultmedium,
      String couponcode,
      String coupondiscount,
      String couponid,
      String couponamount,
      var consultamount) async {
    String userId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    String symptoms = await SharedPrefManager.getPrefrenceString(
        AppConstant.SYMVALUE.toString());
    String doctorspeciality = await SharedPrefManager.getPrefrenceString(
        AppConstant.SPEVALUE.toString());
    String patient = await SharedPrefManager.getPrefrenceString(
        AppConstant.PATIENT.toString());
    String patientname = await SharedPrefManager.getPrefrenceString(
        AppConstant.PATIENTNAME.toString());
    String patientage = await SharedPrefManager.getPrefrenceString(
        AppConstant.PATIENTAGE.toString());
    String gender = await SharedPrefManager.getPrefrenceString(
        AppConstant.PATIENTGENDER.toString());
    String address = await SharedPrefManager.getPrefrenceString(
        AppConstant.PATIENTADDRESS.toString());
    String doctor = await SharedPrefManager.getPrefrenceString(
        AppConstant.DOCTOR.toString());
    String generalphysician = await SharedPrefManager.getPrefrenceString(
        AppConstant.GENERALPHYSICIAN.toString());
    List<ConsultBookModel> consultBookModel = [];
    print("sym" + symptoms);
    print("speci" + doctorspeciality);
    print("gen" + generalphysician);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'userid': userId,
        'symptoms': symptoms,
        'doctor_speciality': doctorspeciality,
        'general_physician': generalphysician,
        'patient': patient,
        'patient_name': patientname,
        'patient_age': patientage,
        'gender': gender,
        'address': address,
        'language': language,
        'doctor': doctor,
        'consult_medium': consultmedium,
        'coupon_code': couponcode,
        'coupon_discount': coupondiscount,
        'coupon_id': couponid,
        'coupon_amount': couponamount,
        'consult_amount': consultamount,
      });
      print("ghsdgdh");
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.consultBook,
          data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("res" + list.toString());
        await SharedPrefManager.savePrefString(
            AppConstant.STATUS, list[0]['status'].toString());
        String st =
            await SharedPrefManager.getPrefrenceString(AppConstant.STATUS);
        // consultBookModel = list.map((data) => new ConsultBookModel.fromJson(data)).toList();
        // print("hsdksa"+st+consultBookModel[0].status.toString());
        print(st);

        if (list[0]['status'] == 1) {
          consultBookModel =
              list.map((data) => new ConsultBookModel.fromJson(data)).toList();
          await SharedPrefManager.savePrefString(AppConstant.CONSULTID,
              consultBookModel[0].data.counsultId.toString());
          String counsultId =
              await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);
          print("cdhdjskssk" + counsultId.toString());
          // Fluttertoast.showToast(msg: counsultId,
          //    toastLength: Toast.LENGTH_SHORT,
          //    gravity: ToastGravity.CENTER,
          //    backgroundColor: Colors.black,
          //    textColor: Colors.white);
          print("Status Code : " + consultBookModel[0].status.toString());
          print("Massage : " + consultBookModel[0].msg.toString());
        } else {
          print("shgddhj");
          Fluttertoast.showToast(
              msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
      return consultBookModel;
    } catch (e) {
      print(e);
    }
  }

  /// bookingPayment ////////////////////////////////////////////

  Future<List<BookingPaymentModel>> bookingPaymentApi(
    var paymentId,
    var orderId,
  ) async {
    String customerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    String counsultId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);
    print("consjjsssssss" + counsultId);
    List<BookingPaymentModel> bookingPaymentModel = [];
    List list;
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'CounsultId': counsultId,
        'RazorpayPaymentId': paymentId,
        'OrderId': orderId,
        'UserId': customerId,
      });
      print(formData.fields);
      print("dskda");
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.bookingPayment,
          data: formData);
      if (response.statusCode == 200) {
        print('bookingPaymentApi');
        print(response.data);
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
          bookingPaymentModel = list
              .map((data) => new BookingPaymentModel.fromJson(data))
              .toList();
          // Fluttertoast.showToast(msg: list[0]['msg'],
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);

        } else {
          // Fluttertoast.showToast(msg: list[0]['msg'],
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
        }
      }
      return bookingPaymentModel;
    } catch (e) {
      print(e);
    }
  }

  /// medicalHistroryQuestion ////////////////////////////////////////////////////

  Future<List<MedicalHistroryQuestionModel>>
      medicalHistroryQuestionApi() async {
    String customerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List<MedicalHistroryQuestionModel> medicalHistroryQuestionModel = [];
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': customerId,
      });
      print("ghsdgdh");
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.medicalHistroryQuestion,
          data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        medicalHistroryQuestionModel = list
            .map((data) => new MedicalHistroryQuestionModel.fromJson(data))
            .toList();
        if (medicalHistroryQuestionModel[0].status == 1) {
          // Fluttertoast.showToast(msg: medicalHistroryQuestionModel[0].msg,
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
          print("Status Code : " +
              medicalHistroryQuestionModel[0].status.toString());
          print("Massage : " + medicalHistroryQuestionModel[0].msg.toString());
          // gets.Get.off(PaymentConfirmedPage(),
          //     transition: Transition.rightToLeftWithFade,
          //     duration: Duration(milliseconds: 600));
        } else {
          Fluttertoast.showToast(
              msg: medicalHistroryQuestionModel[0].msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
      return medicalHistroryQuestionModel;
    } catch (e) {
      print(e);
    }
  }

  /// medicalHistroryAnswer ////////////////////////////////////////////////////

  Future<List<MedicalHistoryAnswerModel>> medicalHistoryAnswerApi(
    String question1,
    String question2,
    String question3,
    String question4,
    String question5,
    String question6,
    String question7,
    String question8,
    String question9,
    String question10,
  ) async {
    String customerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    String consultId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);
    List<MedicalHistoryAnswerModel> medicalHistoryAnswerModel = [];
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': customerId,
        'ConsultId': consultId,
        'question1': question1,
        'question2': question2,
        'question3': question3,
        'question4': question4,
        'question5': question5,
        'question6': question6,
        'question7': question7,
        'question8': question8,
        'question9': question9,
        'question10': question10,
      });
      print("ghsdgdh");
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.medicalHistoryAnswer,
          data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        medicalHistoryAnswerModel = list
            .map((data) => new MedicalHistoryAnswerModel.fromJson(data))
            .toList();
        if (medicalHistoryAnswerModel[0].status == 1) {
          await SharedPrefManager.savePrefString(
              AppConstant.ID, medicalHistoryAnswerModel[0].data.id.toString());
          Fluttertoast.showToast(
              msg: medicalHistoryAnswerModel[0].msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("Status Code : " +
              medicalHistoryAnswerModel[0].status.toString());
          print("Massage : " + medicalHistoryAnswerModel[0].msg.toString());
          // gets.Get.offAll(BottomNavigationBarPage(),
          gets.Get.offAll(ConsultationVideoPage(),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));
        } else {
          Fluttertoast.showToast(
              msg: medicalHistoryAnswerModel[0].msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
      return medicalHistoryAnswerModel;
    } catch (e) {
      print(e);
    }
  }

  /// myConsultation ////////////////////////////////////////////////////

  Future<List<UpcomingConsultationData>> myConsultationApi() async {
    String userId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List list;
    List<UpcomingConsultationData> upcomingConsultationData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.myConsultation,
          data: formData);
      if (response.statusCode == 200) {
        print("dsfdsssa" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        upcomingConsultationData = list
            .map((data) => new UpcomingConsultationData.fromJson(data))
            .toList();
        print("hhdhdsss" + list.toString());
        print("gdgd" + upcomingConsultationData[0].patientName);
        return upcomingConsultationData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// pastConsultation ////////////////////////////////////////////////////

  Future<List<PastConsultationData>> pastConsultationApi() async {
    String userId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    List list;
    List<PastConsultationData> pastConsultationData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.pastConsultation,
          data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        pastConsultationData = list
            .map((data) => new PastConsultationData.fromJson(data))
            .toList();
        print("hhdhd" + list.toString());
        print("gdgd" + pastConsultationData[0].patientName);
        return pastConsultationData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// review api ///////////////////////////////

  Future<ApiResponse> reviewApi(String review, double rating) async {
    String userId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    String consultId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
        'DoctorId': doctorId,
        'ConsultId': consultId,
        'Review': review,
        'Rating': rating,
      });
      print(formData.fields);
      print("dgsjs");
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.review,
          data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
          Fluttertoast.showToast(
              msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          gets.Get.back();
          print("Status Code : " + list[0]['status'].toString());
          print("Massage : " + list[0]['msg'].toString());
        } else {
          Fluttertoast.showToast(
              msg: list[0]['msg'],
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

  /// reConsult /////////////////////////////////////////

  Future<List<ReConsultModel>> reConsultApi(consultId) async {
    String userId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
    //String consultid = await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);
    List<ReConsultModel> reConsultModel = [];
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': userId,
        'consultid': consultId,
      });
      print("ghsdgdh");
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlUser + AppUrlConstant.reConsult,
          data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("res" + list.toString());
        await SharedPrefManager.savePrefString(
            AppConstant.STATUS, list[0]['status'].toString());
        String st =
            await SharedPrefManager.getPrefrenceString(AppConstant.STATUS);
        print("hsdksa" + st);
        reConsultModel =
            list.map((data) => new ReConsultModel.fromJson(data)).toList();
        if (reConsultModel[0].status == 1) {
          await SharedPrefManager.savePrefString(AppConstant.CONSULTID,
              reConsultModel[0].data.counsultId.toString());
          await SharedPrefManager.savePrefString(AppConstant.CONSULTIDAMOUNT,
              reConsultModel[0].data.consultAmount.toString());
          // print("cdhdjskssk"+counsultId.toString());
          // Fluttertoast.showToast(msg: reConsultModel[0].msg,
          //    toastLength: Toast.LENGTH_SHORT,
          //    gravity: ToastGravity.CENTER,
          //    backgroundColor: Colors.black,
          //    textColor: Colors.white);
          print("Status Code : " + reConsultModel[0].status.toString());
          print("Massage : " + reConsultModel[0].msg.toString());
        } else {
          print("shgddhj");
          Fluttertoast.showToast(
              msg: reConsultModel[0].msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
      return reConsultModel;
    } catch (e) {
      print(e);
    }
  }
}
