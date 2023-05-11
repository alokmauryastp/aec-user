// @dart=2.9
import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/auth_repo.dart';
import 'package:aec_medical/api/repository/profile_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/profilemodel/getprofile_model.dart';
import 'package:aec_medical/pages/dashboard/consultation/find_doctors_page.dart';
import 'package:aec_medical/pages/dashboard/consultation/payment_page.dart';
import 'package:aec_medical/pages/dashboard/consultation/select_diseases_page.dart';
import 'package:aec_medical/pages/dashboard/consultation/select_specialist_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_choices/search_choices.dart';

class FillPersonalDetailPage extends StatefulWidget {
  const FillPersonalDetailPage({Key key}) : super(key: key);

  @override
  _FillPersonalDetailPageState createState() => _FillPersonalDetailPageState();
}

class _FillPersonalDetailPageState extends State<FillPersonalDetailPage> {
  List<String> _gender = [
    'Male',
    'Female',
  ];

  List<String> _city = [];

  var _type = [];
  // var  RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)
  // static  RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]').hasMatch(value);

  String patientage;
  String _selectgen;
  String _selectCity;
  String _selectMonths = '0 Month';
  String _selectYear = '0 Year';
  bool isExpand = false;
  var Patient = [
    "Myself",
    "Father",
    "Mother",
    "Wife",
    "Husband",
    "Baby",
    "Relatives",
    "Other",
  ];

  int _index = 0;
  final _formKey = GlobalKey<FormState>();
  final _patientname = TextEditingController();
  final _patientaddress = TextEditingController();
  final _othertextEditingController = TextEditingController();
  var focusNode = FocusNode();
  List cityModel;
  int year = DateTime.now().year;

  final List<DropdownMenuItem> years = [];
  final List<DropdownMenuItem> months = [];
  final List<DropdownMenuItem> items = [];
  List<GetProfileModel> getProfileModel = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < 12; i++) {
      months.add(DropdownMenuItem(
        child: Text("$i Month"),
        value: "$i Month",
      ));
    }

    for (var i = 0; i < 116; i++) {
      years.add(DropdownMenuItem(
        child: Text("$i Year"),
        value: "$i Year",
      ));
    }
    gettype();

    SharedPrefManager.savePrefString(AppConstant.PATIENT, Patient[0]);

    ProfileRepo profileRepo = new ProfileRepo();
    Future future1 = profileRepo.getproifileApi();
    future1.then((value) {
      setState(() {
        getProfileModel = value;
        // if (_index == 0) {
        _patientname.text = getProfileModel[0].data.name;
        _patientaddress.text = getProfileModel[0].data.address;

        _selectgen = getProfileModel[0].data.gender;
        // }

        var datte = getTheKidsAge(getProfileModel[0].data.dOB);
        print("finalDate : ${datte.years}");
        print("finalDate : ${datte.months}");
        print("finalDate : ${datte.days}");

        // _patientage.text= datte.years.toString()+" Year";
        // _patientmonth.text= datte.months.toString()+" Month";
        _selectMonths = "${datte.months} Month";
        _selectYear = "${datte.years} Year";
      });
    });

    AuthRepo authRepo = new AuthRepo();
    Future future = authRepo.getDistrict();
    future.then((value) {
      setState(() {
        cityModel = value;
        print("ssscity" + cityModel.length.toString());
        // _city = cityModel.data['district'];
        for (var i = 0; i < cityModel.length; i++) {
          _city.add(cityModel[i]['district']);
          items.add(DropdownMenuItem(
            child: Text(_city[i]),
            value: _city[i],
          ));
        }
      });
    });

    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
        resumeCallBack: () async => setState(() {
              print("resumed");
              _type = Get.arguments;
            })));
  }

  gettype() async {
    String type = await SharedPrefManager.getPrefrenceString(AppConstant.TYPE);
    String image = await SharedPrefManager.getPrefrenceString(AppConstant.TYPEIMAGE);
    print(type);
    print(image);
    setState(()  {
      _type = [type,image];
      // _type[1] = image;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          centerTitle: true,
          title: Text(
            "Fill personal details",
            style: StringsStyle.pagetitlestyle,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headingcard(),
                _dermotology(),
                _choosepatient(),
                _relationedittext(),
                _patientnamefield(),
                _patientageandgenderfield(),
                // _patientlocation(),
                _patientcity(),
                _nextbutton(),
              ],
            ),
          ),
        ));
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
                padding: const EdgeInsets.fromLTRB(15, 80, 15, 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text("Get online\nconsultation\nat your",
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
        Positioned(
          top: 25,
          right: 25,
          child: Container(
              height: 140,
              width: 180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/register.png"),
                      fit: BoxFit.cover))),
        ),
      ],
    );
  }

  _dermotology() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: InkWell(
            onTap: () async {
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      _type!=null ? _type[0] : " ",
                      style: TextStyle(
                        color: AppColors.darktextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _type[1] == null ? SizedBox() :
                  CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Container(
                          decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(_type[1]),
                          fit: BoxFit.cover,
                        ),
                      ))),

                  // Visibility(visible: false,
                  //   child: InkWell(
                  //     onTap: () async {
                  //       String from = await SharedPrefManager.getPrefrenceString(
                  //           AppConstant.FROMPAGE);
                  //       from == 'Speciality'
                  //           ? Get.to(SelectSpecialistPage(),
                  //           arguments: "2",
                  //           transition: Transition.leftToRightWithFade,
                  //           duration: Duration(milliseconds: 600))
                  //           : Get.to(SelectDiseasesPage(),
                  //           arguments: "2",
                  //           transition: Transition.leftToRightWithFade,
                  //           duration: Duration(milliseconds: 600));
                  //     },
                  //       child: Icon(
                  //     Icons.change_circle_outlined,
                  //     size: 30,
                  //     color: AppColors.appbarbackgroundColor,
                  //   )),
                  // )
                ],
              ),
            ),
          )),
    );
  }

  _choosepatient() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " Who is the patient?",
            style: StringsStyle.normaltextstyle,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: Get.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Patient.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        splashColor: AppColors.appbarbackgroundColor,
                        onTap: () {
                          if (_index == 0) {
                            _patientname.text = getProfileModel[0].data.name;
                            _patientaddress.text =
                                getProfileModel[0].data.address;
                            patientage = _selectYear + ' ' + _selectMonths;
                            _selectgen = getProfileModel[0].data.gender;
                          } else {
                            _patientname.text = '';
                            _patientaddress.text = '';
                            patientage = '';
                            _selectgen = '';
                          }
                          setState(() async {
                            _index = index;
                            if (Patient[index] == "Other") {
                              isExpand = isExpand ? false : true;
                              await SharedPrefManager.savePrefString(
                                  AppConstant.PATIENT, "Other");
                              print("Other");
                            } else {
                              await SharedPrefManager.savePrefString(
                                  AppConstant.PATIENT, Patient[index]);
                              //String h = await SharedPrefManager.getPrefrenceString(AppConstant.PATIENT);
                              //print("jdsh"+Patient[index]);
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 90,
                          decoration: BoxDecoration(
                            color: _index == index
                                ? Colors.red.shade400
                                : AppColors.whitetextColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: _index == index
                                    ? AppColors.whitetextColor
                                    : AppColors.appbarbackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(3, 3))
                            ],
                          ),
                          child: Center(
                            child: Text(Patient[index],
                                style: TextStyle(
                                    color: _index == index
                                        ? AppColors.whitetextColor
                                        : AppColors.appbarbackgroundColor)),
                          ),
                        ),
                      ));
                }),
          ),
        ],
      ),
    );
  }

  _patientnamefield() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " Patient Name",
            style: StringsStyle.normaltextstyle,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 50,
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
                // initialValue: !getProdfileModel.isNull && _index==0 ? getProfileModel[0].data.name : '',
                controller: _patientname,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
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
                  hintText: "  Patient Name",
                ),
                validator: (value) => value.isEmpty
                    ? 'Enter Your Name'
                    : RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                            .hasMatch(value)
                        ? 'Enter a Valid Name'
                        : null,
              )),
        ],
      ),
    );
  }

  _patientageandgenderfield() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " Patient Age",
                style: StringsStyle.normaltextstyle,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: Get.width / 1.8,
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
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 50,
                      width: Get.width / 4,
                      child: SearchChoices.single(
                        displayClearIcon: false,
                        validator: (value) {
                          return ((value?.length ?? 0) < 1 ? "Year" : null);
                        },
                        underline: SizedBox(),
                        padding: 0,
                        items: years,
                        value: _selectYear,
                        hint: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "Year",
                            style: TextStyle(fontSize: 16, height: 3),
                          ),
                        ),
                        searchHint: "Year",
                        onChanged: (value) {
                          setState(() {
                            _selectYear = value;
                          });
                        },
                        isExpanded: true,
                      ),
                    ),
                    // child: TextFormField(
                    //   maxLength: 3,
                    //   controller: _patientage,
                    //   keyboardType: TextInputType.number,
                    //   textInputAction: TextInputAction.done,
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //   textAlignVertical: TextAlignVertical.bottom,
                    //   decoration: InputDecoration(
                    //     counterText: "",
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //       borderSide: BorderSide(color: Colors.white, width: 1),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //       borderSide: BorderSide(color: Colors.white, width: 1),
                    //     ),
                    //     errorBorder: OutlineInputBorder(
                    //         borderSide: new BorderSide(
                    //             color: Colors.transparent, width: 1),
                    //         borderRadius: BorderRadius.circular(10)),
                    //     focusedErrorBorder: OutlineInputBorder(
                    //         borderSide: new BorderSide(
                    //             color: Colors.transparent, width: 1),
                    //         borderRadius: BorderRadius.circular(10)),
                    //     border: OutlineInputBorder(
                    //         borderSide:
                    //             new BorderSide(color: Colors.yellow, width: 1),
                    //         borderRadius: BorderRadius.circular(10)),
                    //     hintText: "Years",
                    //     hintStyle: TextStyle(
                    //       color: AppColors.lighttextColor,
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     if (value.trim().isEmpty) {
                    //       return "Required!";
                    //     }
                    //     return null;
                    //   },
                    // )),
                    Divider(
                      height: 10,
                      color: Colors.redAccent,
                      thickness: 1,
                    ),
                    Container(
                      height: 50,
                      width: Get.width / 4,
                      child: SearchChoices.single(
                        displayClearIcon: false,
                        validator: (value) {
                          return ((value?.length ?? 0) < 1 ? "Months" : null);
                        },
                        underline: SizedBox(),
                        padding: 0,
                        items: months,
                        value: _selectMonths,
                        hint: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "Months",
                            style: TextStyle(fontSize: 16, height: 3),
                          ),
                        ),
                        searchHint: "Months",
                        onChanged: (value) {
                          setState(() {
                            _selectMonths = value;
                          });
                        },
                        isExpanded: true,
                      ),
                    ),
                    // child: TextFormField(
                    //   onChanged: (text) {
                    //     _patientmonth.text = text+' Months';
                    //   },
                    //   maxLength: 3,
                    //   controller: _patientmonth,
                    //   keyboardType: TextInputType.number,
                    //   textInputAction: TextInputAction.done,
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //   textAlignVertical: TextAlignVertical.bottom,
                    //   decoration: InputDecoration(
                    //     counterText: "",
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //       borderSide: BorderSide(color: Colors.white, width: 1),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //       borderSide: BorderSide(color: Colors.white, width: 1),
                    //     ),
                    //     errorBorder: OutlineInputBorder(
                    //         borderSide: new BorderSide(
                    //             color: Colors.transparent, width: 1),
                    //         borderRadius: BorderRadius.circular(10)),
                    //     focusedErrorBorder: OutlineInputBorder(
                    //         borderSide: new BorderSide(
                    //             color: Colors.transparent, width: 1),
                    //         borderRadius: BorderRadius.circular(10)),
                    //     border: OutlineInputBorder(
                    //         borderSide:
                    //             new BorderSide(color: Colors.yellow, width: 1),
                    //         borderRadius: BorderRadius.circular(10)),
                    //     hintText: "Months",
                    //     hintStyle: TextStyle(
                    //       color: AppColors.lighttextColor,
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     if (value.trim().isEmpty) {
                    //       return "Required!";
                    //     }
                    //     return null;
                    //   },
                    // )),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " Patient Gender",
                style: StringsStyle.normaltextstyle,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: Get.width / 3,
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
                child: Center(
                  child: DropdownButton(
                    underline: SizedBox(),
                    iconSize: 20.0,
                    hint: Text('Gender          '),
                    // Not necessary for Option 1
                    value: _selectgen,
                    onChanged: (newValue) {
                      setState(() {
                        _selectgen = newValue;
                      });
                      focusNode.requestFocus();
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
            ],
          ),
        ],
      ),
    );
  }

  _patientlocation() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " Patient Location",
            style: StringsStyle.normaltextstyle,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 50,
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
                focusNode: focusNode,
                controller: _patientaddress,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
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
                  hintText: "  Patient Location",
                ),
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Please, enter the patient location";
                  }

                  return null;
                },
              )),
        ],
      ),
    );
  }

  _patientcity() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " Patient City",
            style: StringsStyle.normaltextstyle,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            // height: 50,
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
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: SearchChoices.single(
                validator: (value) {
                  return ((value?.length ?? 0) < 1
                      ? "Please Select City"
                      : null);
                },
                underline: SizedBox(),
                padding: 0,
                items: items,
                value: _selectCity,
                hint: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Select City",
                    style: TextStyle(fontSize: 16, height: 3),
                  ),
                ),
                searchHint: "Select City",
                onChanged: (value) {
                  setState(() {
                    _selectCity = value;
                  });
                },
                isExpanded: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _nextbutton() {
    // ignore: deprecated_member_use
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FlatButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                await SharedPrefManager.savePrefString(
                    AppConstant.PATIENTNAME, _patientname.text);
                await SharedPrefManager.savePrefString(
                    AppConstant.PATIENTAGE, _selectYear + ' ' + _selectMonths);
                await SharedPrefManager.savePrefString(
                    AppConstant.PATIENTGENDER, _selectgen);
                await SharedPrefManager.savePrefString(
                    AppConstant.PATIENTADDRESS,
                    // _patientaddress.text + ' ' +
                    _selectCity);
                //await SharedPrefManager.savePrefString(AppConstant.PATIENT,Patient[]);

                String name = await SharedPrefManager.getPrefrenceString(
                    AppConstant.PATIENTNAME);
                String age = await SharedPrefManager.getPrefrenceString(
                    AppConstant.PATIENTAGE);
                String gen = await SharedPrefManager.getPrefrenceString(
                    AppConstant.PATIENTGENDER);
                String add = await SharedPrefManager.getPrefrenceString(
                    AppConstant.PATIENTADDRESS);
                // String patient = await SharedPrefManager.getPrefrenceString(AppConstant.PATIENT);
                print("shsas" + name);
                print("aa" + age);
                print("shsas" + gen);
                print("shsas" + add);
                //print("shsas"+patient);

                Get.to(
                    PaymentPage(),
                    // FindDoctorsPage(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 600));
              }
            },
            child:
                CustomButton(text1: "", text2: "Next", width: 150, height: 50)),
      ),
    );
  }

  _relationedittext() {
    return Visibility(
      visible: isExpand,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " Patient Relation",
              style: StringsStyle.normaltextstyle,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 50,
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
                  controller: _othertextEditingController,
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
                    hintText: "  Patient Relation",
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please, enter the Patient Relation";
                    }

                    return null;
                  },
                )),
          ],
        ),
      ),
    );
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;
  final AsyncCallback suspendingCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          await suspendingCallBack();
        }
        break;
    }
  }
}

class KidsAge {
  int years;
  int months;
  int days;

  KidsAge({this.years = 0, this.months = 0, this.days = 0});
}

KidsAge getTheKidsAge(String birthday) {
  if (birthday != '') {
    var birthDate = DateTime.tryParse(birthday);
    if (birthDate != null) {
      final now = new DateTime.now();

      int years = now.year - birthDate.year;
      int months = now.month - birthDate.month;
      int days = now.day - birthDate.day;

      if (months < 0 || (months == 0 && days < 0)) {
        years--;
        months += (days < 0 ? 11 : 12);
      }

      if (days < 0) {
        final monthAgo = new DateTime(now.year, now.month - 1, birthDate.day);
        days = now.difference(monthAgo).inDays + 1;
      }

      return KidsAge(years: years, months: months, days: days);
    } else {
      print('getTheKidsAge: not a valid date');
    }
  } else {
    print('getTheKidsAge: date is empty');
  }
  return KidsAge();
}
