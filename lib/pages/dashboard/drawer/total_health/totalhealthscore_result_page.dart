import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/auth_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/homeModel/healthScoreResult_model.dart';
import 'package:aec_medical/pages/dashboard/bottom_navigation_bar_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share/share.dart';
import 'package:unique_identifier/unique_identifier.dart';


class HealthScoreResultPage extends StatefulWidget {
  const HealthScoreResultPage({Key? key}) : super(key: key);

  @override
  _HealthScoreResultPageState createState() => _HealthScoreResultPageState();
}

class _HealthScoreResultPageState extends State<HealthScoreResultPage> {

  List<HealthScoreResultModel> healthScoreResultModel = Get.arguments;

  double percent = 0.0;
  var _identifier;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appbarbackgroundColor,
        centerTitle: true,
        title: Text("Health Score",style: StringsStyle.pagetitlestyle,),
        // leading: Icon(Icons.arrow_back,color: Colors.white,),
      ),
      body: SingleChildScrollView(
        child: Center(
          child:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 30,),
                CircularPercentIndicator(
                  radius: 180.0,
                  lineWidth: 20.0,
                  animation: true,
                  percent: healthScoreResultModel.isEmpty?percent:(healthScoreResultModel[0].data.presentage)/100,
                  center: new Text(
                    "${healthScoreResultModel.isEmpty?percent:(healthScoreResultModel[0].data.presentage).toDouble()} %",
                    style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  // backgroundColor: Colors.white,
                  progressColor: AppColors.redColor,
                ),
                SizedBox(height: 30,),
                Text("Your Score is: ${healthScoreResultModel.isEmpty?percent:(healthScoreResultModel[0].data.presentage).toDouble()} %",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                SizedBox(height: 30,),
                InkWell(
                  onTap: () {
                    Share.share("Health Score Link: ${healthScoreResultModel.isEmpty?percent:(healthScoreResultModel[0].data.link)} %");
                  },
                  child: Container(
                    width: 150,
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
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          // onTap: (){
                          //   Get.to(PreApprovalDetailsPage(),
                          //       transition: Transition.rightToLeftWithFade,
                          //       duration: Duration(milliseconds: 600));
                          // },
                          child: Text("Share Now",style: TextStyle(
                              color: AppColors.whitetextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto'
                          ),),
                        ),
                        SizedBox(width: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0),
                          child: CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.whitetextColor,
                              child: Icon(Icons.share,color: Colors.black,)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                // Container(color: Colors.grey,height: 1.5,),
                // SizedBox(height: 20,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     InkWell(
                //         onTap: () {
                //   //        Share.share("Health Score Link: ${healthScoreResultModel.isEmpty?percent:(healthScoreResultModel[0].data.link)} %");
                //         },
                //         child: Image.asset("assets/images/faceb.png",height: 30,width: 30,color: Colors.deepPurple,)),
                //     InkWell(
                //         onTap: () {
                //     //      Share.share("Health Score Link: ${healthScoreResultModel.isEmpty?percent:(healthScoreResultModel[0].data.link)} %");
                //         },
                //         child: Image.asset("assets/images/linkedin.png",height: 30,width: 30,)),
                //     InkWell(
                //         onTap: () {
                //       //    Share.share("Health Score Link: ${healthScoreResultModel.isEmpty?percent:(healthScoreResultModel[0].data.link)} %");
                //         },
                //         child: Image.asset("assets/images/twitter.png",height: 30,width: 30,)),
                //     InkWell(
                //         onTap: () {
                //         //  Share.share("Health Score Link: ${healthScoreResultModel.isEmpty?percent:(healthScoreResultModel[0].data.link)} %");
                //         },
                //         child: Image.asset("assets/images/instagram.png",height: 30,width: 30,)),
                //     InkWell(
                //         onTap: () {
                //           //Share.share("Health Score Link: ${healthScoreResultModel.isEmpty?percent:(healthScoreResultModel[0].data.link)} %");
                //         },
                //         child: Image.asset("assets/images/whatsapp.png",height: 30,width: 30,)),
                //   ],
                // ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: InkWell(
                      onTap: (){
                        Get.offAll(BottomNavigationBarPage(selectIndex: 0,),
                            transition: Transition.rightToLeftWithFade,
                            duration: Duration(milliseconds: 600));
                      },
                      child: CustomButton(
                          text1: "",
                          text2: "Continue",
                          width: Get.width,
                          height: 50)),
                ),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}