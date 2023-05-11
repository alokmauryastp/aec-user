import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/courses_repo.dart';
import 'package:aec_medical/api/repository/home_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/courseModel/buycourse_model.dart';
import 'package:aec_medical/model/courseModel/courses_model.dart';
import 'package:aec_medical/model/homeModel/Counselling/blog_model.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/healthquestions_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/register_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/totalhealthquestion_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../health_blogs_tips_page.dart';
import '../health_description_page.dart';
import '../payment_successful_page.dart';
import '../totalhealthscore_result_page.dart';

class CoursesDetailPage extends StatefulWidget {
  const CoursesDetailPage({Key? key}) : super(key: key);

  @override
  _CoursesDetailPageState createState() => _CoursesDetailPageState();
}

class _CoursesDetailPageState extends State<CoursesDetailPage> {

  late List<BlogData> blogData = [];
  CoursesData coursesData = Get.arguments;

  List<BuyCourseModel> buyCourseModel = [];

  //var price = coursesData.price;

  bool _isLoad = false;

  late Razorpay _razorpay;
  late Future future;


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
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }


  _trySubmit()async{
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoad = true;
    });
    await Provider.of<CoursesRepo>(context,listen: false).buycourseApi(coursesData.courseId);
    setState(() {
      _isLoad= false;
    });

  }

  static const platform = const MethodChannel("razorpay_flutter");




  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_vQOXAJXDVlhsQ4',
      'amount': ((int.parse(coursesData.price))*100),
      'name': 'AEC_App.',
      'description': coursesData.name.toString(),
      'prefill': {'contact': '8650965058', 'email': 'rajeev.kumar@aaratechnologies.in'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    var paymentid = response.paymentId;
    var orderId = response.orderId;
    var courseprice = coursesData.price;
    Get.defaultDialog(
      radius: 5,
      backgroundColor: Colors.white,
      title: 'Your payment Successfull.',
      titleStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold),
      content: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceAround,
        children: [
          if(_isLoad)
            CircularProgressIndicator()
          else InkWell(
              onTap: () async{
                setState(() {
                  // _trySubmit();
                  Get.offAll(PaymentSuccessfulPage(),arguments: [paymentid,orderId,courseprice],
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 600));
                });
              },
              child: Center(
                child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius:
                        BorderRadius.circular(
                            20)),
                        child: Center(
                        child: Text(
                          "OK",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ))),
              )),
        ],
      ),
    );
    // Get.offAll(OrderSuccessfulPage(),arguments: [checkoutModel[0].data,paymentid],
    //   transition: Transition.zoom,
    //   curve: Curves.bounceOut,
    //   duration: Duration(milliseconds: 600),
    // );
    // Fluttertoast.showToast(
    //     msg: "Your payment successfully completed ", toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
    //     toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: " + response.walletName!, toastLength: Toast.LENGTH_SHORT);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          centerTitle: true,
          title: Text("Courses",
            style: StringsStyle.pagetitlestyle,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _caroselslider(),
                      SizedBox(height: 10),
                      _overview(),
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
                            onTap: () {
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
                                )))
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
                            onTap: () {
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
                                )))
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
                          onTap: () {
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
                              )))
                    ],
                  ),
                  Text(
                      "\"Track your Health\nStatus with Total\nHealth Score.\"",
                      style: TextStyle(
                          color: AppColors.appbarbackgroundColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
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

  _overview() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        Text("Overview",
            style: TextStyle(
                color: AppColors.darktextColor,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(coursesData.name,style: TextStyle(
              color: AppColors.darktextColor,
              fontSize: 17,
              fontWeight: FontWeight.bold)),
        ),
        // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //   Row(
        //     children: [
        //       Text("Date",
        //           style: TextStyle(
        //               color: AppColors.darktextColor,
        //               fontSize: 12,
        //               fontWeight: FontWeight.bold)),
        //       Text("  15 JUN 2020",
        //           style: TextStyle(
        //             color: AppColors.darktextColor,
        //             fontSize: 12,
        //           )),
        //     ],
        //   ),
        //   Row(
        //     children: [
        //       Text("Time",
        //           style: TextStyle(
        //               color: AppColors.darktextColor,
        //               fontSize: 12,
        //               fontWeight: FontWeight.bold)),
        //       Text("  1.0 pm",
        //           style: TextStyle(
        //             color: AppColors.darktextColor,
        //             fontSize: 12,
        //           )),
        //     ],
        //   )
        // ]),
        SizedBox(height: 5),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: coursesData.feature.length,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3),
                child: Row(
                  children: [
                    Icon(Icons.done,color: Colors.lightGreen,),
                    SizedBox(width: 10,),
                    Text(coursesData.feature[index].toString(),style: TextStyle(
                        fontSize: 15,
                        color: AppColors.darktextColor,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
              );

            }),
        // Text(
        //     "Huber and colleagues suggest that the problem with the WHO definition is the absoluteness of ‘complete’ wellbeing. This, they suggest, inadvertently contributes to the ‘over-medicalisation’ of the population. It allows a platform for industry, medical technologies and professionals to redefine our health status. ",
        //     style: TextStyle(
        //       fontSize: 12,
        //       color: AppColors.darktextColor,
        //     )),
        SizedBox(height: 5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Text("Duration: ",
                  style: TextStyle(
                      color: AppColors.darktextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              Text(coursesData.duration+" "+coursesData.durationType,
                  style: TextStyle(
                    color: AppColors.darktextColor,
                    fontSize: 12,
                  )),
            ],
          ),
          Row(
            children: [
              Text("Rs.",
                  style: TextStyle(
                      color: AppColors.darktextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              Text("${coursesData.price}",
                  style: TextStyle(
                    color: AppColors.darktextColor,
                    fontSize: 12,
                  )),
            ],
          ),
        ]),
        SizedBox(height: 5),
        Divider(color: Colors.grey),
        SizedBox(height: 15),
        Text("Steps we follow to help you",
            style: TextStyle(
                color: AppColors.darktextColor,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                    height: 60,
                    width: 55,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/step1.png")))),
                SizedBox(height: 5),
                Text("Connect\nwith our expert",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11))
              ],
            ),
            Text("------"),
            Column(
              children: [
                Container(
                    height: 60,
                    width: 55,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/onboard3.png")))),
                SizedBox(height: 5),
                Text("voice/video calls",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11))
              ],
            ),
            Text("------"),
            Column(
              children: [
                Container(
                    height: 60,
                    width: 55,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/onboard1.png")))),
                SizedBox(height: 5),
                Text("Face to face\nsession.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11))
              ],
            ),
          ],
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InkWell(
              onTap:()async{
                await _trySubmit();
                print("dhsjdscd");
                String status = await SharedPrefManager.getPrefrenceString(AppConstant.STATUS);
                String buyId = await SharedPrefManager.getPrefrenceString(AppConstant.BUYID);
                print("ddddddddddd"+buyId);
                print("djkdd"+status);
                if(status=="1")
                {
                  Get.defaultDialog(
                    radius: 5,
                    backgroundColor: Colors.white,
                    title: 'Are you sure you want to Buy?',
                    titleStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    content: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: () async{
                              setState(() async{
                                openCheckout();
                              });
                            },
                            child: Center(
                              child: Container(
                                  height: 45,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color(0xffED816E),
                                        Color(0xffB93342),
                                        // Colors.red.shade500,
                                        // AppColors.redColor,
                                      ]),
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          20)),
                                  child: Center(
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ))),
                            )),
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Center(
                              child: Container(
                                  height: 45,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color(0xffED816E),
                                        Color(0xffB93342),
                                        // Colors.red.shade500,
                                        // AppColors.redColor,
                                      ]),
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          20)),
                                  child: Center(
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ))),
                            )),
                      ],
                    ),
                  );
                }else{
                }
              },
              child: CustomButton(
                  text1: "", text2: "Buy Now", width: Get.width, height: 50)),
        )
      ]),
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
            if (blogData.isEmpty)
              Center(child: CircularProgressIndicator())
            else
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
//           Container(
//             height: Get.height / 2,
//             width: Get.width / 1,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 primary: true,
//                 itemCount: 3,
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
//                                       image: AssetImage(
//                                           "assets/images/motivationimage.jpg"),
//                                       fit: BoxFit.cover))),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(height: 5),
//                                 Text("5 Foods To Recover Your Energy",
//                                     style: TextStyle(
//                                         color:
//                                             AppColors.appbarbackgroundColor,
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
//                             CircleAvatar(),
//                             SizedBox(width: 10),
//                             Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Daily Digest",
//                                       style: TextStyle(
//                                           color: AppColors.blueColor,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w600)),
//                                   SizedBox(height: 3),
//                                   Text("Curated Health Tips",
//                                       style: TextStyle(
//                                           color:
//                                               AppColors.appbarbackgroundColor,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w600)),
//                                 ])
//                           ])),
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
