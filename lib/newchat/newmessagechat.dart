// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/chat_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:file/local.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewMessagesChat extends StatefulWidget {
  @override
  _NewMessagesChatState createState() => _NewMessagesChatState();
}

class _NewMessagesChatState extends State<NewMessagesChat> {
  bool isTyppingStart = false;
  bool show = false;
  FocusNode focusNode = FocusNode();
  LocalFileSystem localFileSystem = LocalFileSystem();
  File filename;
  File newFile;
  PlatformFile file;
  var _enteredMessage = '', base64Image = '';

  final controller = new TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    setState(() {
      Provider.of<ChatRepo>(context, listen: false).saveDoctorChatMessageApi(
          controller.text, base64Image.isEmpty ? '' : base64Image);
      filename =null;
    });
    controller.clear();
  }

  void onFileOpen() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );
    if (result != null) {
      file = result.files.first;
      filename = File(file.path);

      setState(() {
        newFile = filename;
      });
      List<int> imageBytes = newFile.readAsBytesSync();
      base64Image = base64.encode(imageBytes);
    }
  }

  @override
  void initState() {
    super.initState();
    // _init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.1),
      margin: EdgeInsets.only(top: 3),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          filename != null
              ? Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children:[
                      Image.file(
                        filename,
                        width: MediaQuery.of(context).size.width-15,
                        height: 250,
                        errorBuilder: (context, error, stackTrace) {
                          return Text("");
                        },
                      ),
                      Positioned(right: 4,top: 0,
                        child: Container(alignment: Alignment.topRight,height: 40,width:40,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                          child: IconButton(alignment: Alignment.center,
                              color: Theme.of(context).primaryColor,
                              icon: Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                              ),
                              onPressed: (){
                            setState(() {
                              filename=null;
                            });
                              }),
                        ),
                      ),]
                  ),
                ],
              )
              : SizedBox(height: 0,),
          Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 4, bottom: 4),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Type a message...',
                              border: InputBorder.none),
                          controller: controller,
                          onChanged: (value) {
                            // setState(() {
                            _enteredMessage = value;
                            // });
                          },
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 40,
                        child: Center(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  onFileOpen();
                                },
                                icon: Icon(
                                  Icons.attach_file_rounded,
                                  color: Colors.grey,
                                  size: 26,
                                ),
                              ),
                              // IconButton(
                              //   onPressed: (){
                              //     onFileOpen();
                              //   },
                              //   icon: Icon(
                              //     Icons.camera_alt_rounded,
                              //     color: Colors.grey,
                              //     size: 26,),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 4,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 24,
                          child: IconButton(
                              color: Theme.of(context).primaryColor,
                              icon: Icon(
                                Icons.send_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: _sendMessage),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
