// // // @dart=2.9
// // import 'package:aec_medical/api/AppConstant.dart';
// // import 'package:aec_medical/api/repository/auth_repo.dart';
// // import 'package:aec_medical/api/sharedprefrence.dart';
// // import 'package:aec_medical/custom/custom_button.dart';
// // import 'package:aec_medical/model/homeModel/totalHealthquestion_model.dart';
// // import 'package:aec_medical/pages/dashboard/drawer/total_health/totalhealthscore_result_page.dart';
// // import 'package:aec_medical/utils/colors.dart';
// // import 'package:aec_medical/utils/strings_style.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:provider/provider.dart';
// //
// // class QuestionFitness extends StatefulWidget {
// //
// //   @override
// //   _QuestionFitnessState createState() => _QuestionFitnessState();
// // }
// //
// // class _QuestionFitnessState extends State<QuestionFitness> {
// //
// //   int selectedIndex,selectedIndex1,selectedIndex2,selectedIndex3;
// //   var selectQuestion = 0,selectedAnswer = "",selectone;
// //   bool _isLoad = false;
// //    List<String> SelectedList = ["0", "0", "0", "0", "0", "0","0", "0", "0", "0", "0", "0","0", "0", "0", "0", "0", "0","0", "0", "0", "0", "0", "0","0", "0", "0", "0", "0", "0","0", "0", "0", "0", "0", "0","0", "0", "0", "0", "0", "0","0", "0", "0", "0", "0", "0","0", "0", "0", "0", "0", "0","0", "0", "0", "0", "0", "0",];
// //
// //   var selectedIndexx = 0;
// //   Set addId = new Set();
// //
// //   bool isPresent(String name) {
// //     return addId.contains(name);}
// //
// //   List<HealthScoreQuestionData> healthScoreQuestionData = [];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //    AuthRepo authRepo = new AuthRepo();
// //     Future future = authRepo.healthScoreQuestionApi();
// //     future.then((value){
// //       setState(() {
// //         healthScoreQuestionData = value;
// //       });
// //       print("fffffffffffffffff"+healthScoreQuestionData[0].question);
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.backgroundColor,
// //         appBar: AppBar(
// //           elevation: 0,
// //           backgroundColor: AppColors.appbarbackgroundColor,
// //           centerTitle: true,
// //           title: Text("Health Question",style: StringsStyle.pagetitlestyle),
// //           // leading: Icon(Icons.arrow_back,color: Colors.white,),
// //         ),
// //         body: SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               if(healthScoreQuestionData.isNull)
// //                 Center(child: Container(
// //                     height: 250,
// //                     alignment: Alignment.center,
// //                     child: Text("Sorry! No Data Found.")))
// //               else  if(healthScoreQuestionData.isEmpty)
// //                 Padding(
// //                   padding: const EdgeInsets.only(top:30.0),
// //                   child: Center(child: CircularProgressIndicator()),
// //                 )
// //             else ListView.builder(
// //                 physics: NeverScrollableScrollPhysics(),
// //                 shrinkWrap: true,
// //                 itemCount: healthScoreQuestionData.length,
// //                 itemBuilder: (context,index){
// //                   selectQuestion = index+1;
// //                   return InkWell(
// //                     onTap: ()async{
// //                       SelectedList[index] = SelectedList[index] == "0" ? "1" : "0";
// //                       // await SharedPrefManager.savePrefString(AppConstant.TABLE, "1");
// //                     },
// //                     child: Container(
// //                       padding: EdgeInsets.all(20),
// //                       // color: Colors.black87,
// //                       child: Column(
// //                         children: <Widget>[
// //                           Align(
// //                             alignment: Alignment.centerLeft,
// //                             child: Text("Question "+selectQuestion.toString(),style: TextStyle(
// //                                 fontSize: 22,
// //                                 color: AppColors.appbarbackgroundColor,
// //                                 fontWeight: FontWeight.w700,
// //                                 fontStyle: FontStyle.italic
// //                             ),),
// //                           ),
// //
// //                           SizedBox(
// //                             height: 10,
// //                           ),
// //
// //                           Align(
// //                             alignment: Alignment.centerLeft,
// //                             child: Text(healthScoreQuestionData[index].question,
// //                               style: TextStyle(
// //                                   wordSpacing: 1,
// //                                   height: 1.2,
// //                                   color: Color(0XFF363636),
// //                                   fontWeight: FontWeight.w400
// //                               ),),
// //                           ),
// //
// //                           SizedBox(height: 20,),
// //
// //                           Column(
// //                             children: [
// //
// //                               // ListTile(
// //                               //   onTap: (){
// //                               //     setState(() {
// //                               //       selectedAnswer = healthScoreQuestionData[index].answerA;
// //                               //     });},
// //                               //   leading: Container(
// //                               //     margin: EdgeInsets.only(top: 3),
// //                               //     width: 18,
// //                               //     height: 18,
// //                               //     decoration: BoxDecoration(
// //                               //       borderRadius: BorderRadius.all(Radius.circular(10)),
// //                               //       border: Border.all(color: selectedAnswer == healthScoreQuestionData[index].answerA?Colors.black:Colors.blueGrey,width: 3),
// //                               //       // border: Border.all(color: selectedIndex == index? Colors.black:Colors.blueGrey,width: 2),
// //                               //       // color: selectedIndex == index? Colors.black:Colors.white
// //                               //     ),
// //                               //   ),
// //                               //   title: Transform.translate(
// //                               //     offset: Offset(-20, 0),
// //                               //     child: Text(healthScoreQuestionData[index].answerA,style: TextStyle(
// //                               //         fontSize: 16,
// //                               //         color: Color(0XFF585A59),
// //                               //         fontWeight: FontWeight.w600
// //                               //     ),),
// //                               //   ),
// //                               // ),
// //                               //
// //                               // ListTile(
// //                               //   onTap: (){
// //                               //     setState(() {
// //                               //       // selectedIndex1 = index;
// //                               //       selectone = healthScoreQuestionData[index].answerB;
// //                               //     });
// //                               //   },
// //                               //   leading: Container(
// //                               //     margin: EdgeInsets.only(top: 3),
// //                               //     width: 18,
// //                               //     height: 18,
// //                               //     decoration: BoxDecoration(
// //                               //       borderRadius: BorderRadius.all(Radius.circular(10)),
// //                               //       border: Border.all(color: selectone == healthScoreQuestionData[index].answerB?Colors.black:Colors.blueGrey,width: 3),
// //                               //       // color: selectedIndex1 == index? Colors.black:Colors.white
// //                               //     ),
// //                               //   ),
// //                               //   title: Transform.translate(
// //                               //     offset: Offset(-20, 0),
// //                               //     child: Text(healthScoreQuestionData[index].answerB,style: TextStyle(
// //                               //         fontSize: 16,
// //                               //         color: Color(0XFF585A59),
// //                               //         fontWeight: FontWeight.w600
// //                               //     ),),
// //                               //   ),
// //                               // ),
// //                               //
// //                               // ListTile(
// //                               //   onTap: (){
// //                               //     setState(() {
// //                               //       // selectedIndex2 = index;
// //                               //       selectedAnswer = healthScoreQuestionData[index].answerC;
// //                               //     });
// //                               //   },
// //                               //   leading: Container(
// //                               //     margin: EdgeInsets.only(top: 3),
// //                               //     width: 18,
// //                               //     height: 18,
// //                               //     decoration: BoxDecoration(
// //                               //       borderRadius: BorderRadius.all(Radius.circular(10)),
// //                               //       border: Border.all(color: selectedAnswer == healthScoreQuestionData[index].answerC?Colors.black:Colors.blueGrey,width: 3),
// //                               //       // color: selectedIndex2 == index? Colors.black:Colors.white
// //                               //     ),
// //                               //   ),
// //                               //   title: Transform.translate(
// //                               //     offset: Offset(-20, 0),
// //                               //     child: Text(healthScoreQuestionData[index].answerC,style: TextStyle(
// //                               //         fontSize: 16,
// //                               //         color: Color(0XFF585A59),
// //                               //         fontWeight: FontWeight.w600
// //                               //     ),),
// //                               //   ),
// //                               // ),
// //                               //
// //                               // ListTile(
// //                               //   onTap: (){
// //                               //     setState(() {
// //                               //       // selectedIndex3 = index;
// //                               //       selectedAnswer = healthScoreQuestionData[index].answerD;
// //                               //     });
// //                               //   },
// //                               //   leading: Container(
// //                               //     margin: EdgeInsets.only(top: 3),
// //                               //     width: 18,
// //                               //     height: 18,
// //                               //     decoration: BoxDecoration(
// //                               //       borderRadius: BorderRadius.all(Radius.circular(10)),
// //                               //       border: Border.all(color: selectedAnswer == healthScoreQuestionData[index].answerD?Colors.black:Colors.blueGrey,width: 3),
// //                               //       // color: selectedIndex3 == index? Colors.black:Colors.white
// //                               //     ),
// //                               //   ),
// //                               //   title: Transform.translate(
// //                               //     offset: Offset(-20, 0),
// //                               //     child: Text(healthScoreQuestionData[index].answerD,style: TextStyle(
// //                               //         fontSize: 16,
// //                               //         color: Color(0XFF585A59),
// //                               //         fontWeight: FontWeight.w600
// //                               //     ),),
// //                               //   ),
// //                               // ),
// //
// //                             ],
// //                           ),
// //
// //                         ],
// //                       ),
// //                     ),
// //                   );
// //                 }),
// //               SizedBox(height: 20,),
// //               if(_isLoad)
// //                 Center(child: CircularProgressIndicator())
// //               else Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 25),
// //                 child: InkWell(
// //                     onTap: () {
// //                       Get.off(HealthScoreResultPage(),
// //                           transition: Transition.rightToLeftWithFade,
// //                           duration: Duration(milliseconds: 600));
// //
// //                       // if (_formKey.currentState!.validate()) {
// //                       //
// //                       // }
// //                     },
// //                     child: CustomButton(
// //                         text1: "",
// //                         text2: "Submit",
// //                         width: Get.width,
// //                         height: 50)),
// //               ),
// //               SizedBox(height: 30,),
// //
// //                ],
// //              ),
// //         ));
// //   }
// // }
// // @dart=2.9
// import 'package:aec_medical/api/AppConstant.dart';
// import 'package:aec_medical/api/repository/auth_repo.dart';
// import 'package:aec_medical/api/sharedprefrence.dart';
// import 'package:aec_medical/custom/custom_button.dart';
// import 'package:aec_medical/model/homeModel/totalHealthquestion_model.dart';
// import 'package:aec_medical/pages/dashboard/drawer/total_health/totalhealthscore_result_page.dart';
// import 'package:aec_medical/utils/colors.dart';
// import 'package:aec_medical/utils/strings_style.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class QuestionFitness extends StatefulWidget {
//   @override
//   _QuestionFitnessState createState() => _QuestionFitnessState();
// }
// int selectedRadio;
// int _groupValue = -1;
//
// class _QuestionFitnessState extends State<QuestionFitness> {
//
//   var selectQuestion = 0,selectedAnswer = "",selectone;
//   List<HealthScoreQuestionData> healthScoreQuestionData = [];
//
//   List<int> groupValue = [];
//   List<List<int>> value = [];
//   List<int> sumData = [];
//   List<int> ssumData = [];
//   Set set = Set();
//
//
//   @override
//   void initState() {
//     super.initState();
//     AuthRepo authRepo = new AuthRepo();
//     Future future = authRepo.healthScoreQuestionApi();
//     future.then((value){
//       setState(() {
//         healthScoreQuestionData = value;
//       });
//       print("fffffffffffffffff"+healthScoreQuestionData[0].question);
//     });
//
//
//     groupValue.add(0);
//     groupValue.add(1);
//     groupValue.add(2);
//     groupValue.add(3);
//     groupValue.add(4);
//     groupValue.add(5);
//     groupValue.add(6);
//     groupValue.add(7);
//     groupValue.add(8);
//     groupValue.add(9);
//     groupValue.add(10);
//     groupValue.add(11);
//     groupValue.add(12);
//     groupValue.add(13);
//     groupValue.add(14);
//     groupValue.add(15);
//     groupValue.add(16);
//     groupValue.add(17);
//     groupValue.add(18);
//     groupValue.add(19);
//     groupValue.add(20);
//     groupValue.add(21);
//     groupValue.add(22);
//     // groupValue.add(23);
//     // groupValue.add(24);
//
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     value.add([31,32,33,34]);
//     // value.add([1,2,3,4]);
//     // value.add([1,2,3,4]);
//   }
//
//   bool _isLoad = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: AppColors.appbarbackgroundColor,
//         centerTitle: true,
//         title: Text("Health Question",style: StringsStyle.pagetitlestyle),
//         // leading: Icon(Icons.arrow_back,color: Colors.white,),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             if(healthScoreQuestionData.isNull)
//               Center(child: Container(
//                   height: 250,
//                   alignment: Alignment.center,
//                   child: Text("Sorry! No Data Found.")))
//             else  if(healthScoreQuestionData.isEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(top:30.0),
//                 child: Center(child: CircularProgressIndicator()),
//               )
//             else Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: ListView.builder(
//                    physics: NeverScrollableScrollPhysics(),
//                    shrinkWrap: true,
//                    itemCount: healthScoreQuestionData.length,
//                    itemBuilder: (context,index){
//                      selectQuestion = index+1;
//                      return Container(
//                         // padding: EdgeInsets.only(top: 2),
//                        child: Column(
//                          children: <Widget>[
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           child: Text("Question: "+selectQuestion.toString(),
//                            // overflow: TextOverflow.ellipsis,
//                            // softWrap: false,
//                            style: TextStyle(
//                                fontSize: 20,
//                                color: AppColors.appbarbackgroundColor,
//                                fontWeight: FontWeight.w700,
//                                fontStyle: FontStyle.italic
//                            ),),
//                         ),
//                            SizedBox(height: 5,),
//                            Container(
//                              alignment: Alignment.centerLeft,
//                              child: Text(healthScoreQuestionData[index].question,
//                                style: TextStyle(
//                                    fontSize: 20,
//                                    color: AppColors.appbarbackgroundColor,
//                                    fontWeight: FontWeight.w700,
//                                    fontStyle: FontStyle.italic
//                                ),),
//                            ),
//                            SizedBox(height: 20,),
//                            Align(
//                              alignment: Alignment.centerLeft,
//                              child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                children: [
//                                  Row(
//                                    children: [
//                                      Radio(
//                                        groupValue: groupValue[index],
//                                        value: value[index][0],
//                                        onChanged: (newValue) {
//                                          setState(() {
//                                            // print("dd"+value[index][0].toString());
//
//                                            groupValue[index] = newValue;
//                                            sumData.add(newValue-30);
//
//                                            /*if(set.isEmpty){
//                                              setState(() {
//                                                set.add(index.toString());
//                                                sumData.add(newValue);
//                                                print(sumData.toList());
//                                                print("add");
//                                                print(set);
//                                              });}
//                                            else{
//                                              for(var name in set) {
//                                                if(name == index.toString()) {
//                                                  setState(() {
//                                                    set.remove(index.toString());
//                                                    ssumData.add(newValue);
//                                                    print("remove");
//                                                    print(ssumData.toList());
//                                                    print(set.toString());});
//                                                  break;}
//                                                else {
//                                                  setState(() {
//                                                    set.add(index.toString());
//                                                    sumData.add(newValue);
//                                                    print(sumData.toList());
//                                                    print("add");
//                                                    print(set);
//                                                  });
//                                                }}
//                                            }*/
//
//                                          });
//                                        },
//                                      ),
//                                      Text(healthScoreQuestionData[index].answerA,style: TextStyle(
//                                          fontSize: 16,
//                                          color: Color(0XFF585A59),
//                                          fontWeight: FontWeight.w600
//                                      ),),
//                                    ],
//                                  ),
//                                   SizedBox(height: 20,),
//                                  Row(
//                                    children: [
//                                      Radio(
//                                        groupValue: groupValue[index],
//                                        value: value[index][1],
//                                        onChanged: (newValue) {
//                                          setState(() {
//                                            groupValue[index] = newValue;
//                                            /*if(set.isEmpty){
//                                              setState(() {
//                                                set.add(index.toString());
//                                                sumData.add(newValue);
//                                                print(sumData.toString());
//                                                print("add");
//                                                print(set);
//                                              });}
//                                            else{
//                                              for(var name in set) {
//                                                if(name == index.toString()) {
//                                                  setState(() {
//                                                    set.remove(index.toString());
//                                                    ssumData.remove(newValue);
//                                                    print("remove");
//                                                    print(ssumData.toList());
//                                                    print(set.toString());});
//                                                  break;}
//                                                else {
//                                                  setState(() {
//                                                    set.add(index.toString());
//                                                    sumData.add(newValue);
//                                                    print(sumData.toList());
//                                                    print("add");
//                                                    print(set);
//                                                  });
//                                                }}
//                                            }*/
//                                            // sumData.clear();
//                                            sumData.add(newValue-30);
//                                          });
//                                        },
//                                      ),
//                                      Text(healthScoreQuestionData[index].answerB,style: TextStyle(
//                                          fontSize: 16,
//                                          color: Color(0XFF585A59),
//                                          fontWeight: FontWeight.w600
//                                      ),),
//                                    ],
//                                  ),
//                                  SizedBox(height: 20,),
//                                  Row(
//                                    children: [
//                                      Radio(
//                                        groupValue: groupValue[index],
//                                        value: value[index][2],
//                                        onChanged: (newValue) {
//                                          setState(() {
//                                            groupValue[index] = newValue;
//                                            // sumData.clear();
//                                            sumData.add(newValue-30);
//                                            print("sumData2"+sumData.toString());
//                                          });
//                                        },
//                                      ),
//                                      Text(healthScoreQuestionData[index].answerC,style: TextStyle(
//                                          fontSize: 16,
//                                          color: Color(0XFF585A59),
//                                          fontWeight: FontWeight.w600
//                                      ),),
//                                    ],
//                                  ),
//                                  SizedBox(height: 20,),
//                                  Row(
//                                    children: [
//                                      Radio(
//                                        groupValue: groupValue[index],
//                                        value: value[index][3],
//                                        onChanged: (newValue) {
//                                          setState(() {
//                                            groupValue[index] = newValue;
//                                            // sumData.clear();
//                                            sumData.add(newValue-30);
//                                            print("sumData3"+sumData.toString());
//                                          });
//                                        },
//                                      ),
//                                      Text(healthScoreQuestionData[index].answerD,style: TextStyle(
//                                          fontSize: 16,
//                                          color: Color(0XFF585A59),
//                                          fontWeight: FontWeight.w600
//                                      ),),
//                                    ],
//                                  ),
//                                  SizedBox(height: 20,),
//                                ],
//                              ),
//                            ),
//                          ],
//                        ),
//                      );
//                    }),
//             ),
//             SizedBox(height: 20,),
//             if(_isLoad)
//               Center(child: CircularProgressIndicator())
//             else Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25),
//               child: InkWell(
//                   onTap: () async{
//                     num sum = 0;
//                     sumData.forEach((element) {
//                       sum +=element;
//                       print("hjasgdka"+sum.toString());
//                     });
//                     await SharedPrefManager.savePrefString(AppConstant.ANSWERNUMBER, sum.toString());
//                     Get.off(HealthScoreResultPage(),
//                         transition: Transition.rightToLeftWithFade,
//                         duration: Duration(milliseconds: 600));
//                   },
//                   child: CustomButton(
//                       text1: "",
//                       text2: "Submit",
//                       width: Get.width,
//                       height: 50)),
//             ),
//             SizedBox(height: 30,),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class RadioModel {
//   bool isSelected;
//   var buttonText;
//   List<int> newwSum = [];
//   RadioModel(this.isSelected, this.buttonText,[this.newwSum]);
// }