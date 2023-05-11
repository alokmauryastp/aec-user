// @dart=2.9
import 'dart:io';

import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/medicalrecord_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/controller/medical_record_add_controller.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MedicalRecordsPage extends StatefulWidget {
  @override
  _MedicalRecordsPageState createState() => _MedicalRecordsPageState();
}

class _MedicalRecordsPageState extends State<MedicalRecordsPage> {
  final _formKey = GlobalKey<FormState>();

  final medicalRecordsAddController = Get.put(MedicalRecordsAddController());

  TextEditingController  _diseasefield = new TextEditingController();
  TextEditingController  _descriptionfield = new TextEditingController();

  bool _isLoad = false;
  List<String> _type = ['Prescription','Lab Test','Other'];

  String filename="";


   String _selecttype;
   trySubmit()async{
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoad = true;
      });
      MedicalRecordRepo medicalRecordRepo = new MedicalRecordRepo();
      await medicalRecordRepo.addMedicalRecardApi(_selecttype,_diseasefield.text,_descriptionfield.text);
      setState(() {
        _isLoad = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appbarbackgroundColor,
        centerTitle: true,
        title: Text(
          Strings.MEDICALRECORDSTITLE,
          style: StringsStyle.pagetitlestyle,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(Strings.MEDICALHEADING,
                            style: StringsStyle.medicalheadingstyle),
                        SizedBox(
                          height: 10,
                        ),
                        Text(Strings.MEDICALSUBHEADING1,
                            style: StringsStyle.medicalsubheadingstyle),
                        Text(Strings.MEDICALSUBHEADING2,
                            style: StringsStyle.medicalsubheadingstyle),
                        SizedBox(height: 20,),
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
                          child: DropdownButton(
                            underline: SizedBox(),
                            iconSize: 20.0,
                            hint: Text('    Medical Record Type                                    ',
                              style: TextStyle(fontSize: 14,color: Colors.grey.shade600),), // Not necessary for Option 1
                            value: _selecttype,
                            onChanged: (newValue) {
                              setState(() {
                                _selecttype = newValue;
                              });
                            },
                            items: _type.map((type) {
                              return DropdownMenuItem(

                                child: new Text("   "+type),

                                value: type,
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 20,),
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
                            child: TextFormField(
                              controller: _diseasefield,
                              keyboardType: TextInputType.text,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                errorBorder:
                                new OutlineInputBorder(borderSide: BorderSide.none),
                                labelText: "Disease",
                                labelStyle: TextStyle(
                                  color: AppColors.lighttextColor,
                                  fontSize: 14,
                                ),
                              ),
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return "Please, enter your Disease";
                                }
                                return null;
                              },
                            )),
                        SizedBox(height: 20,),
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
                            child: TextFormField(
                              controller: _descriptionfield,
                              keyboardType: TextInputType.text,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                errorBorder:
                                new OutlineInputBorder(borderSide: BorderSide.none),
                                labelText: "Description",
                                labelStyle: TextStyle(
                                  color: AppColors.lighttextColor,
                                  fontSize: 14,
                                ),
                              ),
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return "Please, enter your Description";
                                }

                                return null;
                              },
                            )),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Obx(
                                () => medicalRecordsAddController
                                .selectedImagePath.value ==
                                ''
                                ?
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
                                    alignment: Alignment.centerLeft,
                                    child: Text("   Upload Medical Record",style:TextStyle(
                                      color: AppColors.lighttextColor,
                                      fontSize: 14,
                                    ) ,))
                                : Container(
                              height: 300,
                              child: Image.file(
                                File(medicalRecordsAddController
                                    .selectedImagePath.value),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    if(_isLoad)
                      CircularProgressIndicator()
                    else _addrecordbutton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _addrecordbutton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
       onTap: ()async {
          filename = await SharedPrefManager.getPrefrenceString(AppConstant.BASE64IMAGE);
          filename = filename.isNull?"":filename;
         if (filename.isEmpty) {
           Fluttertoast.showToast(msg: "Please select Document",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.CENTER,
               backgroundColor: Colors.black,
               textColor: Colors.white);
         } else {
           setState(() async{
            await trySubmit();
            await SharedPrefManager.savePrefString(AppConstant.BASE64IMAGE, "");
           // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MedicalRecordsPage()));
           });


         }
       },

         //  await SharedPrefManager.savePrefString(AppConstant.DISEASE, _diseasefield.text);
         // await SharedPrefManager.savePrefString(AppConstant.DESCRIPTION, _descriptionfield.text);

        child: CustomButton(
            text1: "", text2: "Add a record", width: Get.width, height: 50),
      ),
    );
  }
}

void _showPicker(context) {
  final signupController = Get.put(MedicalRecordsAddController());
  showModalBottomSheet(
      isDismissible: true,
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                Container(
                  child: Text(
                    "Add a record",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darktextColor,
                    ),
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 15),
                ),
                Center(
                  child: Container(
                    height: 2,
                    width: 95,
                    color: AppColors.appbarbackgroundColor,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                new ListTile(
                    leading: new Image.asset("assets/images/camera.png"),
                    title: new Text(
                      'Take A photo',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darktextColor,
                      ),
                    ),
                      onTap: () {
                      signupController.getImage(ImageSource.camera,context);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Image.asset("assets/images/image.png"),
                  title: new Text(
                    'Upload from Gallery',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darktextColor),
                  ),
                  onTap: () {
                    signupController.getImage(ImageSource.gallery,context);
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 5,),
              ],
            ),
          ),
        );
      });
}

