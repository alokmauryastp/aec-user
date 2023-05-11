// @dart=2.9
import 'dart:io';

import 'package:aec_medical/api/repository/profile_repo.dart';
import 'package:aec_medical/controller/profile_controller.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/profilemodel/getprofile_model.dart';
import 'package:aec_medical/pages/dashboard/notification_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditMyAccountPage extends StatefulWidget {
  const EditMyAccountPage({Key key}) : super(key: key);

  @override
  _EditMyAccountPageState createState() => _EditMyAccountPageState();
}

class _EditMyAccountPageState extends State<EditMyAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final profileController = Get.put(ProfileController());

  DateTime selectedDate = DateTime.now();
  var formatDate;

  GetProfileData getProfileModel = Get.arguments;




  List<String> _genders = ['Male','Female'];



  String _selectgen;

   String files;
   File filename;
   File newFile;
  final _formkey = GlobalKey<FormState>();
  GetProfileData getProfileData = Get.arguments;
   String name;
   String mobilenumber;
   String email;
   String gender;
   var dob;
   String blood;
   String materialstatus;
   String height;
   String weight;
   String alternetnumber;
   String address;
   String image;



  void _allDetail()async{
    var images = getProfileData.profile;
    var names = getProfileData.name;
    var mobilnumbers = getProfileData.mobile;
    var emails = getProfileData.email;
    var genders = getProfileData.gender;
    var dateob = getProfileData.dOB;
    var bloodg = getProfileData.bloodGroup;
    var mstatus = getProfileData.marritalStatus;
    var heights = getProfileData.height;
    var weights = getProfileData.weight;
    var alternetmobileno = getProfileData.alternetContact;
    var addresses = getProfileData.address;

    setState(() {
      name = names;
      mobilenumber = mobilnumbers;
      email=emails;
      gender = genders;
      dob = dateob;
      blood = bloodg;
      materialstatus=mstatus;
      height = heights;
      weight = weights;
      alternetnumber = alternetmobileno;
      address = addresses;
      image= images;
    });
    _name.text = names;
    _mobile.text = mobilnumbers;
    _email.text=emails;
    _gender.text = genders;
    _dob.text = dateob;
    _blood.text = bloodg;
    _materialstatus.text = mstatus;
    _height.text = heights;
    _weight.text = weights;
    _alternetnumber.text = alternetmobileno;
    _address.text = addresses;
    //_image.text = image;
  }

  final _name = TextEditingController();
  final _mobile = TextEditingController();
  final _email = TextEditingController();
  final _gender = TextEditingController();
  final _dob = TextEditingController();
  final _blood = TextEditingController();
  final _materialstatus = TextEditingController();
  final _height = TextEditingController();
  final _weight = TextEditingController();
  final _alternetnumber = TextEditingController();
  final _address = TextEditingController();
  final _image = TextEditingController();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime(1980),
        lastDate: DateTime.now());
    if(picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formatDate = selectedDate.year.toString() + "/"+selectedDate.month.toString() + "/" +selectedDate.day.toString();
      });
    }
  }



  @override
  void initState() {
    _allDetail();
    print("aaaaaaaaaaaaa"+getProfileData.name);
    super.initState();
  }

  bool _isLoad = false;
  void _updateprofile()async{
    setState(() {
      _isLoad = true;
    });
    ProfileRepo profileRepo = new ProfileRepo();
    await profileRepo.updateproifileApi(_name.text,_selectgen.isNull?gender:_selectgen, _mobile.text, _email.text,  selectedDate.isNull?dob:selectedDate, _blood.text, _materialstatus.text, _height.text, _weight.text, _alternetnumber.text, _address.text);
    setState(() {
      _isLoad = false;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(NotificationPage(),
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 600));
                }, icon: Icon(Icons.notifications, size: 30)),
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    child: Column(children: [
          _headingcard(),
          SizedBox(height: 2),
          _personaldetailbanner(),
          SizedBox(height: 2),
          _editimagebody(),
          _editprofilebody(),
        ])))));
  }

  _headingcard() {
    return Container(
      width: Get.width,
      child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(image),),
                SizedBox(width: 20),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Hello ${name},",
                      style: TextStyle(
                          color: AppColors.darktextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16)),
                  SizedBox(height: 5),
                  Text("How're you today?",
                      style: TextStyle(
                          color: AppColors.darktextColor, fontSize: 12)),
                ]),
              ]))),
    );
  }

  _personaldetailbanner() {
    return Container(
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
            Color(0xffED816E),
            Color(0xffB93342),
          ]),
        ),
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(Strings.PERSONALDETAILBANNERTEXT,
              style: StringsStyle.personaldetailbannerstyle),
        ));
  }

  _editimagebody() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Update",
                  style: TextStyle(
                      color: AppColors.darktextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15)),
              SizedBox(height: 2),
              Text("Profile picture",
                  style: TextStyle(
                      color: AppColors.darktextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15)),
            ]),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      _showPicker(context);
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Obx(() => profileController.selectedImagePath.value==''
                          ?
                      // CircleAvatar(
                      //     radius: 75,
                      //     backgroundImage: NetworkImage(image),)
                      Stack(
                        children: [
                          CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.white,
                              child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/editprofile.png"))))),
                          Positioned(
                            left: 10,
                            right: 10,
                            top: 10,
                            bottom: 10,
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/images/upload.png")))),
                          )
                        ],
                      )
                          : ClipOval(
                          child: Image.file(File(profileController.selectedImagePath.value),
                            fit: BoxFit.cover,)),
                      ),
                    ),
                  ),
                ),
          ]),
        )
      ]),
    );
  }

  _editprofilebody() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
          key: _formKey,
          child: Column(children: [
            Container(
                // height: 50,
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
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Name",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) => value.isEmpty
                      ? 'Enter Your Name'
                      :RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)
                      ? 'Enter a Valid Name'
                      : null,
                )),
            SizedBox(
              height: 15,
            ),
            Container(
                // height: 50,
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
                  controller: _mobile,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Mobile number",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please, enter your mobile number";
                    }
                    if (value.trim().length < 10) {
                      return "Mobile number have must be atleast 10 digits";
                    }
                    return null;
                  },
                )),
            SizedBox(height: 15),
            getProfileData.email.isEmpty?
            Container(
                // height: 50,
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
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Email Id",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",
                ))
            : Container(
              height: 50,
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
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(getProfileData.email,),
              ),
            ),
            SizedBox(height: 15),
            Container(
                height: 50,
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
              child: Center(
                child: DropdownButton(
                  underline: SizedBox(),
                  iconSize: 20.0,
                  hint: Text('${gender.isEmpty?"Gender":gender}                                                                        ',
                    style: TextStyle(fontSize: 14,color: Colors.black),), // Not necessary for Option 1
                  value: _selectgen,
                  onChanged: (newValue) {
                    setState(() {
                      _selectgen = newValue;
                    });
                  },
                  items: _genders.map((type) {
                    return DropdownMenuItem(

                      child: new Text(type),

                      value: type,
                    );
                  }).toList(),
                ),
              ),
            ),
                // TextFormField(
                //   controller: _gender,
                //   keyboardType: TextInputType.text,
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   textAlignVertical: TextAlignVertical.bottom,
                //   decoration: InputDecoration(
                //     border: InputBorder.none,
                //     contentPadding:
                //         EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                //     errorBorder:
                //         new OutlineInputBorder(borderSide: BorderSide.none),
                //     labelText: "Gender",
                //     labelStyle: TextStyle(
                //       color: AppColors.lighttextColor,
                //       fontSize: 14,
                //     ),
                //   ),
                //   validator: (value) {
                //     if (value.trim().isEmpty) {
                //       return "Please, enter your gender";
                //     }
                //
                //     return null;
                //   },
                // )),
            SizedBox(height: 15),
            Container(
              height: 50,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: GestureDetector(
                  onTap:() => _selectDate(context),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(formatDate ?? dob,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black
                            ),),
                        ),
                        const Icon(Icons.keyboard_arrow_down_sharp)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
                // height: 50,
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
                  controller: _blood,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Blood Group",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please, enter your blood group";
                    }
                    return null;
                  },
                )),
            SizedBox(height: 15),
            Container(
                // height: 50,
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
                  controller: _materialstatus,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: Strings.MARITALSTATUS,
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please, enter your marital status";
                    }
                    return null;
                  },
                )),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    // height: 50,
                    width: Get.width / 2.3,
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
                      controller: _height,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        errorBorder:
                            new OutlineInputBorder(borderSide: BorderSide.none),
                        labelText: "Height",
                        labelStyle: TextStyle(
                          color: AppColors.lighttextColor,
                          fontSize: 14,
                        ),
                      ),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return "Please, enter your height";
                        }

                        return null;
                      },
                    )),
                Container(
                    // height: 50,
                    width: Get.width / 2.3,
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
                      controller: _weight,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        errorBorder:
                            new OutlineInputBorder(borderSide: BorderSide.none),
                        labelText: "Weight",
                        labelStyle: TextStyle(
                          color: AppColors.lighttextColor,
                          fontSize: 14,
                        ),
                      ),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return "Please, enter your weight";
                        }

                        return null;
                      },
                    )),
              ],
            ),
            SizedBox(height: 15),
            Container(
                // height: 50,
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
                  controller: _alternetnumber,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Emergency Contact",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please, enter your emergency contact";
                    }
                    if (value.trim().length < 10) {
                      return "Mobile number have must be atleast 10 digits";
                    }
                    return null;
                  },
                )),
            SizedBox(height: 15),
            Container(
                // height: 50,
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
                  controller: _address,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Location",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please, enter your location";
                    }

                    return null;
                  },
                )),
            SizedBox(height: 30),
            if(_isLoad)
              CircularProgressIndicator()
            else Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      _updateprofile();
                    }
                  },
                  child: CustomButton(
                      text1: "",
                      text2: "Save Changes",
                      width: Get.width,
                      height: 50)),
            ),
          ])),
    );
  }
}

void _showPicker(context) {

  final signupController = Get.put(ProfileController());

  showModalBottomSheet(
    // enableDrag: false,
      isDismissible: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_camera,
                      size: 35,),
                    title: new Text('Camera',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),),
                    onTap: () {
                      signupController.getImage(ImageSource.camera,context);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_library,
                    size: 35,),
                  title: new Text('Gallery',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),),
                  onTap: () {
                    signupController.getImage(ImageSource.gallery,context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
  );



}