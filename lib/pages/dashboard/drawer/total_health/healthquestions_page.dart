// @dart=2.9
import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/auth_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/homeModel/totalHealthquestion_model.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/scoredetails_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/totalhealthscore_result_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionFitness extends StatefulWidget {
  const QuestionFitness({Key key}) : super(key: key);

  @override
  _QuestionFitnessState createState() => _QuestionFitnessState();
}

class _QuestionFitnessState extends State<QuestionFitness> {
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  var currentPageValue = 0;
  var mItemCount = 10;
  List<HealthScoreQuestionData> healthScoreQuestionData = [];
  var selectQuestion = 0, selectedAnswer = "", selectone;
  List<int> groupValue = [];
  List<List<int>> value = [];
  List<int> sumData = [];
  List<int> ssumData = [];
  Set set = Set();

  bool _isLoad = false;

  @override
  void initState() {
    super.initState();
    AuthRepo authRepo = new AuthRepo();
    Future future = authRepo.healthScoreQuestionApi();
    future.then((value) {
      setState(() {
        healthScoreQuestionData = value;
      });
      print("fffffffffffffffff" + healthScoreQuestionData[0].question);
    });
    // controller.addListener(() {
    //   setState(() {
    //     currentPageValue = controller.page.toInt();
    //     print("haskj"+(currentPageValue + 1).toString());
    //   });
    // });

    groupValue.add(0);
    groupValue.add(1);
    groupValue.add(2);
    groupValue.add(3);
    groupValue.add(4);
    groupValue.add(5);
    groupValue.add(6);
    groupValue.add(7);
    groupValue.add(8);
    groupValue.add(9);
    groupValue.add(10);
    groupValue.add(11);
    groupValue.add(12);
    groupValue.add(13);
    groupValue.add(14);
    groupValue.add(15);
    groupValue.add(16);
    groupValue.add(17);
    groupValue.add(18);
    groupValue.add(19);
    groupValue.add(20);
    groupValue.add(21);
    groupValue.add(22);
    groupValue.add(23);
    groupValue.add(24);
    groupValue.add(25);
    groupValue.add(26);
    groupValue.add(27);
    groupValue.add(28);
    groupValue.add(29);
    groupValue.add(30);
    groupValue.add(31);
    groupValue.add(32);
    groupValue.add(33);
    groupValue.add(34);
    groupValue.add(35);
    groupValue.add(36);
    groupValue.add(37);
    groupValue.add(38);
    groupValue.add(39);
    groupValue.add(40);
    groupValue.add(41);
    groupValue.add(42);
    // groupValue.add(23);
    // groupValue.add(24);

    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    value.add([31, 32, 33, 34]);
    // value.add([1,2,3,4]);
    // value.add([1,2,3,4]);
  }

  // void changePageViewPostion(int whichPage) {
  //   if(controller != null){
  //     whichPage = whichPage + 1; // because position will start from 0
  //     double jumpPosition = MediaQuery.of(context).size.width / 2;
  //     double orgPosition = MediaQuery.of(context).size.width / 2;
  //     for(int i=0; i<healthScoreQuestionData.length; i++){
  //       controller.jumpTo(jumpPosition);
  //       if(i==whichPage){
  //         break;
  //       }
  //       jumpPosition = jumpPosition + orgPosition;
  //     }
  //   }
  // }

  TextStyle _textStyle = TextStyle(
      fontSize: 14,
      color: AppColors.lighttextColor,
      fontFamily: GoogleFonts.lato().fontFamily,
      fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appbarbackgroundColor,
        centerTitle: true,
        title: Text(
          "Health Question",
          style: TextStyle(
              color: AppColors.whitetextColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
              fontFamily: GoogleFonts.lato().fontFamily),
        ),
        // leading: Icon(Icons.arrow_back,color: Colors.white,),
      ),
      body: PageView.builder(
        controller: controller,
        physics: new NeverScrollableScrollPhysics(),
        itemCount: healthScoreQuestionData.length,
        itemBuilder: (context, index) {
          selectQuestion = index + 1;
          return Container(
            width: Get.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.white,
                Colors.white70,
              ]),
              borderRadius: BorderRadius.circular(0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Question : " + selectQuestion.toString(),
                          // overflow: TextOverflow.ellipsis,
                          // softWrap: false,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.appbarbackgroundColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: GoogleFonts.lato().fontFamily,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          selectQuestion.toString() +
                              "/" +
                              healthScoreQuestionData.length.toString(),
                          // overflow: TextOverflow.ellipsis,
                          // softWrap: false,
                          style: TextStyle(
                              fontSize: 15,
                              color: AppColors.appbarbackgroundColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: GoogleFonts.lato().fontFamily,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      healthScoreQuestionData[index].question,
                      style: TextStyle(
                          fontSize: 22,
                          color: AppColors.darktextColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: GoogleFonts.lato().fontFamily,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio(
                              groupValue: groupValue[index],
                              value: value[index][0],
                              onChanged: (newValue) {
                                setState(() {
                                  // print("dd"+value[index][0].toString());
                                  groupValue[index] = newValue;
                                  sumData.add(newValue - 30);
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                  healthScoreQuestionData[index].answerA,
                                  style: _textStyle),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Radio(
                              groupValue: groupValue[index],
                              value: value[index][1],
                              onChanged: (newValue) {
                                setState(() {
                                  groupValue[index] = newValue;
                                  // sumData.clear();
                                  sumData.add(newValue - 30);
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                healthScoreQuestionData[index].answerB,
                                style: _textStyle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Radio(
                              groupValue: groupValue[index],
                              value: value[index][2],
                              onChanged: (newValue) {
                                setState(() {
                                  groupValue[index] = newValue;
                                  // sumData.clear();
                                  sumData.add(newValue - 30);
                                  print("sumData2" + sumData.toString());
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                healthScoreQuestionData[index].answerC,
                                style: _textStyle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Radio(
                              groupValue: groupValue[index],
                              value: value[index][3],
                              onChanged: (newValue) {
                                setState(() {
                                  groupValue[index] = newValue;
                                  // sumData.clear();
                                  sumData.add(newValue - 30);
                                  print("sumData3" + sumData.toString());
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                healthScoreQuestionData[index].answerD,
                                style: _textStyle,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (((healthScoreQuestionData[0])) ==
                          healthScoreQuestionData[index])
                        SizedBox()
                      else if (((healthScoreQuestionData.length)) ==
                          selectQuestion)
                        SizedBox()
                      else
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: InkWell(
                                onTap: () {
                                  controller.previousPage(
                                      duration: _kDuration, curve: _kCurve);
                                },
                                child: CustomButton(
                                    text1: "",
                                    text2: "Back",
                                    width: 90,
                                    height: 35)),
                            // child: FloatingActionButton(
                            //     elevation: 0.0,
                            //     child: new Icon(Icons.navigate_before,size: 50,),
                            //     backgroundColor: new Color(0xFFE57373),
                            //     onPressed: (){
                            //       controller.previousPage(duration: _kDuration, curve: _kCurve);
                            //     }
                            // ),
                          ),
                        ),
                      if (((healthScoreQuestionData.length)) == selectQuestion)
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            if (_isLoad)
                              Center(child: CircularProgressIndicator())
                            else
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: InkWell(
                                    onTap: () async {
                                      num sum = 0;
                                      sumData.forEach((element) {
                                        sum += element;
                                        print("hjasgdka" + sum.toString());
                                      });
                                      await SharedPrefManager.savePrefString(
                                          AppConstant.ANSWERNUMBER,
                                          sum.isNull
                                              ? 0.toString()
                                              : sum.toString());
                                      Get.off(HealthDetailsPage(),
                                          transition:
                                              Transition.rightToLeftWithFade,
                                          duration:
                                              Duration(milliseconds: 600));
                                    },
                                    child: CustomButton(
                                        text1: "",
                                        text2: "Submit",
                                        width: 150,
                                        height: 45)),
                              ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      else
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: InkWell(
                                onTap: () {
                                  controller.nextPage(
                                      duration: _kDuration, curve: _kCurve);
                                },
                                child: CustomButton(
                                    text1: "",
                                    text2: "Next",
                                    width: 90,
                                    height: 35)),

                            // FloatingActionButton(
                            //     elevation: 0.0,
                            //     child: new Icon(Icons.navigate_next,size: 50,),
                            //     backgroundColor: new Color(0xFFE57373),
                            //     onPressed: (){
                            //       controller.nextPage(duration: _kDuration, curve: _kCurve);
                            //     }
                            // ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  var buttonText;
  List<int> newwSum = [];

  RadioModel(this.isSelected, this.buttonText, [this.newwSum]);
}
