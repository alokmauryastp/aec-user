import 'package:aec_medical/api/repository/counselling_repo.dart';
import 'package:aec_medical/api/repository/courses_repo.dart';
import 'package:aec_medical/api/repository/home_repo.dart';
import 'package:aec_medical/model/courseModel/courses_model.dart';
import 'package:aec_medical/model/homeModel/Counselling/blog_model.dart';
import 'package:aec_medical/model/homeModel/Counselling/allCounseleing_model.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/counselling_detail_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/healthquestions_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/totalhealthscore_result_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../health_blogs_tips_page.dart';
import '../health_description_page.dart';
import '../totalhealthquestion_page.dart';
import 'courses_details_page.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {


  late List<BlogData> blogData = [];

  late List<CoursesData> coursesData = [];




  @override
  void initState() {
    super.initState();
    HomeRepo homeRepo = new HomeRepo();
    Future future = homeRepo.blogApi();
    future.then((value) {
      setState(() {
        blogData = value;
        print("kktitle" + blogData[0].title.toString());
      });
    });

    CoursesRepo coursesRepo = new CoursesRepo();
    Future future1 = coursesRepo.coursesApi();
    future1.then((value){
      setState(() {
        coursesData = value;
        print("ssssymptoms"+coursesData[0].title);
      });
    });

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
          title: Text(Strings.COURSESTITLE,
            style: StringsStyle.pagetitlestyle,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
        ),
        body:  blogData.isEmpty?
        Center(child: CircularProgressIndicator())
            : SafeArea(
            child: coursesData.isNull?  Center(child: Text("Sorry! Courses not available."))
                : coursesData.isEmpty?
            Center(child: Text(""))
                : SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _caroselslider(),
                      _counsellingcategory(),
                      SizedBox(height: 10),
                      _healthblog(),
                    ]))));
  }

  _caroselslider() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CarouselSlider(
        items: [
          //1st Image of Slider
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: AppColors.redColor),
              color: AppColors.whitetextColor,
            ),
            child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          onTap: (){
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
                                  Colors.black26,
                                  Colors.black87,
                                ]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 40,
                              width: 90,
                              child: Center(
                                child: Center(
                                  child: Text("Check Now",
                                      style: TextStyle(
                                        color: AppColors.whitetextColor,
                                        fontSize: 12,
                                        letterSpacing: 0.3,
                                      )),
                                ),
                              )),
                        )
                      ],
                    ),
                    Text("\"Track your Health\nStatus with Total\nHealth Score.\"",
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            color: AppColors.appbarbackgroundColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold))
                  ],
                )),
          ),

          //2nd Image of Slider
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: AppColors.redColor),
              color: AppColors.whitetextColor,
            ),
            child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          onTap: (){
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
                                  Colors.black26,
                                  Colors.black87,
                                ]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 40,
                              width: 90,
                              child: Center(
                                child: Center(
                                  child: Text("Check Now",
                                      style: TextStyle(
                                        color: AppColors.whitetextColor,
                                        fontSize: 12,
                                        letterSpacing: 0.3,
                                      )),
                                ),
                              )),
                        )
                      ],
                    ),
                    Text("\"Track your Health\nStatus with Total\nHealth Score.\"",
                        style: TextStyle(
                            color: AppColors.appbarbackgroundColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold))
                  ],
                )),
          ),
          //3rd Image of Slider
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: AppColors.redColor),
              color: AppColors.whitetextColor,
            ),
            child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          onTap: (){
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
                                  Colors.black26,
                                  Colors.black87,
                                ]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 40,
                              width: 90,
                              child: Center(
                                child: Center(
                                  child: Text("Check Now",
                                      style: TextStyle(
                                        color: AppColors.whitetextColor,
                                        fontSize: 12,
                                        letterSpacing: 0.3,
                                      )),
                                ),
                              )),
                        )
                      ],
                    ),
                    Text("\"Track your Health\nStatus with Total\nHealth Score.\"",
                        style: TextStyle(
                            color: AppColors.appbarbackgroundColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold))
                  ],
                )),
          ),
        ],

        //Slider Container properties
        options: CarouselOptions(
          height: 200,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
      ),
    );
  }

  _counsellingcategory() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.COURSESFOR,
            style: StringsStyle.counsellingforstyle,
          ),
          SizedBox(height: 15),
          if(coursesData.isEmpty)
            Center(child: CircularProgressIndicator())
          else GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                childAspectRatio: 1,
              ),
              itemCount: coursesData.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    splashColor: AppColors.appbarbackgroundColor,
                    onTap: () {
                      Get.to(CoursesDetailPage(),arguments: coursesData[index],
                          transition: Transition.rightToLeftWithFade,
                          duration: Duration(milliseconds: 600));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 60, width: 60,
                              child: Image.network(coursesData[index].image),
                            ),
                            SizedBox(height: 5),
                            Text(coursesData[index].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12))
                          ]),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }


  _healthblog() {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.HEALTHBLOG,
                  style: StringsStyle.counsellingforstyle,
                ),
                InkWell(
                  splashColor: AppColors.appbarbackgroundColor,
                  onTap: () {
                    Get.to(HealthBlogsTipsPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                  child: Text(
                    Strings.ViewAll,
                    style: TextStyle(color: Colors.black,fontSize: 13),
                  ),
                ),

              ],
            ),
            SizedBox(height: 15),

              Container(
                height: Get.height / 3.4,
                width: Get.width / 1,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    primary: true,
                    itemCount: blogData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(0),
                        child: InkWell(
                          onTap: (){
                            Get.to(HealthBlogAndTipsDescriptionPage(),arguments: blogData[index].blogId.toString());
                          },
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          //  SizedBox(height: 5, width: 5),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                                height: 100,
                                                width: Get.width/1.9,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            blogData[index]
                                                                .image),
                                                        fit: BoxFit.cover))),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        width: Get.width / 1.9,
                                        alignment: Alignment.centerLeft,
                                        child: Text(blogData[index].title,
                                            overflow:
                                            TextOverflow
                                                .ellipsis,
                                            softWrap: false,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        width: Get.width/1.9,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(

                                              child:Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                      const EdgeInsets.all(0.0),
                                                      child: Container(
                                                          child: Row(children: [
                                                            CircleAvatar(
                                                              radius: 20,
                                                              backgroundColor: AppColors.appbarbackgroundColor,
                                                              child:  Image.asset("assets/images/logo.png",
                                                                height: 30,
                                                                width: 30,
                                                              ),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Container(

                                                                    width:50,
                                                                    child: Text(
                                                                        blogData[index]
                                                                            .author,
                                                                        overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                        softWrap: false,
                                                                        maxLines: 1,
                                                                        style: TextStyle(
                                                                            color: AppColors
                                                                                .blueColor,
                                                                            fontSize: 12,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w500)),
                                                                  ),
                                                                  //  SizedBox(height: 3),
                                                                  // Container(
                                                                  //   width: 160,
                                                                  // child: Text(
                                                                  //     blogData[index]
                                                                  //         .shortDescription,
                                                                  // overflow:
                                                                  //     TextOverflow
                                                                  //         .ellipsis,
                                                                  // softWrap: false,
                                                                  //     style: TextStyle(
                                                                  //         color: AppColors
                                                                  //             .appbarbackgroundColor,
                                                                  //         fontSize:
                                                                  //             12,
                                                                  //         fontWeight:
                                                                  //             FontWeight
                                                                  //                 .w500)),
                                                                  // ),




                                                                ])
                                                          ]))),
                                                ],
                                              ),
                                            ),
                                            Text(
                                                blogData[index]
                                                    .timeAgo,
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    color: Colors.black54
                                                    ,
                                                    fontSize:
                                                    12,
                                                    fontWeight:
                                                    FontWeight
                                                        .w500)),


                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // Visibility(
                              //   visible:isExpand,
                              //     child: Text("jiascasukdnasu cdasdjaks caskjc sakj c"))
                            ],
                          ),
                        ),

                      );

                      //  Padding(
                      //   padding: const EdgeInsets.only(right: 10),
                      //   child:

                      //   Container(
                      //     height: Get.height / 2,
                      //     width: Get.width / 1.3,
                      //     decoration: BoxDecoration(
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.grey.withOpacity(0.4),
                      //           spreadRadius: 1,
                      //           blurRadius: 3,
                      //           offset: Offset(0, 3),
                      //         ),
                      //       ],
                      //       color: AppColors.whitetextColor,
                      //     ),
                      //     child: Column(children: [
                      //       Expanded(
                      //         child: Container(
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image: NetworkImage(blogData[index].image),
                      //         fit: BoxFit.cover))),
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.all(10.0),
                      //         child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               SizedBox(height: 5),
                      //               Text(blogData[index].title,
                      //                   style: TextStyle(
                      //                       color:
                      //                           AppColors.appbarbackgroundColor,
                      //                       fontSize: 16,
                      //                       fontWeight: FontWeight.bold)),
                      //               SizedBox(height: 8),
                      //               Text(
                      //                   "Huber and colleagues suggest that the problem with the WHO definition is the absoluteness of ‘complete’ wellbeing. This, they suggest, inadvertently contributes to the ‘over-medicalisation’ of the population. It allows a platform for industry, medical technologies and professionals to redefine our health status. ",
                      //                   style: TextStyle(
                      //                     fontSize: 12,
                      //                     color: AppColors.appbarbackgroundColor,
                      //                   )),
                      //             ]),
                      //       ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Container(
                      //       child: Row(children: [
                      //     CircleAvatar(),
                      //     SizedBox(width: 10),
                      //     Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(blogData[index].author,
                      //               style: TextStyle(
                      //                   color: AppColors.blueColor,
                      //                   fontSize: 12,
                      //                   fontWeight: FontWeight.w500)),
                      //           SizedBox(height: 3),
                      //           Container(
                      //             width: 160,
                      //             child: Text(blogData[index].shortDescription,
                      //                 overflow: TextOverflow.ellipsis,
                      //                 softWrap: false,
                      //                 style: TextStyle(
                      //                     color:
                      //                         AppColors.appbarbackgroundColor,
                      //                     fontSize: 12,
                      //                     fontWeight: FontWeight.w500)),
                      //           ),
                      //         ])
                      //   ])),
                      //       )
                      //     ]),
                      //   ),

                      // );
                    }),
              ),
          ],
        ));
  }

  // _healthblog() {
  //   return Padding(
  //       padding: const EdgeInsets.all(15.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             Strings.HEALTHBLOG,
  //             style: StringsStyle.counsellingforstyle,
  //           ),
  //           SizedBox(height: 15),
  //           if(blogData.isEmpty)
  //             Center(child: CircularProgressIndicator())
  //           else Container(
  //             height: Get.height / 2,
  //             width: Get.width / 1,
  //             child: ListView.builder(
  //                 scrollDirection: Axis.horizontal,
  //                 primary: true,
  //                 itemCount: blogData.length,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   return Padding(
  //                     padding: const EdgeInsets.only(right: 10),
  //                     child: Container(
  //                       height: Get.height / 2,
  //                       width: Get.width / 1.3,
  //                       decoration: BoxDecoration(
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Colors.grey.withOpacity(0.4),
  //                             spreadRadius: 1,
  //                             blurRadius: 3,
  //                             offset: Offset(0, 3),
  //                           ),
  //                         ],
  //                         color: AppColors.whitetextColor,
  //                       ),
  //                       child: Column(children: [
  //                         Expanded(
  //                           child: Container(
  //                               decoration: BoxDecoration(
  //                                   image: DecorationImage(
  //                                       image: NetworkImage(blogData[index].image),
  //                                       fit: BoxFit.cover))),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(10.0),
  //                           child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 SizedBox(height: 5),
  //                                 Text(blogData[index].title,
  //                                     style: TextStyle(
  //                                         color:
  //                                         AppColors.appbarbackgroundColor,
  //                                         fontSize: 16,
  //                                         fontWeight: FontWeight.bold)),
  //                                 SizedBox(height: 8),
  //                                 Text(
  //                                     "Huber and colleagues suggest that the problem with the WHO definition is the absoluteness of ‘complete’ wellbeing. This, they suggest, inadvertently contributes to the ‘over-medicalisation’ of the population. It allows a platform for industry, medical technologies and professionals to redefine our health status. ",
  //                                     style: TextStyle(
  //                                       fontSize: 12,
  //                                       color: AppColors.appbarbackgroundColor,
  //                                     )),
  //                               ]),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(10.0),
  //                           child: Container(
  //                               child: Row(children: [
  //                                 CircleAvatar(),
  //                                 SizedBox(width: 10),
  //                                 Column(
  //                                     crossAxisAlignment: CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text(blogData[index].author,
  //                                           style: TextStyle(
  //                                               color: AppColors.blueColor,
  //                                               fontSize: 12,
  //                                               fontWeight: FontWeight.w500)),
  //                                       SizedBox(height: 3),
  //                                       Container(
  //                                         width: 160,
  //                                         child: Text(blogData[index].shortDescription,
  //                                             overflow: TextOverflow.ellipsis,
  //                                             softWrap: false,
  //                                             style: TextStyle(
  //                                                 color:
  //                                                 AppColors.appbarbackgroundColor,
  //                                                 fontSize: 12,
  //                                                 fontWeight: FontWeight.w500)),
  //                                       ),
  //                                     ])
  //                               ])),
  //                         )
  //                       ]),
  //                     ),
  //                   );
  //                 }),
  //           ),
  //         ],
  //       ));
  // }
}
