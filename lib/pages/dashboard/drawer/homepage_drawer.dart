// import 'package:aec_medical/pages/dashboard/consultation/medical_history_page.dart';
// import 'package:aec_medical/pages/dashboard/consultation/select_speciality_page.dart';
// import 'package:aec_medical/pages/dashboard/drawer/total_health/courses/courses_page.dart';
// import 'package:aec_medical/pages/dashboard/drawer/total_health/couselling_page.dart';
// import 'package:aec_medical/pages/dashboard/drawer/total_health/total_health_page.dart';
// import 'package:aec_medical/pages/dashboard/drawer/total_health/totalhealthquestion_page.dart';
// import 'package:aec_medical/pages/dashboard/drawer/total_health/totalhealthscore_result_page.dart';
// import 'package:aec_medical/utils/colors.dart';
// import 'package:aec_medical/utils/strings.dart';
// import 'package:aec_medical/utils/strings_style.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class HomePageDrawer extends StatefulWidget {
//   const HomePageDrawer({Key? key}) : super(key: key);
//
//   @override
//   _HomePageDrawerState createState() => _HomePageDrawerState();
// }
//
// class _HomePageDrawerState extends State<HomePageDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.appbarbackgroundColor,
//         centerTitle: true,
//         title: Text("Home Page",
//           style: StringsStyle.pagetitlestyle,
//         ),
//         leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
//       ),
//       body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 _totalhealthcard(),
//                 SizedBox(
//                   height: 90,
//                 ),
//                 _counsellingbutton(),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 _coursesbutton(),
//                 SizedBox(height: 50,),
//               ],
//             ),
//           )),
//     );
//   }
//
//   _totalhealthcard() {
//     return Stack(
//       children: [
//         SizedBox(
//           width: Get.width,
//           child: Card(
//             elevation: 5,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 5),
//                       Text(
//                         Strings.CARDTEXT1,
//                         style: StringsStyle.cardtext1style,
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         Strings.CARDTEXT2,
//                         style: StringsStyle.cardtext2style,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Column(
//                         children: [
//                           Container(
//                               height: 100,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       image: AssetImage(
//                                           "assets/images/healthcardimage1.png")))),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           // ignore: deprecated_member_use
//                           InkWell(
//                             onTap: (){
//                               Get.to(QuestionFitness(),
//                                   transition: Transition.rightToLeftWithFade,
//                                   duration: Duration(milliseconds: 600));
//                             },
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.4),
//                                       spreadRadius: 1,
//                                       blurRadius: 3,
//                                       offset: Offset(0, 3),
//                                     ),
//                                   ],
//                                   gradient: LinearGradient(colors: [
//                                     Colors.red.shade500,
//                                     AppColors.redColor,
//                                   ]),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 height: 50,
//                                 width: 165,
//                                 child: Center(
//                                   child: Center(
//                                     child: Text("Know Total Health Concept",
//                                         style: TextStyle(
//                                           color: AppColors.whitetextColor,
//                                           fontSize: 11,
//                                           letterSpacing: 0.3,
//                                         )),
//                                   ),
//                                 )),
//                           )
//                         ],
//                       ),
//                       //SizedBox(width: 5,),
//                       Column(
//                         children: [
//                           Container(
//                               height: 100,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       image: AssetImage(
//                                           "assets/images/healthcardimage2.png")))),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           // ignore: deprecated_member_use
//                           InkWell(
//                             onTap: (){
//                               Get.to(HealthScoreResultPage(),
//                                   transition: Transition.rightToLeftWithFade,
//                                   duration: Duration(milliseconds: 600));
//                             },
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.4),
//                                       spreadRadius: 1,
//                                       blurRadius: 3,
//                                       offset: Offset(0, 3),
//                                     ),
//                                   ],
//                                   gradient: LinearGradient(colors: [
//                                     Colors.red.shade500,
//                                     AppColors.redColor,
//                                   ]),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 height: 50,
//                                 width: 165,
//                                 child: Center(
//                                   child: Center(
//                                     child: Text("Know Total Health Score",
//                                         style: TextStyle(
//                                           color: AppColors.whitetextColor,
//                                           fontSize: 11,
//                                           letterSpacing: 0.3,
//                                         )),
//                                   ),
//                                 )),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 15),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           top: 5,
//           left: 5,
//           child: Container(
//               height: 60,
//               width: 60,
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage("assets/images/logo.png")))),
//         ),
//       ],
//     );
//   }
//
//   _counsellingbutton() {
//     // ignore: deprecated_member_use
//     return InkWell(
//         onTap: () {
//           Get.to(SelectSpecialityPage(),
//               transition: Transition.rightToLeftWithFade,
//               duration: Duration(milliseconds: 600));
//         },
//         child: Container(
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.4),
//                   spreadRadius: 1,
//                   blurRadius: 3,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//               gradient: LinearGradient(colors: [
//                 Colors.black26,
//                 Colors.black87,
//               ]),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             height: 50,
//             width: Get.width / 1.3,
//             child: Center(
//               child: Center(
//                 child: Text("Online Consultation",
//                     style: TextStyle(
//                       color: AppColors.whitetextColor,
//                       fontSize: 15,
//                       letterSpacing: 0.5,
//                     )),
//               ),
//             )));
//   }
//
//   _coursesbutton() {
//     return InkWell(
//         onTap: () {
//           Get.to(QuestionFitness(),
//               transition: Transition.rightToLeftWithFade,
//               duration: Duration(milliseconds: 600));
//         },
//         child: Container(
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.4),
//                   spreadRadius: 1,
//                   blurRadius: 3,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//               gradient: LinearGradient(colors: [
//                 Colors.black26,
//                 Colors.black87,
//               ]),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             height: 50,
//             width: Get.width / 1.3,
//             child: Center(
//               child: Center(
//                 child: Text("Get Your Total Health",
//                     style: TextStyle(
//                       color: AppColors.whitetextColor,
//                       fontSize: 15,
//                       letterSpacing: 0.5,
//                     )),
//               ),
//             )));
//   }
// }
