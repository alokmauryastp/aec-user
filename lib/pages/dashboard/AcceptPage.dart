import 'package:aec_medical/api/repository/chat_repo.dart';
import 'package:aec_medical/newchat/newchatscreen.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:provider/provider.dart';
import 'package:slider_button/slider_button.dart';
import 'package:get/get.dart' as gets;
import 'package:ringtone_player/ringtone_player.dart';


class AcceptPage extends StatefulWidget {
  const AcceptPage({Key? key}) : super(key: key);

  @override
  _AcceptPageState createState() => _AcceptPageState();
}

class _AcceptPageState extends State<AcceptPage> {
  // var audioManagerInstance = AudioManager.instance;

  var data = Get.arguments;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playRingtone();
  }
  playRingtone(){

    RingtonePlayer.ringtone();
    // AudioPlayer player = new AudioPlayer();
    // player.play();
    //test
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColors.appbarbackgroundColor,
      //   centerTitle: true,
      //   title: Text(
      //     "Calling...",
      //     style: StringsStyle.pagetitlestyle,
      //   ),
      //   leading: IconButton(
      //       onPressed: () {
      //         Get.back();
      //       },
      //       icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
      // ),
      body: Center(
        child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              CircleAvatar(
                radius: 100,
                child: Image.asset(
                  "assets/images/doctor.png",
                  height: 150,
                  width: 140,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Incoming Call...",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
              ),
              SizedBox(
                height: 30,
              ),
              SliderButton(
                width: 280,
                action: () {
                  ///Do something here
                  RingtonePlayer.stop();

                  Provider.of<ChatRepo>(context,listen: false).callingApi(data[2], 'call_accepted' );

                  gets.Get.off(ChatScreenNew(), arguments: data,
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 600));
                },
                label: Text(
                  "Slide left to accept call",
                  style: TextStyle(
                      color: Color(0xff4a4a4a),
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                icon: Center(
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 40.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ),
                // highlightedColor: Colors.red,
                buttonColor: Colors.green,
                // baseColor: Colors.amber,
              ),
              SizedBox(
                height: 20,
              ),
              SliderButton(
                width: 280,
                action: () {
                  RingtonePlayer.stop();
                  ///Do something here
                  Navigator.of(context).pop();
                  Provider.of<ChatRepo>(context,listen: false).callingApi(data[2], 'call_declined' );

  },
                label: Text(
                  "Slide left to decline call",
                  style: TextStyle(
                      color: Color(0xff4a4a4a),
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                icon: Center(
                  child: Icon(
                    Icons.call_end,
                    color: Colors.white,
                    size: 40.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ),
                buttonColor: Colors.red,
                // backgroundColor: Colors.green,
              ),
            ])),
      ),
    );
  }
}
