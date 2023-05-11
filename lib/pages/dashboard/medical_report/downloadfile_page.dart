import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFile extends StatefulWidget {
  @override
  State createState() {
    return _DownloadFileState();
  }
}

class _DownloadFileState extends State {
  var imageUrl = Get.arguments;
  bool downloading = true;
  String downloadingStr = "No data";
  String savePath = "";

  @override
  void initState() {
    super.initState();
    downloadFile();
  }

  Future downloadFile() async {
    try {
      Dio dio = Dio();
      String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
      savePath = await getFilePath(fileName);
      await dio.download(imageUrl, savePath, onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          // download = (rec / total) * 100;
          downloadingStr =
          "Downloading Image : $rec" ;
        });
      } );
      setState(() {
        downloading = false;
        downloadingStr = "Completed";
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getFilePath(uniqueFileName) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}/$uniqueFileName';
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
        // appBar: AppBar(
        //   backgroundColor: AppColors.appbarbackgroundColor,
        //   centerTitle: true,
        //   title: Text("Download Report",
        //     style: StringsStyle.pagetitlestyle,
        //   ),
        //   leading: IconButton(
        //       onPressed: () {
        //         Get.back();
        //       },
        //       icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
        //   // actions: [
        //   //   Padding(
        //   //     padding: const EdgeInsets.only(right: 10.0),
        //   //     child: Icon(Icons.more_vert,size: 25,color: Colors.white,),
        //   //   )
        //   // ],
        // ),
        body: Center(
          child: downloading
              ? Container(
            height: 300,
            width: Get.width,
            child: Card(
              color: AppColors.appbarbackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Downloading Image",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          )
              : Center(
                child: Image.file(
                  File(savePath),
                  height: 500,
                  width: Get.width,
                ),
              ),
        ),
      );
  }
}