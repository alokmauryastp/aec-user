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
import 'package:aec_medical/api/repository/courses_repo.dart';
import 'package:aec_medical/model/courseModel/mycoursesModel/course_counselling_model.dart';
import 'package:aec_medical/model/courseModel/mycoursesModel/mycourses_model.dart';
import 'package:aec_medical/model/courseModel/mycoursesModel/videos_model.dart';
import 'package:aec_medical/pages/dashboard/drawer/video_player_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({Key? key}) : super(key: key);

  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> with SingleTickerProviderStateMixin {
  bool isloading=false;
  late List<VideosData> videosData = [];

  late List<CourseCounselingData> courseCounselingData = [];
  var _index = 0;


  @override
  void initState() {
    setState(() {
      isloading=true;
    });
    CoursesRepo coursesRepo = new CoursesRepo();
    Future future = coursesRepo.videoApi();
    future.then((value){
      setState(() {
        videosData = value;
        isloading=false;
      });
    });
    Future future1 = coursesRepo.courseCounselingApi();
    future1.then((value){
      setState(() {
        courseCounselingData = value;
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
          title: Text("Videos & Counselling",
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
        child: Text("Videos & Counselling",  style: TextStyle(
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
                            ? Text("Videos",
                            style: TextStyle(
                              color: AppColors.darktextColor,
                              fontSize: 15,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                            ))
                            : Text("Videos",
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
                            ? Text("Counselling",
                            style: TextStyle(
                              color: AppColors.darktextColor,
                              fontSize: 15,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                            ))
                            : Text("Counselling",
                            style: TextStyle(
                              color: AppColors.lighttextColor,
                              fontSize: 15,
                              letterSpacing: 0.5,
                            ))),
                  ]),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.grey),
            if(videosData.isNull)
              Visibility(
                visible: _index == 0,
                child: Center(child: Container(
                    height: 250,
                    alignment: Alignment.center,
                    child: Text("Sorry! No Videos found."))),
              )
            else  if(videosData.isEmpty)
              Center(child: CircularProgressIndicator())
            else Visibility(
                  visible: _index == 0,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                          child:  ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: videosData.length,
                              itemBuilder: (BuildContext context, index) {
                                return InkWell(
                                  onTap: (){
                                    Get.to(VideoPlayerPage(),arguments: videosData[index],
                                        transition: Transition.rightToLeftWithFade,
                                        duration: Duration(milliseconds: 600));
                                  },
                                  child: Padding(
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
                                                SizedBox(
                                                  height: 100,
                                                  width: 100,
                                                  // child: Image.network(myCoursesData[index].image),
                                                  child: Card(
                                                    color: Colors.blue.shade50,
                                                    elevation: 5,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                    ),
                                                    child: Image.network(videosData[index].image,width: 100,height: 100,),
                                                  ),
                                                ),
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
                                                        Text(videosData[index].title,
                                                            style: TextStyle(
                                                                color: AppColors.appbarbackgroundColor,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold)),
                                                      ],
                                                    ),
                                                    SizedBox(height:5),
                                                    Row(
                                                      children: [
                                                        Text("Description: ",
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500)),
                                                        Text(videosData[index].description,
                                                            style: TextStyle(
                                                                color: Colors.black54,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500)),
                                                      ],
                                                    ),
                                                    SizedBox(height:5),
                                                    Row(
                                                      children: [
                                                        Text("Duration:",
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500)),
                                                        Text("${videosData[index].duration}",
                                                            style: TextStyle(
                                                                color: Colors.black54,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500)),
                                                      ],
                                                    ),
                                                    SizedBox(height:8)
                                                  ],
                                                ),


                                              ]),
                                        )
                                    ),
                                  ),
                                );
                              }),
                      )
                  )),
            if(courseCounselingData.isNull)
              Visibility(
                visible: _index == 1,
                child: Center(child: Container(
                    height: 250,
                    alignment: Alignment.center,
                    child: Text("Sorry! Counselling not available ."))),
              )
            else  if(courseCounselingData.isEmpty)
              Text("")
            else Visibility(
                  visible: _index == 1,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                          child:  ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: courseCounselingData.length,
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
                                                flex: 6,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0),
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
                                                          Text(courseCounselingData[index].title,
                                                              style: TextStyle(
                                                                  color: AppColors.appbarbackgroundColor,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.bold)),
                                                        ],
                                                      ),
                                                      //SizedBox(height:5),
                                                      Row(
                                                        children: [
                                                          Text("Description: ",
                                                              style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500)),

                                                          Container(
                                                              width: 120,
                                                              child: Html(data: courseCounselingData[index].description)),
                                                        ],
                                                      ),
                                                      // SizedBox(height:5),
                                                      Row(
                                                        children: [
                                                          Text("Start Time: ",
                                                              style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500)),
                                                          Text("${courseCounselingData[index].startTiming}",
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
                                                          Text("${courseCounselingData[index].startDate}",
                                                              style: TextStyle(
                                                                  color: Colors.black54,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500)),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5,),
                                                      Row(
                                                        children: [
                                                          Text("Duration: ",
                                                              style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500)),
                                                          Text("${courseCounselingData[index].duration} hrs",
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
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: SizedBox(
                                                  height: 50,
                                                  // width: 100,
                                                  // child: Image.network(myCoursesData[index].image),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      String  url = courseCounselingData[index].link.toString();
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
                      ))),
          ]),
        ));
  }
}