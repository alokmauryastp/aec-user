import 'dart:convert';
import 'dart:io';
import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class MedicalRecordsAddController extends GetxController {
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  late File file;
  void getImage(ImageSource imageSource,BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile!=null) {
      selectedImagePath.value = pickedFile.path;
      file = new File(pickedFile.path);
      selectedImageSize.value = ((File(selectedImagePath.value)).lengthSync()/1024/1024).toStringAsFixed(2)+"Mb";
      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = base64.encode(imageBytes);
      await SharedPrefManager.savePrefString(AppConstant.BASE64IMAGE, base64Image);
     // await Provider.of<MedicalRecordRepo>(context,listen: false).addMedicalRecardApi(base64Image);
    }else {
      Get.snackbar("Error",
          "No image selected",);
    }
  }
}
