// import 'package:aec_medical/api/repository/courses_repo.dart';
// import 'package:aec_medical/model/courseModel/mycoursesModel/mycourses_model.dart';
// import 'package:aec_medical/utils/colors.dart';
// import 'package:aec_medical/utils/strings.dart';
// import 'package:aec_medical/utils/strings_style.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class MyCoursesPage extends StatefulWidget {
//   const MyCoursesPage({Key? key}) : super(key: key);
//
//   @override
//   _MyCoursesPageState createState() => _MyCoursesPageState();
// }
//
// class _MyCoursesPageState extends State<MyCoursesPage>
//   with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   late List<MyCoursesData> myCoursesData = [];
//
//   @override
//   void initState() {
//   _tabController = TabController(length: 3, vsync: this);
//   CoursesRepo coursesRepo = new CoursesRepo();
//   Future future1 = coursesRepo.mycoursesApi();
//   future1.then((value){
//     setState(() {
//       myCoursesData = value;
//       print("ssssymptoms"+myCoursesData[0].title);
//     });
//   });
//   super.initState();
//   }
//
//   @override
//   void dispose() {
//   super.dispose();
//   _tabController.dispose();
//   }
//   var CategoryName = [
//     "For Relationship",
//     "Kids related issues",
//     "Pregnency",
//     "Psychological",
//     "Motivational",
//     "Loneliness",
//     "Suicidal Thoughts",
//     "Feeligs of anger",
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.backgroundColor,
//         appBar: AppBar(
//           backgroundColor: AppColors.appbarbackgroundColor,
//           centerTitle: true,
//           title: Text(
//             Strings.MYCOURSEPAGE,
//             style: StringsStyle.pagetitlestyle,
//           ),
//           leading: IconButton(
//               onPressed: () {
//                 Get.back();
//               },
//               icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
//         ),
//         body: SafeArea(
//           child: Padding(
//           padding: const EdgeInsets.only(top: 50),
//           child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//           if(myCoursesData.isEmpty)
//             Center(child: CircularProgressIndicator())
//             else Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: Text("My Courses",
//             style: TextStyle(
//             color: Color(0XFF005B5C),
//             fontSize: 25,
//             fontWeight: FontWeight.bold
//             ),),
//           ),
//           SizedBox(height: 20,),
//           Container(
//             padding: EdgeInsets.only(right: 30),
//           child: TabBar(
//             indicatorWeight: 3,
//             indicatorColor: Color(0XFF005B5C),
//           indicatorSize: TabBarIndicatorSize.label,
//           controller: _tabController,
//           labelColor: Color(0XFF005B5C),
//           unselectedLabelColor: Colors.grey,
//           tabs: [
//           Tab(
//           text: 'All',
//           ),
//           Tab(
//           text: 'Ongoing',
//           ),
//           Tab(
//           text: 'Completed',
//           ),
//           ],
//           ),
//           ),
//           // tab bar view here
//           Expanded(
//           child: TabBarView(
//           controller: _tabController,
//           children: [
//           // first tab bar view widget
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: SingleChildScrollView(
//                 child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 5.0,
//                       mainAxisSpacing: 5.0,
//                       childAspectRatio: 1,
//                     ),
//                     itemCount: myCoursesData.length,
//                     itemBuilder: (BuildContext context, index) {
//                       return Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         color: Colors.white,
//                         elevation: 5,
//                         child: InkWell(
//                           splashColor: AppColors.appbarbackgroundColor,
//                           onTap: () {
//                             // Get.to(CounsellingDetailPage(),
//                             //     transition: Transition.rightToLeftWithFade,
//                             //     duration: Duration(milliseconds: 600));
//                           },
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Container(
//                                   height: 60, width: 60,
//                                   child: Image.network(myCoursesData[index].image),
//                                 ),
//                                 SizedBox(height: 5),
//                                 Text(myCoursesData[index].name,
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(fontSize: 12))
//                               ]),
//                         ),
//                       );
//                     }),
//               ),
//             ),
//
//           // second tab bar view widget
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: SingleChildScrollView(
//                 child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: CategoryName.length,
//                     itemBuilder: (BuildContext context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           color: Colors.white,
//                           elevation: 5,
//                           child: Row(
//                             children: [
//                               Container(
//                                 height: 60, width: 60,
//                                 child: Image.asset("assets/images/step1.png"),
//                               ),
//                               SizedBox(width: 10,),
//                               Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                      Column(
//                                        crossAxisAlignment: CrossAxisAlignment.start,
//                                        children: [
//                                          Padding(
//                                            padding: const EdgeInsets.symmetric(vertical: 15),
//                                            child: Text("Course Name",
//                                                style: TextStyle(
//                                                    color: AppColors.appbarbackgroundColor,
//                                                    fontSize: 17,
//                                                    fontWeight: FontWeight.bold)),
//                                          ),
//                                          Text("Duration: 3 months",
//                                              style: TextStyle(
//                                                  color: Colors.grey,
//                                                  fontSize: 15,
//                                                  fontWeight: FontWeight.bold)),
//                                          SizedBox(height: 20,),
//                                        ],
//                                      ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.end,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(top: 0),
//                                             child: Text("From 01/jun/2021",
//                                                 style: TextStyle(
//                                                     color: Colors.grey,
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.bold)),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(top: 10),
//                                             child: Text("To 01/Aug/2021",
//                                                 style: TextStyle(
//                                                     color: Colors.grey,
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.bold)),
//                                           ),
//                                           SizedBox(height: 20,),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                  Padding(
//                                    padding: const EdgeInsets.only(bottom: 20),
//                                    child: Card(
//                                      shape: RoundedRectangleBorder(
//                                        borderRadius: BorderRadius.circular(10.0),
//                                      ),
//                                      color: Color(0XFF005B5C),
//                                      elevation: 5,
//                                      child: Container(
//                                        height: 15,
//                                        width: 240,
//                                      ),
//                                    ),
//                                  )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: SingleChildScrollView(
//                 child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: CategoryName.length,
//                     itemBuilder: (BuildContext context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           color: Colors.white,
//                           elevation: 5,
//                           child: Row(
//                             children: [
//                               Container(
//                                 height: 60, width: 60,
//                                 child: Image.asset("assets/images/step1.png"),
//                               ),
//                               SizedBox(width: 10,),
//                               Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(vertical: 15),
//                                             child: Text("Course Name",
//                                                 style: TextStyle(
//                                                     color: AppColors.appbarbackgroundColor,
//                                                     fontSize: 17,
//                                                     fontWeight: FontWeight.bold)),
//                                           ),
//                                           Text("Duration: 3 months",
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.bold)),
//                                           SizedBox(height: 20,),
//                                         ],
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.end,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(top: 0),
//                                             child: Text("From 01/jun/2021",
//                                                 style: TextStyle(
//                                                     color: Colors.grey,
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.bold)),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(top: 10),
//                                             child: Text("To 01/Aug/2021",
//                                                 style: TextStyle(
//                                                     color: Colors.grey,
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.bold)),
//                                           ),
//                                           SizedBox(height: 20,),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(bottom: 20),
//                                     child: Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10.0),
//                                       ),
//                                       color: Color(0XFF005B5C),
//                                       elevation: 5,
//                                       child: Container(
//                                         height: 15,
//                                         width: 240,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//               ),
//             ),
//           ],
//           ),
//           ),
//           ],
//           ),
//           ),
//         ),
//           );
//   }
// }
import 'package:aec_medical/api/repository/counselling_repo.dart';
import 'package:aec_medical/api/repository/courses_repo.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/courseModel/mycoursesModel/course_counselling_model.dart';
import 'package:aec_medical/model/courseModel/mycoursesModel/mycourses_model.dart';
import 'package:aec_medical/model/courseModel/mycoursesModel/videos_model.dart';
import 'package:aec_medical/model/homeModel/Counselling/newCounselling_model.dart';
import 'package:aec_medical/model/homeModel/Counselling/oldCounselling_model.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/couselling_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/video_player_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:aec_medical/utils/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class AllBookCounsellingPage extends StatefulWidget {
  const AllBookCounsellingPage({Key? key}) : super(key: key);

  @override
  _AllBookCounsellingPageState createState() => _AllBookCounsellingPageState();
}

class _AllBookCounsellingPageState extends State<AllBookCounsellingPage> with SingleTickerProviderStateMixin {
  bool isloading=false;
  late List<NewCounselingData> newCounselingData = [];

  late List<OldCounselingData> oldCounselingData = [];
  var _index = 0;


  @override
  void initState() {
    setState(() {
      isloading=true;
    });
    CounsellingRepo counsellingRepo = new CounsellingRepo();
    Future future = counsellingRepo.newCounselingApi();
    future.then((value){
      setState(() {
        newCounselingData = value;
        isloading=false;
      });
    });
    Future future1 = counsellingRepo.oldCounselingApi();
    future1.then((value){
      setState(() {
        oldCounselingData = value;
        isloading=false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          centerTitle: true,
          title: Text("My Counselling",
            style: StringsStyle.pagetitlestyle,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
        ),
        body:SingleChildScrollView(
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
                        SizedBox(height: 20),
                        // _searchbox(),
                      ]),
                ),
              ),
              SizedBox(height: 2),
              _listview(),
              SizedBox(height: 30),
            ],
          ),
        ));
  }

  _heading() {
    return Container(
        width: Get.width,
        child: Text("New & Old Counselling",  style: TextStyle(
            color: AppColors.appbarbackgroundColor,
            fontSize: 20,
            letterSpacing: 0.5,
            fontWeight: FontWeight.bold)));
  }


  _listview() {
    return Container(
        color: AppColors.whitetextColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        splashColor: AppColors.appbarbackgroundColor,
                        onTap: () {
                          setState(() {
                            _index = 0;
                          });
                        },
                        child: _index == 0
                            ? Text("New Counselling",
                            style: TextStyle(
                              color: AppColors.darktextColor,
                              fontSize: 15,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                            ))
                            : Text("New Counselling",
                            style: TextStyle(
                              color: AppColors.lighttextColor,
                              fontSize: 15,
                              letterSpacing: 0.5,
                            ))),
                    InkWell(
                        splashColor: AppColors.appbarbackgroundColor,
                        onTap: () {
                          setState(() {
                            _index = 1;
                          });
                        },
                        child: _index == 1
                            ? Text("Old Counselling",
                            style: TextStyle(
                              color: AppColors.darktextColor,
                              fontSize: 15,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                            ))
                            : Text("Old Counselling",
                            style: TextStyle(
                              color: AppColors.lighttextColor,
                              fontSize: 15,
                              letterSpacing: 0.5,
                            ))),
                  ]),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.grey),
            if(newCounselingData.isNull)
              Visibility(
                visible: _index == 0,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/notcounselling.jpg",width: Get.width,),
                      Text("Sorry! New Counselling not available.",style: TextStyle(fontSize: 20,
                          color: AppColors.appbarbackgroundColor,
                          fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(CounsellingPage(),
                                transition: Transition.rightToLeftWithFade,
                                duration: Duration(milliseconds: 600));
                          },
                          child: CustomButton(
                              text1: "", text2: "Buy Counselling", width: Get.width, height: 50),
                        ),
                      ),
                    ],
                  ),
                )
              )
            else  if(newCounselingData.isEmpty)
              Center(child: CircularProgressIndicator())
            else Visibility(
                  visible: _index == 0,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        child:  ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: newCounselingData.length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    color: Colors.white,
                                    elevation: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height:5),
                                                  Row(
                                                    children: [
                                                      Text("Title: ",
                                                          style: TextStyle(
                                                              color: AppColors.appbarbackgroundColor,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.bold)),
                                                      Text(newCounselingData[index].title,
                                                          style: TextStyle(
                                                              color: AppColors.appbarbackgroundColor,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.bold)),
                                                    ],
                                                  ),
                                                  SizedBox(height:5),
                                                  Text("Description: ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold)),
                                                  SizedBox(height:5),
                                                  SizedBox(
                                                      width: Get.width/1.5,
                                                      child: Html(data: newCounselingData[index].description)),
                                                  SizedBox(height:5),
                                                  Row(
                                                    children: [
                                                      Text("Start Time: ",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500)),
                                                      Text("${newCounselingData[index].startTiming}",
                                                          style: TextStyle(
                                                              color: Colors.black54,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Row(
                                                    children: [
                                                      Text("Start Date: ",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500)),
                                                      Text("${newCounselingData[index].startDate}",
                                                          style: TextStyle(
                                                              color: Colors.black54,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Row(
                                                    children: [
                                                      Text("Duration: ",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500)),
                                                      Text("${newCounselingData[index].duration} hrs",
                                                          style: TextStyle(
                                                              color: Colors.black54,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  SizedBox(height:8),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: SizedBox(
                                                height: 50,
                                                // width: 100,
                                                // child: Image.network(myCoursesData[index].image),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    String  url = newCounselingData[index].link.toString();
                                                    if (await canLaunch(url)) {
                                                      await launch(url, forceWebView: true,enableJavaScript: true);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                    //Get.to(VideoPlayerPage(),arguments: newCounselingData[index].video);
                                                  },
                                                  child: Card(
                                                    color: Colors.blue,
                                                    elevation: 5,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20.0),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text("Video Call",style: TextStyle(fontSize: 10,
                                                              fontWeight: FontWeight.w600,color: Colors.white),),
                                                          Icon(Icons.video_call,color: Colors.white,size: 15,),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ]),
                                    )
                                ),
                              );
                            }),
                      )
                  )),
            if(oldCounselingData.isNull)
              Visibility(
                visible: _index == 1,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/notcounselling.jpg",width: Get.width,),
                      Text("Sorry! Old Counselling not available.",style: TextStyle(fontSize: 20,
                          color: AppColors.appbarbackgroundColor,
                          fontWeight: FontWeight.bold),),
                    ],
                  ),
                )
              )
            else  if(oldCounselingData.isEmpty)
              Text("")
            else Visibility(
                  visible: _index == 1,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        child:  ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: oldCounselingData.length,
                            itemBuilder: (BuildContext context, index) {
                              return InkWell(
                                onTap: (){
                                  //  Get.to(VideoPlayerPage(),arguments: courseCounselingData[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      color: Colors.white,
                                      elevation: 20,
                                      child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(
                                            //   height: 100,
                                            //   width: 100,
                                            //   // child: Image.network(myCoursesData[index].image),
                                            //   child: Card(
                                            //     color: Colors.blue.shade50,
                                            //     elevation: 5,
                                            //     shape: RoundedRectangleBorder(
                                            //       borderRadius: BorderRadius.circular(5.0),
                                            //     ),
                                            //     child: Image.asset("assets/images/step1.png"),),
                                            // ),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height:5),
                                                Row(
                                                  children: [
                                                    Text("Title: ",
                                                        style: TextStyle(
                                                            color: AppColors.appbarbackgroundColor,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold)),

                                                    Text(oldCounselingData[index].title,
                                                        style: TextStyle(
                                                            color: AppColors.appbarbackgroundColor,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold)),
                                                  ],
                                                ),
                                                SizedBox(height:5),

                                                Text("Description: ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold)),
                                                SizedBox(height:5),
                                                SizedBox(
                                                    width: Get.width/1.5,
                                                    child: Html(data: oldCounselingData[index].description)),

                                                SizedBox(height:5),
                                                Row(
                                                  children: [
                                                    Text("Duration: ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500)),
                                                    Text("${oldCounselingData[index].duration} hrs",
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500)),
                                                  ],
                                                ),
                                                SizedBox(height:8)
                                              ],
                                            ),


                                          ])
                                  ),
                                ),
                              );
                            }),
                      ))),
          ]),
        ));
  }
}