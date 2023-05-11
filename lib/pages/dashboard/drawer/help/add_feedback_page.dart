import 'package:aec_medical/api/repository/consultation_repo.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../notification_page.dart';

class AddFeedbackPage extends StatefulWidget {
  const AddFeedbackPage({Key? key}) : super(key: key);

  @override
  _AddFeedbackPageState createState() => _AddFeedbackPageState();
}

class _AddFeedbackPageState extends State<AddFeedbackPage> {

  bool _isLoad = false;

  TextEditingController _feedback = new TextEditingController();

  var d = Get.arguments;

  late String profile = d[0];
  late var rating  = d[1];
  late String doctorname  = d[2];
  late String diease  = d[3];

  late double _rating;
  double _initialRating = 0.0;
  bool _isVertical = false;
  IconData? _selectedIcon;

  void _reviewApi()async{
    setState(() {
      _isLoad = true;
    });
    ConsultationRepo consultationRepo = new ConsultationRepo();
    consultationRepo.reviewApi(_feedback.text,_rating);
    setState(() {
      _isLoad = false;
    });
  }


  @override
  void initState() {
    super.initState();
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.keyboard_arrow_left_outlined,
                size: 30, color: AppColors.appbarbackgroundColor)),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(NotificationPage(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 600));
              },
              icon: Icon(Icons.notifications,
                  size: 30, color: AppColors.appbarbackgroundColor)),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Leave your feedback",
                style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),),
              SizedBox(height: 15,),
              Container(
                  height: Get.width / 2.5,
                  width: Get.width / 0.96,
                  child: Row(
                    children: [
                      Column(children: [
                          Container(
                            height: 110,
                            width: 100,
                            child: Image.network(profile),
                            //Image.asset("assets/images/doctorprofile.jpg",),
                            decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(6.0),
                                ) ),
                               )
                        ,]
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doctorname,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darktextColor)),
                          SizedBox(height: 5),
                          Text(diease,
                              style: TextStyle(
                                  color: AppColors.lighttextColor)),
                          SizedBox(height: 3),
                          // Text("Fortis escorts Jaipur.",
                          //     style: TextStyle(
                          //         color: AppColors.lighttextColor)),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              // Row(children: [
                              //   Icon(Icons.star, color: Colors.orange),
                              //   Icon(Icons.star, color: Colors.orange),
                              //   Icon(Icons.star, color: Colors.orange),
                              //   Icon(Icons.star_border,
                              //       color: Colors.orange),
                              //   Icon(Icons.star_border,
                              //       color: Colors.orange),
                              // ]),
                              RatingBar.builder(
                                initialRating: double.parse(rating),
                                minRating: double.parse(rating),
                                maxRating: double.parse(rating),
                                // itemCount: double.parse(rating),
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
                              SizedBox(width: 5),
                              Text("(${rating.toString()}/5)",
                                  style: TextStyle(
                                      color: AppColors.lighttextColor)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
              Container(height: 1.5,color: Colors.grey,),
              SizedBox(height: 20,),
              _ratingbar(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Row(children: [
              //       Icon(Icons.star, color: Colors.orange,size: 40,),
              //       Icon(Icons.star, color: Colors.orange,size: 40,),
              //       Icon(Icons.star, color: Colors.orange,size: 40,),
              //       Icon(Icons.star_border,
              //           color: Colors.orange,size: 40,),
              //       Icon(Icons.star_border,
              //           color: Colors.orange,size: 40,),
              //     ]),
              //   ],
              // ),

              SizedBox(height: 30,),
              _feedbackfield(),

              SizedBox(height: 30,),
              if(_isLoad)
                CircularProgressIndicator()
              else Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                    onTap: () {
                      _reviewApi();
                    },
                    child: CustomButton(
                        text1: "",
                        text2: "Add Feedback",
                        width: Get.width,
                        height: 50)),
              ),



            ],
          ),
        ),
      ),

    );
  }

  _ratingbar(){
    return RatingBar.builder(
      initialRating: _initialRating,
      minRating: 0,
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 5,
      itemSize: 50.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.orange,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
      updateOnDrag: true,
    );
  }

  _feedbackfield() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 250,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.whitetextColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.appbarbackgroundColor),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(3, 3))
                ],
              ),
              child: TextFormField(
                maxLines: 10,
                controller: _feedback,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide:
                      new BorderSide(color: Colors.transparent, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                      new BorderSide(color: Colors.transparent, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderSide:
                      new BorderSide(color: Colors.yellow, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "  Write your feedback",
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please, Write your feedback";
                  }

                  return null;
                },
              )),
        ],
      ),
    );
  }
}
