// import 'dart:async';
//
// import 'package:aec_medical/api/AppConstant.dart';
// import 'package:aec_medical/api/repository/consultation_repo.dart';
// import 'package:aec_medical/api/sharedprefrence.dart';
// import 'package:aec_medical/custom/custom_button.dart';
// import 'package:aec_medical/model/consultationModel/find_doctors_model.dart';
// import 'package:aec_medical/pages/dashboard/consultation/payment_page.dart';
// import 'package:aec_medical/utils/colors.dart';
// import 'package:aec_medical/utils/strings_style.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
//
// class FindDoctorsPage extends StatefulWidget {
//   const FindDoctorsPage({Key? key}) : super(key: key);
//
//   @override
//   _FindDoctorsPageState createState() => _FindDoctorsPageState();
// }
//
// class _FindDoctorsPageState extends State<FindDoctorsPage> {
//
//   late List<FindDoctorsData> findDoctorsData = [];
//   late Timer timer;
//   late Future future;
//
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) async {
//     ConsultationRepo consultationRepo = new ConsultationRepo();
//     Future future = consultationRepo.getDoctorDetailsApi();
//     future.then((value) {
//       setState(() {
//         findDoctorsData = value;
//         print("ssspeciality" + findDoctorsData[0].name);
//       });
//     });
//       });
//     });
//
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     timer.cancel();
//   }
//
//   var selectedtab = 0;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.appbarbackgroundColor,
//         centerTitle: true,
//         title: Text(
//           "Find Doctors",
//           style: StringsStyle.pagetitlestyle,
//         ),
//         leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _headingcard(),
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //_onlinedoctors(),
//                    // SizedBox(height: 10),
//                     Text(
//                         "We align consultation with our top doctors\nisted below",
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.appbarbackgroundColor)),
//                     SizedBox(height: 20),
//                     if(findDoctorsData.isEmpty)
//                       Center(child: CircularProgressIndicator())
//                   else if(findDoctorsData.isNull)
//                       Container(
//                         height: 200,
//                         child: Center(
//                           child: Text("Sorry! Doctor not Found",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black
//                           )),
//                         ),
//                       )
//                     else _listofdoctors(),
//                     // SizedBox(height: 10),
//                     // if(findDoctorsData.isNull)
//                     //   Text("")
//                     // else _listofdoctors(),
//                     SizedBox(height: 20),
//                     _nextbutton(),
//                   ]),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   _headingcard() {
//     return Stack(
//       children: [
//         SizedBox(
//           width: Get.width,
//           child: Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(15, 80, 15, 10),
//                 child: Row(
//                   children: [
//                     Column(
//                       children: [
//                         Text("Get online\nconsultation\nat your",
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColors.appbarbackgroundColor)),
//                         SizedBox(height: 5),
//                         Text("#Home",
//                             style: TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.appbarbackgroundColor)),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15.0),
//                       child: Container(
//                           height: 140,
//                           width: 180,
//                           decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   image:
//                                       AssetImage("assets/images/register.png"),
//                                   fit: BoxFit.cover))),
//                     ),
//                   ],
//                 ),
//               )),
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
//   // _onlinedoctors() {
//   //   return Row(
//   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //     children: [
//   //       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//   //         Text("Doctors",
//   //             style: TextStyle(
//   //                 fontSize: 15,
//   //                 fontWeight: FontWeight.w500,
//   //                 color: AppColors.darktextColor)),
//   //         SizedBox(height: 2),
//   //         Text("Online Now",
//   //             style: TextStyle(
//   //                 fontSize: 15,
//   //                 fontWeight: FontWeight.w500,
//   //                 color: AppColors.darktextColor)),
//   //       ]),
//   //       Row(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //           Stack(
//   //             children: [
//   //               Container(
//   //                 height: 70,
//   //                 width: Get.width - 180,
//   //               ),
//   //               Positioned(
//   //                   right: 120,
//   //                   child: CircleAvatar(
//   //                       radius: 25, backgroundColor: AppColors.lightblueColor)),
//   //               Positioned(
//   //                   right: 90,
//   //                   child: CircleAvatar(
//   //                       radius: 25, backgroundColor: AppColors.lighttextColor)),
//   //               Positioned(
//   //                   right: 60,
//   //                   child: CircleAvatar(
//   //                       radius: 25, backgroundColor: AppColors.redColor)),
//   //               Positioned(
//   //                   right: 30,
//   //                   child: CircleAvatar(
//   //                       radius: 25, backgroundColor: AppColors.errorColor)),
//   //               Positioned(
//   //                   right: 0,
//   //                   child: CircleAvatar(
//   //                       radius: 25, backgroundColor: AppColors.blueColor)),
//   //             ],
//   //           ),
//   //           SizedBox(width: 10),
//   //           Text("+112",
//   //               style: TextStyle(
//   //                   fontSize: 12,
//   //                   fontWeight: FontWeight.bold,
//   //                   color: AppColors.appbarbackgroundColor)),
//   //         ],
//   //       ),
//   //     ],
//   //   );
//   // }
// ///
//   // _listofdoctors() {
//   //   return Container(
//   //     height: Get.width,
//   //     // width: Get.width / 1,
//   //     child: ListView.builder(
//   //         itemCount: findDoctorsData.length,
//   //         scrollDirection: Axis.vertical,
//   //         itemBuilder: (BuildContext context, index) {
//   //           return Padding(
//   //             padding: const EdgeInsets.all(0.0),
//   //             child: InkWell(
//   //               onTap: () async{
//   //                 setState(() async{
//   //                   selectedtab = index;
//   //                   await SharedPrefManager.savePrefString(AppConstant.DOCTOR, findDoctorsData[selectedtab].doctorId);
//   //                   String doctor = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTOR);
//   //                   // Fluttertoast.showToast(msg: doctor,
//   //                   //     toastLength: Toast.LENGTH_SHORT,
//   //                   //     gravity: ToastGravity.CENTER,
//   //                   //     backgroundColor: Colors.black,
//   //                   //     textColor: Colors.white);
//   //                 });
//   //               },
//   //               child:  selectedtab == index?
//   //               Card(
//   //                 color: Colors.redAccent,
//   //                 elevation: 2,
//   //                 shape: RoundedRectangleBorder(
//   //                   borderRadius: BorderRadius.circular(10.0),
//   //                 ),
//   //                 child: Container(
//   //                     height: Get.width / 2.1,
//   //                     width: Get.width / 0.96,
//   //                     child: Padding(
//   //                       padding: const EdgeInsets.all(10.0),
//   //                       child: Row(
//   //                         children: [
//   //                           Column(children: [
//   //                             SizedBox(
//   //                               height: 100,
//   //                               width: 100,
//   //                               child: Card(
//   //                                 color: AppColors.appbarbackgroundColor,
//   //                                 elevation: 1,
//   //                                 shape: RoundedRectangleBorder(
//   //                                   borderRadius: BorderRadius.circular(5.0),
//   //                                 ),
//   //                                 child: Image.network(findDoctorsData[index].profile),
//   //                               ),
//   //                             ),
//   //                             SizedBox(height: 10),
//   //                             SizedBox(
//   //                                 height: 30,
//   //                                 width: 100,
//   //                                 child: Card(
//   //                                     color: AppColors.blueColor,
//   //                                     elevation: 1,
//   //                                     shape: RoundedRectangleBorder(
//   //                                       borderRadius: BorderRadius.circular(5.0),
//   //                                     ),
//   //                                     child: Center(
//   //                                       child: Text("${findDoctorsData[index].rating}/5",
//   //                                           style: TextStyle(
//   //                                               fontSize: 12,
//   //                                               fontWeight: FontWeight.bold,
//   //                                               color: AppColors.whitetextColor)),
//   //                                     ))),
//   //                           ]),
//   //                           SizedBox(width: 10),
//   //                           Column(
//   //                             crossAxisAlignment: CrossAxisAlignment.start,
//   //                             children: [
//   //                               Text("Dr. ${findDoctorsData[index].name}",
//   //                                   style: TextStyle(
//   //                                       fontSize: 15,
//   //                                       color: AppColors.darktextColor)),
//   //                               SizedBox(height: 5),
//   //                               Text(findDoctorsData[index].disease,
//   //                                   style: TextStyle(
//   //                                       color: AppColors.lighttextColor)),
//   //                               SizedBox(height: 3),
//   //                               Text("${findDoctorsData[index].experiance} years experience",
//   //                                   style: TextStyle(
//   //                                       color: AppColors.lighttextColor)),
//   //                               SizedBox(height: 3),
//   //                               Row(
//   //                                 children: [
//   //                                   Row(children: [
//   //                                     Icon(Icons.star, color: Colors.orange),
//   //                                     Icon(Icons.star, color: Colors.orange),
//   //                                     Icon(Icons.star, color: Colors.orange),
//   //                                     Icon(Icons.star_border,
//   //                                         color: Colors.orange),
//   //                                     Icon(Icons.star_border,
//   //                                         color: Colors.orange),
//   //                                   ]),
//   //                                   SizedBox(width: 5),
//   //                                   Text("(213)",
//   //                                       style: TextStyle(
//   //                                           color: AppColors.lighttextColor)),
//   //                                 ],
//   //                               ),
//   //                               SizedBox(height: 3),
//   //                               Row(
//   //                                 children: [
//   //                                   Text("1000+ consults done ",
//   //                                       style: TextStyle(
//   //                                           color: AppColors.darktextColor)),
//   //                                   SizedBox(width: 10),
//   //                                   Text("Know more",
//   //                                       style: TextStyle(
//   //                                           color: AppColors.darktextColor)),
//   //                                 ],
//   //                               ),
//   //                             ],
//   //                           ),
//   //                         ],
//   //                       ),
//   //                     )),
//   //               )
//   //                   :Card(
//   //                 elevation: 2,
//   //                 shape: RoundedRectangleBorder(
//   //                   borderRadius: BorderRadius.circular(10.0),
//   //                 ),
//   //                 child: Container(
//   //                     height: Get.width / 2.1,
//   //                     width: Get.width / 0.96,
//   //                     child: Padding(
//   //                       padding: const EdgeInsets.all(10.0),
//   //                       child: Row(
//   //                         children: [
//   //                           Column(children: [
//   //                             SizedBox(
//   //                               height: 100,
//   //                               width: 100,
//   //                               child: Card(
//   //                                 color: AppColors.appbarbackgroundColor,
//   //                                 elevation: 1,
//   //                                 shape: RoundedRectangleBorder(
//   //                                   borderRadius: BorderRadius.circular(5.0),
//   //                                 ),
//   //                                 child: Image.network(findDoctorsData[index].profile),
//   //                               ),
//   //                             ),
//   //                             SizedBox(height: 10),
//   //                             SizedBox(
//   //                                 height: 30,
//   //                                 width: 100,
//   //                                 child: Card(
//   //                                     color: AppColors.blueColor,
//   //                                     elevation: 1,
//   //                                     shape: RoundedRectangleBorder(
//   //                                       borderRadius: BorderRadius.circular(5.0),
//   //                                     ),
//   //                                     child: Center(
//   //                                       child: Text("${findDoctorsData[index].rating}/5",
//   //                                           style: TextStyle(
//   //                                               fontSize: 12,
//   //                                               fontWeight: FontWeight.bold,
//   //                                               color: AppColors.whitetextColor)),
//   //                                     ))),
//   //                           ]),
//   //                           SizedBox(width: 10),
//   //                           Column(
//   //                             crossAxisAlignment: CrossAxisAlignment.start,
//   //                             children: [
//   //                               Text("Dr. ${findDoctorsData[index].name}",
//   //                                   style: TextStyle(
//   //                                       fontSize: 15,
//   //                                       color: AppColors.darktextColor)),
//   //                               SizedBox(height: 5),
//   //                               Text(findDoctorsData[index].disease,
//   //                                   style: TextStyle(
//   //                                       color: AppColors.lighttextColor)),
//   //                               SizedBox(height: 3),
//   //                               Text("${findDoctorsData[index].experiance} years experience",
//   //                                   style: TextStyle(
//   //                                       color: AppColors.lighttextColor)),
//   //                               SizedBox(height: 3),
//   //                               Row(
//   //                                 children: [
//   //                                   Row(children: [
//   //                                     Icon(Icons.star, color: Colors.orange),
//   //                                     Icon(Icons.star, color: Colors.orange),
//   //                                     Icon(Icons.star, color: Colors.orange),
//   //                                     Icon(Icons.star_border,
//   //                                         color: Colors.orange),
//   //                                     Icon(Icons.star_border,
//   //                                         color: Colors.orange),
//   //                                   ]),
//   //                                   SizedBox(width: 5),
//   //                                   Text("(213)",
//   //                                       style: TextStyle(
//   //                                           color: AppColors.lighttextColor)),
//   //                                 ],
//   //                               ),
//   //                               SizedBox(height: 3),
//   //                               Row(
//   //                                 children: [
//   //                                   Text("1000+ consults done ",
//   //                                       style: TextStyle(
//   //                                           color: AppColors.darktextColor)),
//   //                                   SizedBox(width: 10),
//   //                                   Text("Know more",
//   //                                       style: TextStyle(
//   //                                           color: AppColors.darktextColor)),
//   //                                 ],
//   //                               ),
//   //                             ],
//   //                           ),
//   //                         ],
//   //                       ),
//   //                     )),
//   //               ),
//   //             ),
//   //           );
//   //         }),
//   //   );
//   // }
//   _listofdoctors() {
//     return Container(
//       height: Get.width / 2.1,
//       width: Get.width / 1,
//       child: ListView.builder(
//           itemCount: findDoctorsData.length,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (BuildContext context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(0.0),
//               child: InkWell(
//                 onTap: () async{
//                   setState(() async{
//                     selectedtab = index;
//                     await SharedPrefManager.savePrefString(AppConstant.DOCTOR, findDoctorsData[selectedtab].doctorId);
//                     String doctor = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTOR);
//                     // Fluttertoast.showToast(msg: doctor,
//                     //     toastLength: Toast.LENGTH_SHORT,
//                     //     gravity: ToastGravity.CENTER,
//                     //     backgroundColor: Colors.black,
//                     //     textColor: Colors.white);
//                          });
//                 },
//                 child:  selectedtab == index?
//                 Card(
//                   color: Colors.redAccent,
//                   elevation: 2,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: Container(
//                       height: Get.width / 2.1,
//                       width: Get.width / 0.96,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Row(
//                           children: [
//                             Column(children: [
//                               SizedBox(
//                                 height: 100,
//                                 width: 100,
//                                 child: Card(
//                                   color: AppColors.appbarbackgroundColor,
//                                   elevation: 1,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5.0),
//                                   ),
//                                   child: Image.network(findDoctorsData[index].profile),
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               SizedBox(
//                                   height: 30,
//                                   width: 100,
//                                   child: Card(
//                                       color: AppColors.blueColor,
//                                       elevation: 1,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(5.0),
//                                       ),
//                                       child: Center(
//                                         child: Text("${findDoctorsData[index].rating}/5",
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: AppColors.whitetextColor)),
//                                       ))),
//                             ]),
//                             SizedBox(width: 10),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("Dr. ${findDoctorsData[index].name}",
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         color: AppColors.darktextColor)),
//                                 SizedBox(height: 5),
//                                 Text(findDoctorsData[index].disease,
//                                     style: TextStyle(
//                                         color: AppColors.lighttextColor)),
//                                 SizedBox(height: 3),
//                                 Text("${findDoctorsData[index].experiance} years experience",
//                                     style: TextStyle(
//                                         color: AppColors.lighttextColor)),
//                                 SizedBox(height: 3),
//                                 Row(
//                                   children: [
//                                     Row(children: [
//                                       Icon(Icons.star, color: Colors.orange),
//                                       Icon(Icons.star, color: Colors.orange),
//                                       Icon(Icons.star, color: Colors.orange),
//                                       Icon(Icons.star_border,
//                                           color: Colors.orange),
//                                       Icon(Icons.star_border,
//                                           color: Colors.orange),
//                                     ]),
//                                     SizedBox(width: 5),
//                                     Text("(213)",
//                                         style: TextStyle(
//                                             color: AppColors.lighttextColor)),
//                                   ],
//                                 ),
//                                 SizedBox(height: 3),
//                                 Row(
//                                   children: [
//                                     Text("1000+ consults done ",
//                                         style: TextStyle(
//                                             color: AppColors.darktextColor)),
//                                     SizedBox(width: 10),
//                                     Text("Know more",
//                                         style: TextStyle(
//                                             color: AppColors.darktextColor)),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       )),
//                 )
//                 :Card(
//                   elevation: 2,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: Container(
//                       height: Get.width / 2.1,
//                       width: Get.width / 0.96,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Row(
//                           children: [
//                             Column(children: [
//                               SizedBox(
//                                   height: 100,
//                                   width: 100,
//                                   child: Card(
//                                     color: AppColors.appbarbackgroundColor,
//                                     elevation: 1,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(5.0),
//                                     ),
//                                     child: Image.network(findDoctorsData[index].profile),
//                                   ),
//                               ),
//                               SizedBox(height: 10),
//                               SizedBox(
//                                   height: 30,
//                                   width: 100,
//                                   child: Card(
//                                       color: AppColors.blueColor,
//                                       elevation: 1,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(5.0),
//                                       ),
//                                       child: Center(
//                                         child: Text("${findDoctorsData[index].rating}/5",
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: AppColors.whitetextColor)),
//                                       ))),
//                             ]),
//                             SizedBox(width: 10),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("Dr. ${findDoctorsData[index].name}",
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         color: AppColors.darktextColor)),
//                                 SizedBox(height: 5),
//                                 Text(findDoctorsData[index].disease,
//                                     style: TextStyle(
//                                         color: AppColors.lighttextColor)),
//                                 SizedBox(height: 3),
//                                 Text("${findDoctorsData[index].experiance} years experience",
//                                     style: TextStyle(
//                                         color: AppColors.lighttextColor)),
//                                 SizedBox(height: 3),
//                                 Row(
//                                   children: [
//                                     Row(children: [
//                                       Icon(Icons.star, color: Colors.orange),
//                                       Icon(Icons.star, color: Colors.orange),
//                                       Icon(Icons.star, color: Colors.orange),
//                                       Icon(Icons.star_border,
//                                           color: Colors.orange),
//                                       Icon(Icons.star_border,
//                                           color: Colors.orange),
//                                     ]),
//                                     SizedBox(width: 5),
//                                     Text("(213)",
//                                         style: TextStyle(
//                                             color: AppColors.lighttextColor)),
//                                   ],
//                                 ),
//                                 SizedBox(height: 3),
//                                 Row(
//                                   children: [
//                                     Text("1000+ consults done ",
//                                         style: TextStyle(
//                                             color: AppColors.darktextColor)),
//                                     SizedBox(width: 10),
//                                     Text("Know more",
//                                         style: TextStyle(
//                                             color: AppColors.darktextColor)),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       )),
//                 ),
//               ),
//             );
//           }),
//     );
//   }
//
//   _nextbutton() {
//     // ignore: deprecated_member_use
//     return Padding(
//       padding: const EdgeInsets.all(0.0),
//       child: Align(
//         alignment: Alignment.bottomRight,
//         // ignore: deprecated_member_use
//         child: FlatButton(
//             onPressed: () async{
//               var price = await SharedPrefManager.getPrefrenceString(AppConstant.PRICE);
//               String type = await SharedPrefManager.getPrefrenceString(AppConstant.TYPE);
//               Get.off(PaymentPage(),arguments: [(int.parse(price)),type],
//                   transition: Transition.rightToLeftWithFade,
//                   duration: Duration(milliseconds: 600));
//             },
//             child:
//                 CustomButton(text1: "", text2: "Next", width: 150, height: 50)),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/consultation_repo.dart';
import 'package:aec_medical/api/repository/home_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/bestcounselor_model.dart';
import 'package:aec_medical/model/consultationModel/find_doctors_model.dart';
import 'package:aec_medical/pages/dashboard/consultation/payment_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/couselling_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class BestCounselorPage extends StatefulWidget {
  const BestCounselorPage({Key? key}) : super(key: key);

  @override
  _BestCounselorPageState createState() => _BestCounselorPageState();
}

class _BestCounselorPageState extends State<BestCounselorPage> {

  late List<BestCounselorData> bestCounselorData = [];
  late Timer timer;
  bool checkb = false;
  late double _rating;
  double _initialRating = 0.0;
  bool _isVertical = false;
  // IconData? _selectedIcon;



  @override
  void initState() {
    super.initState();
   HomeRepo homeRepo  = new HomeRepo();
    Future future = homeRepo.bestCounselorApi();
    future.then((value){
      setState(() {
        bestCounselorData = value;
      });
      print("fffffffffffffssffff"+bestCounselorData[0].name);
    });
    _rating = _initialRating;
  }


  var selectedtab = 0;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appbarbackgroundColor,
        centerTitle: true,
        title: Text(
          "Best Counselor",
          style: StringsStyle.pagetitlestyle,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
      ),
      body: bestCounselorData.isNull?Center(child: Text("Sorry! Best Counselor not available "))
       : bestCounselorData.isEmpty?Center(child: CircularProgressIndicator()):SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headingcard(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Best Counselor",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.appbarbackgroundColor)),
                    SizedBox(height: 20),
                    _listofdoctors(),
                    SizedBox(height: 20),

                  ]),
            )
          ],
        ),
      ),
    );
  }

  _headingcard() {
    return Stack(
      children: [
        SizedBox(
          width: Get.width,
          child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 80, 15, 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text("Get online\nBestCounselor\nat your",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.appbarbackgroundColor)),
                        SizedBox(height: 5),
                        Text("#Home",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: AppColors.appbarbackgroundColor)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Container(
                          height: 140,
                          width: 180,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                  AssetImage("assets/images/register.png"),
                                  fit: BoxFit.cover))),
                    ),
                  ],
                ),
              )),
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


  _listofdoctors() {
    return Container(
      width:Get.width,
      child: ListView.builder(
          itemCount: bestCounselorData.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, index) {
            return InkWell(
              onTap: ()async{
               // await SharedPrefManager.savePrefString(AppConstant.DOCTORID, bestCounselorData[index].doctorId);
                Get.to(CounsellingPage(),arguments: bestCounselorData[index].doctorId,
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 600));
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Container(

                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(children: [
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Card(
                                      color: AppColors.appbarbackgroundColor,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Image.network(bestCounselorData[index].profile),
                                    ),
                                  ),
                                  //    SizedBox(height: 10),
                                  SizedBox(
                                      height: 30,
                                      width: 100,
                                      child: Card(
                                          color: AppColors.blueColor,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: Center(
                                            child: Text("${bestCounselorData[index].rating.toInt()}/5",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.whitetextColor)),
                                          ))),
                                ]),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Dr. ${bestCounselorData[index].name}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.darktextColor)),
                                    SizedBox(height: 5),
                                    Text(bestCounselorData[index].speciality,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.lighttextColor)),
                                    SizedBox(height: 3),
                                    Text("${bestCounselorData[index].experiance} years experience",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.lighttextColor)),
                                    SizedBox(height: 3),
                                    RatingBar.builder(
                                      initialRating: bestCounselorData[index].rating,
                                      minRating: bestCounselorData[index].rating,
                                      maxRating: bestCounselorData[index].rating,
                                      itemCount: bestCounselorData[index].rating.toInt(),
                                      direction: _isVertical ? Axis.vertical : Axis.horizontal,
                                      allowHalfRating: true,
                                      unratedColor: Colors.amber.withAlpha(50),
                                      itemSize: 25.0,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                      ),
                                      onRatingUpdate: (rating) {
                                        // setState(() {
                                        //   _rating = rating;
                                        // });
                                      },
                                      updateOnDrag: false,
                                      tapOnlyMode: false,
                                    ),
                                    SizedBox(height: 3),
                                    Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        Text("1000+ consults done ",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppColors.darktextColor)),

                                      ],
                                    ),
                                  ],
                                ),  ]
                          )),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

}