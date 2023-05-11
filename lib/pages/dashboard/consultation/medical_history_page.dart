// @dart=2.9
import 'package:aec_medical/api/repository/consultation_repo.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/consultationModel/medicalhistoryanswer_model.dart';
import 'package:aec_medical/model/consultationModel/medicalhistoryanswer_model.dart';
import 'package:aec_medical/model/consultationModel/medicalhistoryquestion_model.dart';
import 'package:aec_medical/pages/dashboard/bottom_navigation_bar_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MedicalHistoryPage extends StatefulWidget {
  const MedicalHistoryPage({Key key}) : super(key: key);

  @override
  _MedicalHistoryPageState createState() => _MedicalHistoryPageState();
}

class _MedicalHistoryPageState extends State<MedicalHistoryPage> {
  final _formKey = GlobalKey<FormState>();

  var index = "a";
  var _radioSelected = 0;
  var _radioSelected1 = 0;
  var _radioSelected2 = 0;
  var _radioSelected3 = 0;
  var _radioSelected4 = 0;
  var _radioSelected5 = 0;
  var _radioSelected6 = 0;
  var _radioSelected7 = 0;
  var _radioSelected8 = 0;
  var _radioSelected9 = 0;

  TextEditingController _question = new TextEditingController();
  TextEditingController _question1 = new TextEditingController();
  TextEditingController _question2 = new TextEditingController();
  TextEditingController _question3 = new TextEditingController();
  TextEditingController _question4 = new TextEditingController();
  TextEditingController _question5 = new TextEditingController();
  TextEditingController _question6 = new TextEditingController();
  TextEditingController _question7 = new TextEditingController();
  TextEditingController _question8 = new TextEditingController();
  TextEditingController _question9 = new TextEditingController();

  String answer;
  bool _isLoad = false;
  List<MedicalHistroryQuestionModel> medicalHistroryQuestionModel = [];
  List<MedicalHistoryAnswerModel> medicalHistoryAnswerModel = [];

  @override
  void initState() {
    super.initState();
    ConsultationRepo consultationRepo = new ConsultationRepo();
    Future future = consultationRepo.medicalHistroryQuestionApi();
    future.then((value) {
      setState(() {
        medicalHistroryQuestionModel = value;
        print("ssspeciality" +
            medicalHistroryQuestionModel[0].data.questionFirst);
      });
    });
  }

  void _trySubmit() async {
    if (_formKey.currentState.validate()) {

      setState(() {
        _isLoad = true;
      });

      ConsultationRepo consultationRepo = new ConsultationRepo();

      await consultationRepo.medicalHistoryAnswerApi(
        _question.text.isEmpty ? "No" : _question.text,
        _question1.text.isEmpty ? "No" : _question1.text,
        _question2.text.isEmpty ? "No" : _question2.text,
        _question3.text.isEmpty ? "No" : _question3.text,
        _question4.text.isEmpty ? "No" : _question4.text,
        _question5.text.isEmpty ? "No" : _question5.text,
        _question6.text.isEmpty ? "No" : _question6.text,
        _question7.text.isEmpty ? "No" : _question7.text,
        _question8.text.isEmpty ? "No" : _question8.text,
        _question9.text.isEmpty ? "No" : _question9.text,
      );

      setState(() {
        _isLoad = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appbarbackgroundColor,
        centerTitle: true,
        title: Text(
          "Medical History",
          style: StringsStyle.pagetitlestyle,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: medicalHistroryQuestionModel.isEmpty
                      ? CircularProgressIndicator()
                      : Column(
                          children: [
                            if (medicalHistroryQuestionModel[0]
                                .data
                                .questionFirst
                                .isEmpty)
                              Text("")
                            else
                              Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                  "Q.1  ${medicalHistroryQuestionModel[0].data.questionFirst}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .darktextColor)),
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    groupValue: _radioSelected,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected = value;
                                                        answer = 'Yes';
                                                      });
                                                    },
                                                  ),
                                                  Text('Yes',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  Radio(
                                                    value: 2,
                                                    groupValue: _radioSelected,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected = value;
                                                        answer = 'No';
                                                      });
                                                    },
                                                  ),
                                                  Text('No',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ],
                                              ),
                                            ])),
                                        _questiontxtfield(),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            // SizedBox(height: 15,),
                            if (medicalHistroryQuestionModel[0]
                                .data
                                .questionSecond
                                .isEmpty)
                              Text("")
                            else
                              Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                  "Q.2 ${medicalHistroryQuestionModel[0].data.questionSecond}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .darktextColor)),
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    groupValue: _radioSelected1,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected1 = value;
                                                        answer = 'Yes';
                                                      });
                                                    },
                                                  ),
                                                  Text('Yes',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  Radio(
                                                    value: 2,
                                                    groupValue: _radioSelected1,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected1 = value;
                                                        answer = 'No';
                                                      });
                                                    },
                                                  ),
                                                  Text('No',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ],
                                              ),
                                            ])),
                                        _question1txtfield(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            // SizedBox(height: 15,),
                            if (medicalHistroryQuestionModel[0]
                                .data
                                .questionThird
                                .isEmpty)
                              Text("")
                            else
                              Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                  "Q.3 ${medicalHistroryQuestionModel[0].data.questionThird}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .darktextColor)),
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    groupValue: _radioSelected2,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected2 = value;
                                                        answer = 'Yes';
                                                      });
                                                    },
                                                  ),
                                                  Text('Yes',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  Radio(
                                                    value: 2,
                                                    groupValue: _radioSelected2,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected2 = value;
                                                        answer = 'No';
                                                      });
                                                    },
                                                  ),
                                                  Text('No',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ],
                                              ),
                                            ])),
                                        _question2txtfield(),
                                        SizedBox(
                                          height: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            if (medicalHistroryQuestionModel[0]
                                .data
                                .questionFourth
                                .isEmpty)
                              Text("")
                            else
                              Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                  "Q.4 ${medicalHistroryQuestionModel[0].data.questionFourth}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .darktextColor)),
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    groupValue: _radioSelected3,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected3 = value;
                                                        answer = 'Yes';
                                                      });
                                                    },
                                                  ),
                                                  Text('Yes',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  Radio(
                                                    value: 2,
                                                    groupValue: _radioSelected3,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected3 = value;
                                                        answer = 'No';
                                                      });
                                                    },
                                                  ),
                                                  Text('No',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ],
                                              ),
                                            ])),
                                        _question3txtfield(),
                                        SizedBox(
                                          height: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            // SizedBox(height: 15,),
                            if (medicalHistroryQuestionModel[0]
                                .data
                                .questionFifth
                                .isEmpty)
                              Text("")
                            else
                              Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                  "Q.5 ${medicalHistroryQuestionModel[0].data.questionFifth}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .darktextColor)),
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    groupValue: _radioSelected4,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected4 = value;
                                                        answer = 'Yes';
                                                      });
                                                    },
                                                  ),
                                                  Text('Yes',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  Radio(
                                                    value: 2,
                                                    groupValue: _radioSelected4,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected4 = value;
                                                        answer = 'No';
                                                      });
                                                    },
                                                  ),
                                                  Text('No',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ],
                                              ),
                                            ])),
                                        _question4txtfield(),
                                        SizedBox(
                                          height: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            // SizedBox(height: 15,),
                            if (medicalHistroryQuestionModel[0]
                                .data
                                .questionSixth
                                .isEmpty)
                              Text("")
                            else
                              Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                  "Q.6 ${medicalHistroryQuestionModel[0].data.questionSixth}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .darktextColor)),
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    groupValue: _radioSelected5,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected5 = value;
                                                        answer = 'Yes';
                                                      });
                                                    },
                                                  ),
                                                  Text('Yes',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  Radio(
                                                    value: 2,
                                                    groupValue: _radioSelected5,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected5 = value;
                                                        answer = 'No';
                                                      });
                                                    },
                                                  ),
                                                  Text('No',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ],
                                              ),
                                            ])),
                                        _question5txtfield(),
                                        SizedBox(
                                          height: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            // SizedBox(height: 15,),
                            if (medicalHistroryQuestionModel[0]
                                .data
                                .questionSeventh
                                .isEmpty)
                              Text("")
                            else
                              Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                  "Q.7 ${medicalHistroryQuestionModel[0].data.questionSeventh}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .darktextColor)),
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    groupValue: _radioSelected6,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected6 = value;
                                                        answer = 'Yes';
                                                      });
                                                    },
                                                  ),
                                                  Text('Yes',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  Radio(
                                                    value: 2,
                                                    groupValue: _radioSelected6,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected6 = value;
                                                        answer = 'No';
                                                      });
                                                    },
                                                  ),
                                                  Text('No',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ],
                                              ),
                                            ])),
                                        _question6txtfield(),
                                        SizedBox(
                                          height: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            // SizedBox(height: 15,),
                            if (medicalHistroryQuestionModel[0]
                                .data
                                .questionEight
                                .isEmpty)
                              Text("")
                            else
                              Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                  "Q.8 ${medicalHistroryQuestionModel[0].data.questionEight}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .darktextColor)),
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    groupValue: _radioSelected7,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected7 = value;
                                                        answer = 'Yes';
                                                      });
                                                    },
                                                  ),
                                                  Text('Yes',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  Radio(
                                                    value: 2,
                                                    groupValue: _radioSelected7,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected7 = value;
                                                        answer = 'No';
                                                      });
                                                    },
                                                  ),
                                                  Text('No',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ],
                                              ),
                                            ])),
                                        _question7txtfield(),
                                        SizedBox(
                                          height: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            // SizedBox(height: 15,),
                            if (medicalHistroryQuestionModel[0]
                                .data
                                .questionNinth
                                .isEmpty)
                              Text("")
                            else
                              Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                  "Q.9 ${medicalHistroryQuestionModel[0].data.questionNinth}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .darktextColor)),
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    groupValue: _radioSelected8,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected8 = value;
                                                        answer = 'Yes';
                                                      });
                                                    },
                                                  ),
                                                  Text('Yes',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  Radio(
                                                    value: 2,
                                                    groupValue: _radioSelected8,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected8 = value;
                                                        answer = 'No';
                                                      });
                                                    },
                                                  ),
                                                  Text('No',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ],
                                              ),
                                            ])),
                                        _question8txtfield(),
                                        SizedBox(
                                          height: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            // SizedBox(height: 15,),
                            if (medicalHistroryQuestionModel[0]
                                .data
                                .questionTenth
                                .isEmpty)
                              Text("")
                            else
                              Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                  "Q.10 ${medicalHistroryQuestionModel[0].data.questionTenth}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .darktextColor)),
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    groupValue: _radioSelected9,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected9 = value;
                                                        answer = 'Yes';
                                                      });
                                                    },
                                                  ),
                                                  Text('Yes',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  Radio(
                                                    value: 2,
                                                    groupValue: _radioSelected9,
                                                    activeColor: Colors.black,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioSelected9 = value;
                                                        answer = 'No';
                                                      });
                                                    },
                                                  ),
                                                  Text('No',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ],
                                              ),
                                            ])),
                                        _question9txtfield(),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                ),
                // SizedBox(height: 30,),
                if (_isLoad)
                  CircularProgressIndicator()
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: InkWell(
                        onTap: _trySubmit,
                        child: CustomButton(
                            text1: "",
                            text2: "Continue",
                            width: Get.width,
                            height: 50)),
                  ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _questiontxtfield() {
    return Visibility(
      visible: _radioSelected == 1 ? true : false,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
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
                Colors.white,
                Colors.white54,
              ]),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.bottomLeft,
            child: TextFormField(
              controller: _question,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlignVertical: TextAlignVertical.bottom,
              // maxLines: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                labelText: "Answer",
                labelStyle: TextStyle(
                  color: AppColors.lighttextColor,
                  fontSize: 14,
                ),
              ),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "Please, enter your answer";
                }

                return null;
              },
            )),
      ),
    );
  }

  _question1txtfield() {
    return Visibility(
      visible: _radioSelected1 == 1 ? true : false,
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
              Colors.white,
              Colors.white54,
            ]),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.bottomLeft,
          child: TextFormField(
            controller: _question1,
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            // maxLines: 10,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
              labelText: "Answer",
              labelStyle: TextStyle(
                color: AppColors.lighttextColor,
                fontSize: 14,
              ),
            ),
            validator: (value) {
              if (value.trim().isEmpty) {
                return "Please, enter your answer";
              }

              return null;
            },
          )),
    );
  }

  _question2txtfield() {
    return Visibility(
      visible: _radioSelected2 == 1 ? true : false,
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
              Colors.white,
              Colors.white54,
            ]),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.bottomLeft,
          child: TextFormField(
            controller: _question2,
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            // maxLines: 10,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
              labelText: "Answer",
              labelStyle: TextStyle(
                color: AppColors.lighttextColor,
                fontSize: 14,
              ),
            ),
            validator: (value) {
              if (value.trim().isEmpty) {
                return "Please, enter your answer";
              }

              return null;
            },
          )),
    );
  }

  _question3txtfield() {
    return Visibility(
      visible: _radioSelected3 == 1 ? true : false,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
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
                Colors.white,
                Colors.white54,
              ]),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.bottomLeft,
            child: TextFormField(
              controller: _question3,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlignVertical: TextAlignVertical.bottom,
              // maxLines: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                labelText: "Answer",
                labelStyle: TextStyle(
                  color: AppColors.lighttextColor,
                  fontSize: 14,
                ),
              ),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "Please, enter your answer";
                }

                return null;
              },
            )),
      ),
    );
  }

  _question4txtfield() {
    return Visibility(
      visible: _radioSelected4 == 1 ? true : false,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
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
                Colors.white,
                Colors.white54,
              ]),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.bottomLeft,
            child: TextFormField(
              controller: _question4,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlignVertical: TextAlignVertical.bottom,
              // maxLines: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                labelText: "Answer",
                labelStyle: TextStyle(
                  color: AppColors.lighttextColor,
                  fontSize: 14,
                ),
              ),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "Please, enter your answer";
                }

                return null;
              },
            )),
      ),
    );
  }

  _question5txtfield() {
    return Visibility(
      visible: _radioSelected5 == 1 ? true : false,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
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
                Colors.white,
                Colors.white54,
              ]),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.bottomLeft,
            child: TextFormField(
              controller: _question5,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlignVertical: TextAlignVertical.bottom,
              // maxLines: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                labelText: "Answer",
                labelStyle: TextStyle(
                  color: AppColors.lighttextColor,
                  fontSize: 14,
                ),
              ),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "Please, enter your answer";
                }

                return null;
              },
            )),
      ),
    );
  }

  _question6txtfield() {
    return Visibility(
      visible: _radioSelected6 == 1 ? true : false,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
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
                Colors.white,
                Colors.white54,
              ]),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.bottomLeft,
            child: TextFormField(
              controller: _question6,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlignVertical: TextAlignVertical.bottom,
              // maxLines: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                labelText: "Answer",
                labelStyle: TextStyle(
                  color: AppColors.lighttextColor,
                  fontSize: 14,
                ),
              ),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "Please, enter your answer";
                }

                return null;
              },
            )),
      ),
    );
  }

  _question7txtfield() {
    return Visibility(
      visible: _radioSelected7 == 1 ? true : false,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
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
                Colors.white,
                Colors.white54,
              ]),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.bottomLeft,
            child: TextFormField(
              controller: _question7,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlignVertical: TextAlignVertical.bottom,
              // maxLines: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                labelText: "Answer",
                labelStyle: TextStyle(
                  color: AppColors.lighttextColor,
                  fontSize: 14,
                ),
              ),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "Please, enter your answer";
                }

                return null;
              },
            )),
      ),
    );
  }

  _question8txtfield() {
    return Visibility(
      visible: _radioSelected8 == 1 ? true : false,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
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
                Colors.white,
                Colors.white54,
              ]),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.bottomLeft,
            child: TextFormField(
              controller: _question8,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlignVertical: TextAlignVertical.bottom,
              // maxLines: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                labelText: "Answer",
                labelStyle: TextStyle(
                  color: AppColors.lighttextColor,
                  fontSize: 14,
                ),
              ),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "Please, enter your answer";
                }

                return null;
              },
            )),
      ),
    );
  }

  _question9txtfield() {
    return Visibility(
      visible: _radioSelected9 == 1 ? true : false,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
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
                Colors.white,
                Colors.white54,
              ]),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.bottomLeft,
            child: TextFormField(
              controller: _question9,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlignVertical: TextAlignVertical.bottom,
              // maxLines: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                labelText: "Answer",
                labelStyle: TextStyle(
                  color: AppColors.lighttextColor,
                  fontSize: 14,
                ),
              ),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "Please, enter your answer";
                }

                return null;
              },
            )),
      ),
    );
  }
}
