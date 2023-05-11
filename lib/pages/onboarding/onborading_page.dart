//
//
// import 'package:aec_medical/pages/authentication/signin_page.dart';
// import 'package:aec_medical/pages/onboarding/onboarding_content_page.dart';
// import 'package:aec_medical/utils/colors.dart';
// import 'package:aec_medical/utils/strings.dart';
// import 'package:aec_medical/utils/strings_style.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// class IntroScreen extends StatefulWidget {
//   @override
//   _IntroScreenState createState() => _IntroScreenState();
// }
//
// class _IntroScreenState extends State<IntroScreen> {
//
//   List<SliderModel> mySLides = <SliderModel>[];
//   int slideIndex = 0;
//   late PageController controller;
//
//   Widget _buildPageIndicator(bool isCurrentPage){
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 2.0),
//       height: isCurrentPage ? 10.0 : 6.0,
//       width: isCurrentPage ? 10.0 : 6.0,
//       decoration: BoxDecoration(
//         color: isCurrentPage ? Colors.grey : Colors.grey[300],
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     mySLides = getSlides();
//     controller = new PageController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF0E4D6),
//       body: Container(
//         child: PageView(
//           controller: controller,
//           onPageChanged: (index) {
//             setState(() {
//               slideIndex = index;
//             });
//           },
//           children: <Widget>[
//             SlideTile(
//               icon: mySLides[0].getIcon(),
//               imagePath: mySLides[0].getImageAssetPath(),
//               title: mySLides[0].getTitle(),
//               desc: mySLides[0].getDesc(),
//             ),
//             SlideTile(
//               icon: mySLides[1].getIcon(),
//               imagePath: mySLides[1].getImageAssetPath(),
//               title: mySLides[1].getTitle(),
//               desc: mySLides[1].getDesc(),
//             ),
//             SlideTile(
//               icon: mySLides[2].getIcon(),
//               imagePath: mySLides[2].getImageAssetPath(),
//               title: mySLides[2].getTitle(),
//               desc: mySLides[2].getDesc(),
//             )
//           ],
//         ),
//       ),
//       bottomSheet: slideIndex != 2 ? Container(
//         color: Color(0xFFF0E4D6),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             FlatButton(
//               onPressed: (){
//                 Get.offAll(SignInPage());
//                 //controller.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.linear);
//               },
//               splashColor: Colors.blue[50],
//               child: Text(
//                 "Skip",
//                 style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
//               ),
//             ),
//             Container(
//               child: Row(
//                 children: [
//                   for (int i = 0; i < 3 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
//                 ],),
//             ),
//             FlatButton(
//               onPressed: (){
//                 print("this is slideIndex: $slideIndex");
//                 controller.animateToPage(slideIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
//               },
//               splashColor: Colors.blue[50],
//               child: Text(
//                 "Next",
//                 style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ),
//       ): Container(
//         color: Color(0xFFF0E4D6),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             FlatButton(
//               onPressed: (){
//                 Get.offAll(SignInPage());
//                // controller.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.linear);
//               },
//               splashColor: Colors.blue[50],
//               child: Text(
//                 "Skip",
//                 style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
//               ),
//             ),
//             Container(
//               child: Row(
//                 children: [
//                   for (int i = 0; i < 3 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
//                 ],),
//             ),
//             FlatButton(
//               onPressed: (){
//                 Get.off(SignInPage());
//               },
//               splashColor: Colors.blue[50],
//               child: Text(
//                 "Done",
//                 style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class SlideTile extends StatelessWidget {
//   String icon,imagePath, title, desc;
//
//   SlideTile({required this.icon,required this.imagePath, required this.title, required this.desc});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 25),
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Column(
//             children: [
//               Image.asset("assets/images/logo.png",
//                 height: 150,
//                 width: 150,),
//
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 Strings.LOGO_TITLE,
//                 style: StringsStyle.redlogotitlestyle,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 height: 2.5,
//                 color: Colors.grey,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(title, textAlign: TextAlign.center,style: TextStyle(
//                   color: AppColors.appbarbackgroundColor,
//                   fontSize: 20,
//                   letterSpacing: 0.5,
//                   fontWeight: FontWeight.bold)),
//               Text(desc, textAlign: TextAlign.center,style: TextStyle(
//                   color: AppColors.appbarbackgroundColor,
//                   fontSize: 20,
//                   letterSpacing: 0.5,
//                   fontWeight: FontWeight.bold)),
//
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 height: 2.5,
//                 color: Colors.grey,
//               ),
//             ],
//           ),
//
//           Image.asset(imagePath),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:aec_medical/pages/authentication/signin_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'onboarding_content/pageone.dart';
import 'onboarding_content/pagethree.dart';
import 'onboarding_content/pagetwo.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  List Tab = [PageOne(), PageTwo(), PageThree()];

  int index = 0;

  void changeTab() {
    Timer(Duration(seconds: 2), () {
      if (index < 2) {
        setState(() {
          index++;
        });
        changeTab();
      } else {
        setState(() {
          index = 0;
        });
        changeTab();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    changeTab();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Tab[index],
      bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          child: Container(
              color: AppColors.backgroundColor,
              height: 70,
              width: MediaQuery.of(context).size.width / 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: index == 0
                            ? () {
                                print("navigate to next screen ");
                                Get.to(SignInPage());
                              }
                            : () {
                                setState(() {
                                  index--;
                                });
                              },
                        child: Text(index == 0 ? "Skip" : "Back",style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily),)),
                    Container(
                        width: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Tab.length,
                          itemBuilder: (BuildContext context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  color:
                                      i == index ? Colors.blue : Colors.black,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          },
                        )),
                    //   Text(index.toString()),
                    InkWell(
                        onTap: index < Tab.length - 1
                            ? () {
                                Get.to(SignInPage());
                                setState(() {
                                  index++;
                                });
                              }
                            : () {
                                print("next screen");
                              },
                        child: Text(index < Tab.length - 1 ? "Next" : "Done",style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily),))
                  ],
                ),
              ))),
    );
  }
}
