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
import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/courses_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/courseModel/mycoursesModel/mycourses_model.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/courses/courses_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/videolist_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({Key? key}) : super(key: key);

  @override
  _MyCoursesPageState createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isloading=false;
  late List<MyCoursesData> myCoursesData = [];

  @override
  void initState() {
    setState(() {
      isloading=true;
    });
    _tabController = TabController(length: 3, vsync: this);
    CoursesRepo coursesRepo = new CoursesRepo();
    Future future = coursesRepo.mycoursesApi();
    future.then((value){
      setState(() {
        myCoursesData = value;
        isloading=false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  var CategoryName = [
    "For Relationship",
    "Kids related issues",
    "Pregnency",
    "Psychological",
    "Motivational",
    "Loneliness",
    "Suicidal Thoughts",
    "Feeligs of anger",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          centerTitle: true,
          title: Text(
            Strings.MYCOURSEPAGE,
            style: StringsStyle.pagetitlestyle,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
        ),
        body:myCoursesData.isNull?Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/notcourse.jpg",width: Get.width,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text("O’ Oh ! You haven't purchased any course yet",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20,
                    color: AppColors.appbarbackgroundColor,
                    fontWeight: FontWeight.bold),),
              ),
              // SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: InkWell(
                onTap: () {
                  Get.to(CoursesPage(),
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 600));
                },
                child: CustomButton(
                    text1: "", text2: "Buy Course", width: Get.width, height: 50),
              ),
            ),
              // SizedBox(height: 30,),

            ],
          ),
        )
       : myCoursesData.isEmpty?Center(child: CircularProgressIndicator()):SafeArea(child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("My Courses",
                        style: TextStyle(
                        color: AppColors.appbarbackgroundColor,
                        fontSize: 20,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 10,),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: myCoursesData.length,
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: ()async{
                            await SharedPrefManager.savePrefString(AppConstant.BUYID, myCoursesData[index].buyId);
                            Get.to(VideoListPage(),
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
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                      children: [

                                        SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(myCoursesData[index].image),
                                          // child: Card(
                                          //   color: Colors.blue.shade50,
                                          //   elevation: 5,
                                          //   shape: RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.circular(5.0),
                                          //   ),
                                          //   child: Image.network(myCoursesData[index].image),
                                          // ),
                                        ),
                                        SizedBox(width: 10,),

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height:5),
                                            Text(myCoursesData[index].name,
                                                style: TextStyle(
                                                    color: AppColors.appbarbackgroundColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(height:5),
                                            Row(
                                              children: [
                                                Text("Duration:",
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500)),
                                                Text("${myCoursesData[index].duration} "  "${myCoursesData[index].durationType}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500)),
                                              ],
                                            ),
                                            SizedBox(height: 7,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 0),
                                                  child: Text(myCoursesData[index].buyDate,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10,),
                                                  child: Text(myCoursesData[index].validTill,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500)),
                                                ),

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
                ],
              ),

            )))  );
  }
}