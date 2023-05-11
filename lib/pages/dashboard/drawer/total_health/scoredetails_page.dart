// @dart=2.9
import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/auth_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/homeModel/healthScoreResult_model.dart';
import 'package:aec_medical/pages/dashboard/bottom_navigation_bar_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share/share.dart';
import 'package:unique_identifier/unique_identifier.dart';

class HealthDetailsPage extends StatefulWidget {
  const HealthDetailsPage({Key key}) : super(key: key);

  @override
  _HealthDetailsPageState createState() => _HealthDetailsPageState();
}

class _HealthDetailsPageState extends State<HealthDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _age = TextEditingController();
  List<String> _gender = ['Male', 'Female'];
  final _healthtips = TextEditingController();

  String _selectgen;

  List<HealthScoreResultModel> healthScoreResultModel = [];

  bool _isLoad = false;

  @override
  void initState() {
    super.initState();
    initUniqueIdentifierState();
  }

  Future<void> initUniqueIdentifierState() async {
    var identifier;
    try {
      identifier = await UniqueIdentifier.serial;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;

    setState(() {
      _identifier = identifier;
      print("devicetoken:" + _identifier);
    });
    await SharedPrefManager.savePrefString(AppConstant.MOBILTOKEN, _identifier);
    var t = await SharedPrefManager.getPrefrenceString(AppConstant.MOBILTOKEN);
    print("devicetok" + t);
  }

  void _trySubmit() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoad = true;
      });
      AuthRepo authRepo = new AuthRepo();
      Future future =
          authRepo.healthScoreResultApi(_name.text, _age.text, _selectgen);
      future.then((value) {
        setState(() {
          healthScoreResultModel = value;
          print("ssspeciality" +
              healthScoreResultModel[0].data.presentage.toString());
        });
      });
      setState(() {
        _isLoad = false;
      });
    }
  }

  double percent = 0.0;
  var _identifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appbarbackgroundColor,
        centerTitle: true,
        title: Text(
          "Health Score",
          style: StringsStyle.pagetitlestyle,
        ),
        // leading: Icon(Icons.arrow_back,color: Colors.white,),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
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
                          Colors.white70,
                        ]),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.bottomLeft,
                      child: TextFormField(
                        controller: _name,
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          errorBorder: new OutlineInputBorder(
                              borderSide: BorderSide.none),
                          labelText: "Name",
                          labelStyle: TextStyle(
                            color: AppColors.lighttextColor,
                            fontSize: 14,
                          ),
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Please enter Your Name'
                            : RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                    .hasMatch(value)
                                ? 'Please enter your valid Name'
                                : null,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
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
                          Colors.white70,
                        ]),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.bottomLeft,
                      child: TextFormField(
                        controller: _age,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          errorBorder: new OutlineInputBorder(
                              borderSide: BorderSide.none),
                          labelText: "Age",
                          labelStyle: TextStyle(
                            color: AppColors.lighttextColor,
                            fontSize: 14,
                          ),
                        ),
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return "Please, Enter age.";
                          }
                          return null;
                        },
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
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
                        Colors.white70,
                      ]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: DropdownButton(
                        underline: SizedBox(),
                        iconSize: 20.0,
                        hint: Text('Gender'),
                        // Not necessary for Option 1
                        value: _selectgen,
                        onChanged: (newValue) {
                          setState(() {
                            _selectgen = newValue;
                          });
                        },
                        items: _gender.map((gender) {
                          return DropdownMenuItem(
                            child: new Text(gender),
                            value: gender,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  if (_isLoad)
                    Center(child: CircularProgressIndicator())
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: InkWell(
                          onTap: _trySubmit,
                          child: CustomButton(
                              text1: "",
                              text2: "Check Your Health Score",
                              width: Get.width,
                              height: 50)),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
