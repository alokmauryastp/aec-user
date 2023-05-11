// @dart=2.9
import 'dart:async';
import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/chat_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/model/consultationModel/chatModel/getchat_model.dart';
import 'package:aec_medical/newchat/newmessagechat.dart';
import 'package:aec_medical/pages/dashboard/drawer/help/add_feedback_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'newmessagebubble.dart';

class ChatScreenNew extends StatefulWidget {
  // final String name;
  // ChatScreenNew({this.name})
  @override
  _ChatScreenNewState createState() => _ChatScreenNewState();
}

class _ChatScreenNewState extends State<ChatScreenNew> {
  StreamController<List<GetChatData>> _controller =
      StreamController<List<GetChatData>>.broadcast();
  var doctorname = Get.arguments;

  var id;
  final controller = new TextEditingController();
  Timer timer;
  Future future;
  final ScrollController _scrollController = ScrollController();

  /*void userId() async{
    id = await SharedPrefManager.getPrefrenceString(AppConstant.USERID);
    print("idsssss"+id);
  }*/

  @override
  void initState() {
    super.initState();
    // loadDetails();
    // userId();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin(),
        onConferenceJoined: _onConferenceJoined(),
        onConferenceTerminated: _onConferenceTerminated(),
        onPictureInPictureWillEnter: _onPictureInPictureWillEnter(),
        onPictureInPictureTerminated: _onPictureInPictureTerminated(),
        onError: _onError()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer.periodic(Duration(seconds: 5), (_) => loadDetails());
    });

    if (doctorname[0] != 'Chat') {
      _joinMeeting();
    }

    // _scrollController.addListener(() {_scrollDown();});
    _scrollDown();
  }

  loadDetails() async {
    future = Provider.of<ChatRepo>(context, listen: false).getChatApi();
    future.then((response) async {
      _controller.add(response);
      return response;
    });
  }

  @override
  void dispose() {
    _controller.close();
    controller.dispose();
    JitsiMeet.closeMeeting();
    super.dispose();
  }

  _joinMeeting() async {
    await SharedPrefManager.savePrefString(
        AppConstant.VIDEOURL, doctorname[1].toString());

    await SharedPrefManager.savePrefString(
        AppConstant.DOCTORNAME, doctorname[0].toString());

    String videourl =
        await SharedPrefManager.getPrefrenceString(AppConstant.VIDEOURL);
    String doctor =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORNAME);
    String user = await SharedPrefManager.getPrefrenceString(AppConstant.NAME);

    // videourl = 'https://meet.aarasocial.com/467497569720717';
    print("videourl");
    print(videourl);

    var ss = videourl.split('/');
    String room = ss.removeLast();
    String host = ss.last;
    // Fluttertoast.showToast(msg: 'join meet');
    try {
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
        FeatureFlagEnum.CHAT_ENABLED: false,
        FeatureFlagEnum.CALL_INTEGRATION_ENABLED: false,
        FeatureFlagEnum.INVITE_ENABLED: false,
        FeatureFlagEnum.RECORDING_ENABLED: false,
        FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
        FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
      };

      if (!host.contains('http')) {
        host = 'https://' + host;
        print(host);
      }

      var options = JitsiMeetingOptions(room: room)
        // ..room = "myroom" // Required, spaces will be trimmed
        ..serverURL = host
        ..subject = "Meeting with $doctor"
        ..userDisplayName = user
        ..userEmail = "myemail@email.com"
        ..userAvatarURL = "https://someimageurl.com/image.ejpg" // or .png
        ..audioOnly = true
        ..audioMuted = false
        ..videoMuted = true
        ..featureFlags = featureFlags;
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  _onError({error}) {
    debugPrint("_onError broadcasted");
  }

  _onPictureInPictureWillEnter({message}) {
    debugPrint(
        "_onPictureInPictureWillEnter broadcasted with message: $message");
  }

  _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted");
  }

  _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted");
  }

  _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted");
  }

  _onPictureInPictureTerminated({message}) {
    debugPrint(
        "_onPictureInPictureTerminated broadcasted with message: $message");
    JitsiMeet.closeMeeting();
  }

  void _scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  support() {
    Get.bottomSheet(
      Container(
          height: 200,
          color: AppColors.backgroundColor,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.contact_support_outlined,
                    size: 20,
                    color: AppColors.appbarbackgroundColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Contact us", style: TextStyle(color: Colors.black)),
                ],
              ),
              Text(
                "For any Query connect\n with us",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.darktextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      _sendMail('apolloeclinic@gmail.com');
                    },
                    child: Container(
                      width: 120,
                      height: 40,
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
                          AppColors.appbarbackgroundColor,
                          AppColors.appbarbackgroundColor,
                        ]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Mail us",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      _makePhoneCall('tel:9414600141');
                    },
                    child: Container(
                      width: 120,
                      height: 40,
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
                          AppColors.appbarbackgroundColor,
                          AppColors.appbarbackgroundColor,
                        ]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Call us",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
      isDismissible: true,
      enableDrag: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(doctorname[0].toString()),
          elevation: 0.0,
          backgroundColor: AppColors.appbarbackgroundColor,
          centerTitle: true,
          actions: [
            InkWell(
                onTap: () async {
                  // _joinMeeting();

                  // if (await canLaunch(videourl)) {
                  //   await launch(videourl, forceWebView: true,enableJavaScript: true);
                  // } else {
                  //   throw 'Could not launch $videourl';
                  // }
                },
                child: Text("")
                // Icon(Icons.call)
                ),
            if (doctorname[0] == "Chat")
              SizedBox()
            else
              PopupMenuButton<int>(
                color: Colors.white,
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      value: 3,
                      child: InkWell(
                          onTap: () async {
                            loadDetails();
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Refresh",
                            style: TextStyle(color: Colors.black),
                          ))),
                  PopupMenuItem<int>(
                      value: 1,
                      child: InkWell(
                          onTap: () async {
                            String profile =
                                await SharedPrefManager.getPrefrenceString(
                                    AppConstant.PROFILE);
                            var rating =
                                await SharedPrefManager.getPrefrenceString(
                                    AppConstant.RATING);
                            String disease =
                                await SharedPrefManager.getPrefrenceString(
                                    AppConstant.DISEASE);
                            Get.to(AddFeedbackPage(),
                                arguments: [
                                  profile,
                                  rating,
                                  doctorname[0],
                                  disease
                                ],
                                transition: Transition.rightToLeftWithFade,
                                duration: Duration(milliseconds: 600));
                          },
                          child: Text(
                            "Rate us",
                            style: TextStyle(color: Colors.black),
                          ))),
                  PopupMenuItem<int>(
                      value: 2,
                      child: InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                            support();

                            // showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return Dialog(
                            //         child: Container(
                            //           height: 200,
                            //           child: Padding(
                            //             padding:
                            //                 const EdgeInsets.only(left: 18.0),
                            //             child: Column(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.center,
                            //               children: [
                            //                 InkWell(
                            //                   onTap: () {
                            //                     _makePhoneCall('tel:9414600141');
                            //                   },
                            //                   child: Row(
                            //                     children: [
                            //                       IconButton(
                            //                           onPressed: () {},
                            //                           icon: Icon(
                            //                             Icons.call,
                            //                             size: 40,
                            //                             color: Colors.blueAccent,
                            //                           )),
                            //                       Text(
                            //                         "   Call",
                            //                         style: TextStyle(
                            //                             letterSpacing: 1,
                            //                             fontSize: 20,
                            //                             fontWeight:
                            //                                 FontWeight.w500),
                            //                       )
                            //                     ],
                            //                   ),
                            //                 ),
                            //                 InkWell(
                            //                   onTap: () {
                            //                     _sendMail(
                            //                         'apolloeclinic@gmail.com');
                            //                   },
                            //                   child: Row(
                            //                     children: [
                            //                       IconButton(
                            //                           onPressed: () {},
                            //                           icon: Icon(
                            //                             Icons.email,
                            //                             size: 40,
                            //                             color: Colors.blueAccent,
                            //                           )),
                            //                       Text(
                            //                         "   Email",
                            //                         style: TextStyle(
                            //                             letterSpacing: 1,
                            //                             fontSize: 20,
                            //                             fontWeight:
                            //                                 FontWeight.w500),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     });
                          },
                          child: Text(
                            "Support",
                            style: TextStyle(color: Colors.black),
                          ))),
                ],
              )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<ChatRepo>(context).getChatApi(),
                  builder: (ctx, futureSnapShots) {
                    if (futureSnapShots.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (futureSnapShots.hasData) {
                        return StreamBuilder(
                          stream: _controller.stream,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<GetChatData>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Center(
                                  child: Text('None'),
                                );
                                break;
                              case ConnectionState.waiting:
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                                break;
                              case ConnectionState.active:
                                if (snapshot.hasData) {
                                  List<GetChatData> responseChat = snapshot.data;
                                  return ListView.builder(
                                      reverse: false,
                                      controller: _scrollController,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (ctx, index) =>
                                          NewMessageBubble(
                                              responseChat[index].message,
                                              responseChat[index].user,
                                              responseChat[index].userType,
                                              responseChat[index].patientName,
                                              responseChat[index]
                                                  .image
                                                  .toString(),
                                              responseChat[index].time));
                                }
                                break;
                              case ConnectionState.done:
                                print('Done data is here ${snapshot.data}');
                                if (snapshot.hasData) {
                                  return Center(
                                      child: Text("No messages are available"));
                                } else if (snapshot.hasError) {
                                  return Text('Has Error');
                                } else {
                                  return Text('Error');
                                }
                                break;
                            }
                            return Text('Non in Switch');
                          },
                        );
                      } else {
                        return Text("");
                        return Center(
                          child: Text(
                            "No messages are there",
                            style: TextStyle(
                                fontFamily: "Proxima Nova",
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    20 * MediaQuery.of(context).textScaleFactor),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              if (doctorname[0] == "Chat") SizedBox() else NewMessagesChat(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendMail(email) async {
    // Android and iOS
    var uri = 'mailto:' + email + '?subject=hello&body=Hello';
    print('mailto: $email ?subject=hello&body=Hello');
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      Fluttertoast.showToast(
        msg: "Can't Launch!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
      throw 'Could not launch $uri';
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
}
