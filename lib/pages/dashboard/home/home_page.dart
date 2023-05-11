import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/consultation_repo.dart';
import 'package:aec_medical/api/repository/home_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/model/consultationModel/upcomingmyconsultation_model.dart';
import 'package:aec_medical/newchat/newchatscreen.dart';
import 'package:aec_medical/pages/dashboard/consultation/select_speciality_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/healthquestions_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/totalhealthconcept_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:connectycube_flutter_call_kit/connectycube_flutter_call_kit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ringtone_player/ringtone_player.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UpcomingConsultationData> upcomingConsultationData = [];

  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("tokensssssssss " + token.toString());
    await SharedPrefManager.savePrefString(
        AppConstant.FCMTOKEN, token.toString());
    HomeRepo homeRepo = new HomeRepo();
    homeRepo.updateTokenApi();
  }

  _launchURLApp() async {
    const url = 'https://apolloeclinic.com/apollo_e_clinic';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  int index = 0;
  bool visibility =false;

  @override
  void initState() {
    RingtonePlayer.stop();
    getToken();
    HomeRepo homeRepo = new HomeRepo();
    homeRepo.checkUserAccountApi();
    homeRepo.healthConceptVideoApi();


    ConsultationRepo consultationRepo = new ConsultationRepo();
    Future future = consultationRepo.myConsultationApi();
    future.then((value) {
      setState(() {
        upcomingConsultationData = value;
        // print("kktitle" + upcomingConsultationData[0].patientName);
        for (int i = 0; i < upcomingConsultationData.length; i++) {
          print(upcomingConsultationData[i].assignStatus);
          if (upcomingConsultationData[i].assignStatus == 'Assigned') {
            print(i);
            setState(() {
              index = i;
              visibility=true;
            });
          }
        }
        // var map = Map.fromIterable(upcomingConsultationData,key:(e)=>e, value:(e) => e);
        // print(map);
      });
    });
    // showNotification();
  }

  void showNotification() {
    Set<int> gfg2 = {1, 2, 3};
    // P2PCallSession incomingCall; // the call received somewhere
    CallEvent callEvent = CallEvent(
        sessionId: '121212',
        callType: 0,
        callerId: 12,
        callerName: 'Caller Name',
        opponentsIds: gfg2,
        userInfo: {'customParameter1': 'value1'});
    ConnectycubeFlutterCallKit.showCallNotification(callEvent);
    ConnectycubeFlutterCallKit.clearCallData(sessionId: '121212');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(visible: visibility,
              child: GestureDetector(onTap: () async {
                print(index.toString());
                await SharedPrefManager.savePrefString(
                    AppConstant.VIDEOURL,
                    upcomingConsultationData[index].videoUrl);
                await SharedPrefManager.savePrefString(
                    AppConstant.VIDEOSTATUS,
                    upcomingConsultationData[index].videoStatus);
                await SharedPrefManager.savePrefString(
                    AppConstant.CONSULTID,
                    upcomingConsultationData[index].consultId);
                await SharedPrefManager.savePrefString(
                    AppConstant.PROFILE,
                    upcomingConsultationData[index].doctorProfile);
                await SharedPrefManager.savePrefString(AppConstant.RATING,
                    upcomingConsultationData[index].rating.toString());
                await SharedPrefManager.savePrefString(
                    AppConstant.DISEASE,
                    upcomingConsultationData[index].disease);
                await SharedPrefManager.savePrefString(
                    AppConstant.DOCTORID,
                    upcomingConsultationData[index].doctorId);
                await SharedPrefManager.savePrefString(
                    AppConstant.DOCTORNAME,
                    upcomingConsultationData[index].doctor);
                Get.to(ChatScreenNew(),
                    arguments: [upcomingConsultationData[index].doctor],
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 600));
                print('clicked');

              },
                child: Row(
                  children: [
                    InkWell(
                        onTap: () async {
                          print(index.toString());
                          await SharedPrefManager.savePrefString(
                              AppConstant.VIDEOURL,
                              upcomingConsultationData[index].videoUrl);
                          await SharedPrefManager.savePrefString(
                              AppConstant.VIDEOSTATUS,
                              upcomingConsultationData[index].videoStatus);
                          await SharedPrefManager.savePrefString(
                              AppConstant.CONSULTID,
                              upcomingConsultationData[index].consultId);
                          await SharedPrefManager.savePrefString(
                              AppConstant.PROFILE,
                              upcomingConsultationData[index].doctorProfile);
                          await SharedPrefManager.savePrefString(AppConstant.RATING,
                              upcomingConsultationData[index].rating.toString());
                          await SharedPrefManager.savePrefString(
                              AppConstant.DISEASE,
                              upcomingConsultationData[index].disease);
                          await SharedPrefManager.savePrefString(
                              AppConstant.DOCTORID,
                              upcomingConsultationData[index].doctorId);
                          await SharedPrefManager.savePrefString(
                              AppConstant.DOCTORNAME,
                              upcomingConsultationData[index].doctor);
                          Get.to(ChatScreenNew(),
                              arguments: [upcomingConsultationData[index].doctor],
                              transition: Transition.rightToLeftWithFade,
                              duration: Duration(milliseconds: 600));
                          print('clicked');
                        },
                        child: Container(
                          color: Colors.green,
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.reply,color: Colors.white,),
                                SizedBox(width: 5,),
                                Text(
                                  ' Consultation on progress return to chat',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            _totalhealthcard(),
            SizedBox(
              height: 90,
            ),
            _counsellingbutton(),
            SizedBox(
              height: 50,
            ),
            _coursesbutton(),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      )),
    );
  }

  _totalhealthcard() {
    return Stack(
      children: [
        SizedBox(
          width: Get.width,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 20.0,
                    bottom: 10.0,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Text(
                        Strings.CARDTEXT1,
                        style: StringsStyle.cardtext1style,
                      ),
                      SizedBox(height: 10),
                      Text(
                        Strings.CARDTEXT2,
                        textAlign: TextAlign.center,
                        style: StringsStyle.cardtext2style,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/healthcardimage1.png")))),
                          SizedBox(
                            height: 10,
                          ),
                          // ignore: deprecated_member_use
                          InkWell(
                            onTap: () async {
                              String videourl =
                                  await SharedPrefManager.getPrefrenceString(
                                      AppConstant.HEALTHCONCEPTVIDEO);
                              Get.to(TotalHealthConceptPage(),
                                  arguments: videourl,
                                  transition: Transition.rightToLeftWithFade,
                                  duration: Duration(milliseconds: 600));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  gradient: LinearGradient(colors: [
                                    Color(0xffED816E),
                                    Color(0xffB93342),
                                    // Colors.red.shade500,
                                    // AppColors.redColor,
                                  ]),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 50,
                                width: 165,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text("Know Total Health Concept",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.whitetextColor,
                                          fontSize: 11,
                                          letterSpacing: 0.3,
                                        )),
                                  ),
                                )),
                          )
                        ],
                      ),
                      //SizedBox(width: 5,),
                      Column(
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/healthcardimage2.png")))),
                          SizedBox(
                            height: 10,
                          ),
                          // ignore: deprecated_member_use
                          InkWell(
                            onTap: () {
                              Get.to(QuestionFitness(),
                                  transition: Transition.rightToLeftWithFade,
                                  duration: Duration(milliseconds: 600));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  gradient: LinearGradient(colors: [
                                    Color(0xffED816E),
                                    Color(0xffB93342),
                                    // Colors.red.shade500,
                                    // AppColors.redColor,
                                  ]),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 50,
                                width: 165,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text("Know Total Health Score",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.whitetextColor,
                                          fontSize: 11,
                                          letterSpacing: 0.3,
                                        )),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo.png")))),
        ),
      ],
    );
  }

  _counsellingbutton() {
    // ignore: deprecated_member_use
    return InkWell(
        onTap: () {
          Get.to(SelectSpecialityPage(),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));
        },
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ],
              gradient: LinearGradient(colors: [
                Color(0xff858481),
                Color(0xff232323),
              ]),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50,
            width: Get.width / 1.3,
            child: Center(
              child: Center(
                child: Text("Online Consultation",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.whitetextColor,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    )),
              ),
            )));
  }

  _coursesbutton() {
    return InkWell(
        onTap: () {
          Get.to(QuestionFitness(),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));
        },
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ],
              gradient: LinearGradient(colors: [
                Color(0xff858481),
                Color(0xff232323),
              ]),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50,
            width: Get.width / 1.3,
            child: Center(
              child: Center(
                child: Text("Get Your Total Health",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.whitetextColor,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    )),
              ),
            )));
  }
}
