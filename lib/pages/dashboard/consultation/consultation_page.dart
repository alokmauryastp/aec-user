import 'dart:convert';
import 'dart:io';

import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/consultation_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/consultationModel/pastconsultaion_model.dart';
import 'package:aec_medical/model/consultationModel/reconsult_model.dart';
import 'package:aec_medical/model/consultationModel/upcomingmyconsultation_model.dart';
import 'package:aec_medical/newchat/newchatscreen.dart';
import 'package:aec_medical/pages/dashboard/AcceptPage.dart';
import 'package:aec_medical/pages/dashboard/consultation/payment_confirmed_page.dart';
import 'package:aec_medical/pages/dashboard/consultation/pdf_downloader_page.dart';
import 'package:aec_medical/pages/dashboard/consultation/select_speciality_page.dart';
import 'package:aec_medical/utils/KidsAge.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ConsultationPage extends StatefulWidget {
  const ConsultationPage({Key? key}) : super(key: key);

  @override
  _ConsultationPageState createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
  List<UpcomingConsultationData> upcomingConsultationData = [];
  List<PastConsultationData> pastConsultationData = [];
  var _index = 0;
  late Razorpay _razorpay;
  bool _isLoad = false;

  late String _type;
  TextEditingController _textEditingController = new TextEditingController();

  late bool isLoading;
  bool _allowWriteFile = false;

  List<Course> courseContent = [];
  int _downloadpdf = 0;

  String progress = "";
  late Dio dio;
  late File f;
  int endTime = DateTime.now().millisecondsSinceEpoch;

  List<String> SelectedList = [
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hii this is the page");
    ConsultationRepo consultationRepo = new ConsultationRepo();
    Future future = consultationRepo.myConsultationApi();
    future.then((value) {
      setState(() {
        upcomingConsultationData = value;
        print("kktitle" + upcomingConsultationData[0].patientName);
      });
    });

    Future future1 = consultationRepo.pastConsultationApi();
    future1.then((value) {
      setState(() {
        pastConsultationData = value;
        print("kktitle" + pastConsultationData[0].patientName);
      });
    });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    dio = Dio();
    courseContent.add(Course(
        title: "Chapter 2",
        path: "https://www.cs.purdue.edu/homes/ayg/CS251/slides/chap2.pdf"));
    courseContent.add(Course(
        title: "Chapter 3",
        path: "https://www.cs.purdue.edu/homes/ayg/CS251/slides/chap3.pdf"));
    courseContent.add(Course(
        title: "Chapter 4",
        path: "https://www.cs.purdue.edu/homes/ayg/CS251/slides/chap4.pdf"));
    courseContent.add(Course(
        title: "Chapter 5",
        path: "https://www.cs.purdue.edu/homes/ayg/CS251/slides/chap5.pdf"));
    courseContent.add(Course(
        title: "Chapter 6",
        path: "https://www.cs.purdue.edu/homes/ayg/CS251/slides/chap6.pdf"));
    courseContent.add(Course(
        title: "Chapter 7A",
        path: "https://www.cs.purdue.edu/homes/ayg/CS251/slides/chap7a.pdf"));
  }

  /// pdf downloader////////////////////////////////////

  requestWritePermission() async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
        _allowWriteFile = true;
      });
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    }
  }

  Future<String> getDirectoryPath() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    Directory directory =
        await new Directory(appDocDirectory.path + '/' + 'dir')
            .create(recursive: true);

    return directory.path;
  }

  Future downloadFile(String url, path) async {
    if (!_allowWriteFile) {
      requestWritePermission();
    }
    try {
      ProgressDialog progressDialog = ProgressDialog(context,
          dialogTransitionType: DialogTransitionType.Bubble,
          title: Text("Downloading File"));

      progressDialog.show();

      await dio.download(url, path, onReceiveProgress: (rec, total) {
        setState(() {
          isLoading = true;
          progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
          progressDialog.setMessage(Text("Dowloading $progress"));
        });
      });
      progressDialog.dismiss();
    } catch (e) {
      print(e.toString());
    }
  }

  /// fghjkl///////////////////////////////////////

  List<ReConsultModel> consultBookModel = [];

  _consultBook(consultId) async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoad = true;
    });
    await Provider.of<ConsultationRepo>(context, listen: false)
        .reConsultApi(consultId);
    setState(() {
      _isLoad = false;
    });
  }

  //var price = coursesData.price;

  static const platform = const MethodChannel("razorpay_flutter");

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var consultamount =
        await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTIDAMOUNT);
    var pr = await SharedPrefManager.getPrefrenceString(AppConstant.PRICE);
    // var pric= price;
    var options = {
      'key': 'rzp_test_vQOXAJXDVlhsQ4',
      'amount': ((100) * 100),
      'name': 'AEC_App',
      'description': "Patients",
      'prefill': {
        'contact': '8650965058',
        'email': 'rajeev.kumar@aaratechnologies.in'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    var paymentid = response.paymentId;
    var orderId = response.orderId;
    Get.defaultDialog(
      radius: 5,
      backgroundColor: Colors.white,
      title: 'Your payment Successful,'
          'completed',
      titleStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (_isLoad)
            CircularProgressIndicator()
          else
            InkWell(
                onTap: () async {
                  var pr = 100;
                  // var pr = SharedPrefManager.getPrefrenceString(AppConstant.PRICE);
                  setState(() {
                    Get.offAll(PaymentConfirmedPage(),
                        arguments: [paymentid, orderId, pr],
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  });
                },
                child: Center(
                  child: Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        "OK",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
                )),
        ],
      ),
    );
    // Get.offAll(OrderSuccessfulPage(),arguments: [checkoutModel[0].data,paymentid],
    //   transition: Transition.zoom,
    //   curve: Curves.bounceOut,
    //   duration: Duration(milliseconds: 600),
    // );
    // Fluttertoast.showToast(
    //     msg: "Your payment successfully completed ", toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
    //     toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: " + response.walletName!, toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColors.whitetextColor,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        _heading(),
                        SizedBox(height: 10),
                        // _searchbox(),
                      ]),
                ),
              ),
              SizedBox(height: 2),
              _listview(),
              SizedBox(height: 2),
              _newconsultationbutton(),
              SizedBox(height: 30),
            ],
          ),
        ));
  }

  _heading() {
    return InkWell(
      onTap: () {
        Get.to(AcceptPage(),
            arguments: ["Chat"],
            transition: Transition.rightToLeftWithFade,
            duration: Duration(milliseconds: 600));
        notification();
      },
      child: Container(
          width: Get.width,
          child: Text(Strings.HEADINGTITLE,
              style: TextStyle(
                  color: AppColors.appbarbackgroundColor,
                  fontSize: 20,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold))),
    );
  }

  Future<void> notification() async {
    AwesomeNotifications().initialize(
        'resource://drawable/res_app_icon',
        [
          NotificationChannel(
              channelGroupKey: 'basic_tests',
              channelKey: 'badge_channel',
              channelName: 'Badge indicator notifications',
              channelDescription:
                  'Notification channel to activate badge indicator',
              channelShowBadge: true,
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.yellow)
        ],
        debug: true);
    Map<String, dynamic> map = {
      "token": "4243453",
      "title": "Store",
      "price": 50,
      "currency": "GPB"
    };
    AwesomeNotifications().createNotificationFromJsonData(map);
    String token =
        await SharedPrefManager.getPrefrenceString(AppConstant.FCMTOKEN);
    print(token);
  }

  _searchbox() {
    return Container(
      height: 50,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.whitetextColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(3, 3))
        ],
      ),
      child: TextFormField(
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
              hintText: 'search',
              hintStyle: TextStyle(
                color: Colors.black38,
              ),
              suffixIcon: Icon(
                Icons.search,
                size: 30,
                color: Colors.black38,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.yellow, width: 1),
                  borderRadius: BorderRadius.circular(10)))),
    );
  }

  BoxDecoration myBoxinActive() {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColorDark, width: 1),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }

  BoxDecoration myBoxActive() {
    return BoxDecoration(
      color: Theme.of(context).primaryColorDark,
      border: Border.all(color: Theme.of(context).primaryColorDark, width: 1),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }

  activeStyle() {
    return TextStyle(
      color: AppColors.whitetextColor,
      fontSize: 15,
      letterSpacing: 0.2,
      fontWeight: FontWeight.bold,
    );
  }

  inactiveStyle() {
    return TextStyle(color: Theme.of(context).primaryColorDark);
  }

  _listview() {
    return Container(
        color: AppColors.whitetextColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _index = 0;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.15,
                        height: 40,
                        alignment: Alignment.center,
                        decoration:
                            _index == 0 ? myBoxActive() : myBoxinActive(),
                        child: _index == 0
                            ? Text("Upcoming", style: activeStyle())
                            : Text("Upcoming", style: inactiveStyle()),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _index = 1;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.15,
                        height: 40,
                        decoration:
                            _index == 1 ? myBoxActive() : myBoxinActive(),
                        child: Center(
                          child: _index == 1
                              ? Text("Past", style: activeStyle())
                              : Text("Past", style: inactiveStyle()),
                        ),
                      ),
                    )
                  ]),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.grey),
            if (upcomingConsultationData.isNull)
              Visibility(
                  visible: _index == 0,
                  child: Container(
                    width: 250,
                    color: Colors.white,
                    child: EmptyWidget(
                      image: null,
                      packageImage: PackageImage.Image_3,
                      title: 'No Consultation',
                      subTitle: 'Sorry! Upcoming Consultation not\navailable.',
                      titleTextStyle: TextStyle(
                        fontSize: 22,
                        color: Color(0xff9da9c7),
                        fontWeight: FontWeight.w500,
                      ),
                      subtitleTextStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xffabb8d6),
                      ),
                    ),
                  ))
            else if (upcomingConsultationData.isEmpty)
              Center(child: CircularProgressIndicator())
            else
              Visibility(
                  visible: _index == 0,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              primary: true,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: upcomingConsultationData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              await SharedPrefManager
                                                  .savePrefString(
                                                      AppConstant.VIDEOURL,
                                                      upcomingConsultationData[
                                                              index]
                                                          .videoUrl);
                                              await SharedPrefManager
                                                  .savePrefString(
                                                      AppConstant.VIDEOSTATUS,
                                                      upcomingConsultationData[
                                                              index]
                                                          .videoStatus);
                                              await SharedPrefManager
                                                  .savePrefString(
                                                      AppConstant.CONSULTID,
                                                      upcomingConsultationData[
                                                              index]
                                                          .consultId);
                                              await SharedPrefManager
                                                  .savePrefString(
                                                      AppConstant.PROFILE,
                                                      upcomingConsultationData[
                                                              index]
                                                          .doctorProfile);
                                              await SharedPrefManager
                                                  .savePrefString(
                                                      AppConstant.RATING,
                                                      upcomingConsultationData[
                                                              index]
                                                          .rating
                                                          .toString());
                                              await SharedPrefManager
                                                  .savePrefString(
                                                      AppConstant.DISEASE,
                                                      upcomingConsultationData[
                                                              index]
                                                          .disease);
                                              await SharedPrefManager
                                                  .savePrefString(
                                                      AppConstant.DOCTORID,
                                                      upcomingConsultationData[
                                                              index]
                                                          .doctorId);
                                              await SharedPrefManager
                                                  .savePrefString(
                                                      AppConstant.DOCTORNAME,
                                                      upcomingConsultationData[
                                                              index]
                                                          .doctor);
                                              Get.to(ChatScreenNew(),
                                                  arguments: [
                                                    upcomingConsultationData[
                                                            index]
                                                        .doctor
                                                  ],
                                                  transition: Transition
                                                      .rightToLeftWithFade,
                                                  duration: Duration(
                                                      milliseconds: 600));
                                            },
                                            child: Container(
                                                color: AppColors.whitetextColor,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            upcomingConsultationData[
                                                                    index]
                                                                .date,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .lighttextColor,
                                                                fontSize: 12)),
                                                        SizedBox(height: 5),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      "Dr. Name: " +
                                                                          upcomingConsultationData[index]
                                                                              .doctor,
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColors
                                                                            .darktextColor,
                                                                      )),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            6),
                                                                    child: SizedBox(
                                                                        height:
                                                                            20,
                                                                        width:
                                                                            20,
                                                                        child: Image.asset(
                                                                            "assets/images/help.png")),
                                                                  ),
                                                                ],
                                                              ),

                                                              // Row(
                                                              //   children: [
                                                              //     Text("WT : "),
                                                              //     CountdownTimer(
                                                              //       endTime: endTime + 1000 * 60  * int.parse(upcomingConsultationData[index].waitingTime.isEmpty?"0":upcomingConsultationData[index].waitingTime.replaceAll(" Minutes", "")) ,
                                                              //       endWidget: Text("Time Over"),
                                                              //       onEnd: onEnd,),
                                                              //   ],
                                                              // ),
                                                              Row(
                                                                children: [
                                                                  // Padding(
                                                                  //     padding:
                                                                  //         const EdgeInsets
                                                                  //                 .only(
                                                                  //             right:
                                                                  //                 10),
                                                                  //     child: Icon(
                                                                  //         Icons
                                                                  //             .edit_outlined,
                                                                  //         color: AppColors
                                                                  //             .appbarbackgroundColor)),
                                                                  Text(
                                                                      "WT: ${(upcomingConsultationData[index].waitingTime).isEmpty ? "0" : upcomingConsultationData[index].waitingTime} Minutes",
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColors
                                                                            .darktextColor,
                                                                      )),
                                                                ],
                                                              ),
                                                            ]),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                upcomingConsultationData[
                                                                            index]
                                                                        .disease
                                                                        .isEmpty
                                                                    ? "Gen. Physician"
                                                                    : upcomingConsultationData[
                                                                            index]
                                                                        .disease,
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .darktextColor,
                                                                )),
                                                            upcomingConsultationData[
                                                                        index]
                                                                    .prescriptionPdf
                                                                    .isEmpty
                                                                ? SizedBox()
                                                                : InkWell(
                                                                    splashColor:
                                                                        AppColors
                                                                            .appbarbackgroundColor,
                                                                    onTap:
                                                                        () async {
                                                                      String
                                                                          url =
                                                                          upcomingConsultationData[index]
                                                                              .prescriptionPdf;
                                                                      if (upcomingConsultationData[
                                                                              index]
                                                                          .prescriptionPdf
                                                                          .isEmpty) {
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                "Prescription not Available.",
                                                                            toastLength:
                                                                                Toast.LENGTH_SHORT,
                                                                            gravity: ToastGravity.CENTER,
                                                                            backgroundColor: Colors.black,
                                                                            textColor: Colors.white);
                                                                      } else {
                                                                        String
                                                                            extension =
                                                                            url.substring(url.lastIndexOf("/"));
                                                                        setState(
                                                                            () async {
                                                                          SelectedList[
                                                                              index] = SelectedList[index] ==
                                                                                  "0"
                                                                              ? "1"
                                                                              : "0";
                                                                          await getDirectoryPath()
                                                                              .then((path) async {
                                                                            f = await File(path +
                                                                                "$extension");
                                                                            if (f.existsSync()) {
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                return PDFScreen(f.path);
                                                                              }));
                                                                              return;
                                                                            }
                                                                            downloadFile(url,
                                                                                "$path/$extension");
                                                                          });
                                                                        });
                                                                      }
                                                                    },
                                                                    child: SelectedList[index] ==
                                                                            "0"
                                                                        ? Center(
                                                                            child: Container(
                                                                                height: 30,
                                                                                width: 90,
                                                                                decoration: BoxDecoration(
                                                                                    gradient: LinearGradient(colors: [
                                                                                      Color(0xff858481),
                                                                                      Color(0xff232323),
                                                                                      // Colors.red.shade500,
                                                                                      // AppColors.redColor,
                                                                                    ]),
                                                                                    borderRadius: BorderRadius.circular(20)),
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  "Prescription",
                                                                                  style: TextStyle(
                                                                                    fontSize: 10,
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ))),
                                                                          )
                                                                        : InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                return PDFScreen(f.path);
                                                                              }));
                                                                            },
                                                                            child:
                                                                                Center(
                                                                              child: Container(
                                                                                  height: 30,
                                                                                  width: 90,
                                                                                  decoration: BoxDecoration(
                                                                                      gradient: LinearGradient(colors: [
                                                                                        Color(0xff858481),
                                                                                        Color(0xff232323),
                                                                                        // Colors.red.shade500,
                                                                                        // AppColors.redColor,
                                                                                      ]),
                                                                                      borderRadius: BorderRadius.circular(20)),
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    "View PDF",
                                                                                    style: TextStyle(
                                                                                      fontSize: 10,
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ))),
                                                                            )),
                                                                  ),
                                                          ],
                                                        ),
                                                      ]),
                                                )),
                                          ),
                                          Divider(color: Colors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })))),
            if (pastConsultationData.isNull)
              Visibility(
                  visible: _index == 1,
                  child: Container(
                    width: 250,
                    color: Colors.white,
                    child: EmptyWidget(
                      image: null,
                      packageImage: PackageImage.Image_3,
                      title: 'No Consultation',
                      subTitle: 'Sorry! Old Consultation not\navailable.',
                      titleTextStyle: TextStyle(
                        fontSize: 22,
                        color: Color(0xff9da9c7),
                        fontWeight: FontWeight.w500,
                      ),
                      subtitleTextStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xffabb8d6),
                      ),
                    ),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Image.asset(
                    //       "assets/images/notcounselling.jpg",
                    //       width: Get.width,
                    //     ),
                    //     Text(
                    //       "Sorry! Old Consultation not available.",
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //           fontSize: 20,
                    //           color: AppColors.appbarbackgroundColor,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //   ],
                    // ),
                  ))
            else if (pastConsultationData.isEmpty)
              Center(child: Text(""))
            else
              Visibility(
                  visible: _index == 1,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              primary: true,
                              reverse: true,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: pastConsultationData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                      child: InkWell(
                                        onTap: ()async{
                                          await SharedPrefManager.savePrefString(
                                              AppConstant
                                                  .CONSULTID,
                                              pastConsultationData[
                                              index]
                                                  .consultId);
                                          Get.to(
                                              ChatScreenNew(),
                                              arguments: [
                                                "Chat"
                                              ],
                                              transition:
                                              Transition
                                                  .rightToLeftWithFade,
                                              duration: Duration(
                                                  milliseconds:
                                                  600));
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                                color: AppColors.whitetextColor,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            pastConsultationData[
                                                                    index]
                                                                .date,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .lighttextColor,
                                                                fontSize: 12)),
                                                        SizedBox(height: 5),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      "Dr. " +
                                                                          pastConsultationData[index]
                                                                              .doctor,
                                                                      style:
                                                                          TextStyle(
                                                                        color:
                                                                            AppColors.darktextColor,
                                                                      )),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            6),
                                                                    child: SizedBox(
                                                                        height:
                                                                            20,
                                                                        width:
                                                                            20,
                                                                        child:
                                                                            Image.asset("assets/images/help.png")),
                                                                  ),
                                                                ],
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Get.defaultDialog(
                                                                    radius: 5,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    title:
                                                                        'Are you sure you want to ReConsult?',
                                                                    titleStyle: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                    content:
                                                                        Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              await SharedPrefManager.savePrefString(AppConstant.PRICE, pastConsultationData[index].paymentAmount);
                                                                              await _consultBook(pastConsultationData[index].consultId.toString());
                                                                              print("dhsjdscd");
                                                                              String status = await SharedPrefManager.getPrefrenceString(AppConstant.STATUS);
                                                                              print("djkdd" + status);
                                                                              if (status == "1") {
                                                                                openCheckout();
                                                                              } else {}
                                                                            },
                                                                            child:
                                                                                Center(
                                                                              child: Container(
                                                                                  height: 45,
                                                                                  width: 100,
                                                                                  decoration: BoxDecoration(
                                                                                      gradient: LinearGradient(colors: [
                                                                                        Color(0xffED816E),
                                                                                        Color(0xffB93342),
                                                                                        // Colors.red.shade500,
                                                                                        // AppColors.redColor,
                                                                                      ]),
                                                                                      borderRadius: BorderRadius.circular(20)),
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    "Yes",
                                                                                    style: TextStyle(
                                                                                      fontSize: 14,
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ))),
                                                                            )),
                                                                        InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Get.back();
                                                                            },
                                                                            child:
                                                                                Center(
                                                                              child: Container(
                                                                                  height: 45,
                                                                                  width: 100,
                                                                                  decoration: BoxDecoration(
                                                                                      gradient: LinearGradient(colors: [
                                                                                        Color(0xffED816E),
                                                                                        Color(0xffB93342),
                                                                                        // Colors.red.shade500,
                                                                                        // AppColors.redColor,
                                                                                      ]),
                                                                                      borderRadius: BorderRadius.circular(20)),
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    "No",
                                                                                    style: TextStyle(
                                                                                      fontSize: 14,
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ))),
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                                child: isCouponValid(pastConsultationData[index].validTill) ?  Row(
                                                                  children: [
                                                                    Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            right:
                                                                                10),
                                                                        child: Icon(
                                                                            Icons
                                                                                .edit_outlined,
                                                                            color:
                                                                                AppColors.appbarbackgroundColor)),
                                                                    Text(
                                                                        "Reconsult",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              AppColors.darktextColor,
                                                                          letterSpacing:
                                                                              0.5,
                                                                        )),
                                                                  ],
                                                                )  : SizedBox(),
                                                              ),
                                                            ]),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: 150,
                                                              child: Text(
                                                                "${pastConsultationData[index].disease.isEmpty ? "Gen. Physician" : pastConsultationData[index].disease}",
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .darktextColor,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                softWrap: false,
                                                              ),
                                                            ),
                                                            pastConsultationData[
                                                                        index]
                                                                    .prescriptionPdf
                                                                    .isEmpty
                                                                ? SizedBox()
                                                                : InkWell(
                                                                    splashColor:
                                                                        AppColors
                                                                            .appbarbackgroundColor,
                                                                    onTap:
                                                                        () async {
                                                                      String
                                                                          url =
                                                                          pastConsultationData[index]
                                                                              .prescriptionPdf;
                                                                      if (pastConsultationData[
                                                                              index]
                                                                          .prescriptionPdf
                                                                          .isEmpty) {
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                "Prescription not Available.",
                                                                            toastLength:
                                                                                Toast.LENGTH_SHORT,
                                                                            gravity: ToastGravity.CENTER,
                                                                            backgroundColor: Colors.black,
                                                                            textColor: Colors.white);
                                                                      } else {
                                                                        String
                                                                            extension =
                                                                            url.substring(url.lastIndexOf("/"));
                                                                        setState(
                                                                            () async {
                                                                          SelectedList[
                                                                              index] = SelectedList[index] ==
                                                                                  "0"
                                                                              ? "1"
                                                                              : "0";
                                                                          await getDirectoryPath()
                                                                              .then((path) async {
                                                                            f = await File(path +
                                                                                "$extension");
                                                                            if (f.existsSync()) {
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                return PDFScreen(f.path);
                                                                              }));
                                                                              return;
                                                                            }
                                                                            downloadFile(url,
                                                                                "$path/$extension");
                                                                          });
                                                                        });
                                                                      }
                                                                    },
                                                                    child: SelectedList[index] ==
                                                                            "0"
                                                                        ? Center(
                                                                            child: Container(
                                                                                height: 30,
                                                                                width: 90,
                                                                                decoration: BoxDecoration(
                                                                                    gradient: LinearGradient(colors: [
                                                                                      Color(0xff858481),
                                                                                      Color(0xff232323),
                                                                                      // Colors.red.shade500,
                                                                                      // AppColors.redColor,
                                                                                    ]),
                                                                                    borderRadius: BorderRadius.circular(20)),
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  "Prescription",
                                                                                  style: TextStyle(
                                                                                    fontSize: 10,
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ))),
                                                                          )
                                                                        : InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                return PDFScreen(f.path);
                                                                              }));
                                                                            },
                                                                            child:
                                                                                Center(
                                                                              child: Container(
                                                                                  height: 30,
                                                                                  width: 90,
                                                                                  decoration: BoxDecoration(
                                                                                      gradient: LinearGradient(colors: [
                                                                                        Color(0xff858481),
                                                                                        Color(0xff232323),
                                                                                        // Colors.red.shade500,
                                                                                        // AppColors.redColor,
                                                                                      ]),
                                                                                      borderRadius: BorderRadius.circular(20)),
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    "View PDF",
                                                                                    style: TextStyle(
                                                                                      fontSize: 10,
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ))),
                                                                            )),
                                                                  ),
                                                          ],
                                                        ),
                                                      ]),
                                                )),
                                            Divider(color: Colors.white)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })))),
          ]),
        ));
  }

  _newconsultationbutton() {
    return Container(
      color: AppColors.whitetextColor,
      // ignore: deprecated_member_use
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        // ignore: deprecated_member_use
        child: FlatButton(
          onPressed: () {
            Get.to(SelectSpecialityPage(),
                transition: Transition.rightToLeftWithFade,
                duration: Duration(milliseconds: 600));
          },
          child: CustomButton(
              text1: "",
              text2: "Book New consultation",
              width: Get.width,
              height: 50),
        ),
      ),
    );
  }
}

void onEnd() {
  print('onEnd');
}

class Message {
  final String token;
  final String title;
  final int price;
  final String currency;

  Message(this.token, this.title, this.price, this.currency);

  static Message? fromJson(String source) => fromMap(json.decode(source));

  static Message? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Message(
      map['token'],
      map['title'],
      map['price'],
      map['currency'],
    );
  }
}
