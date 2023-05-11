// @dart=2.9
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/model/courseModel/mycoursesModel/videos_model.dart';
import 'package:aec_medical/pages/dashboard/consultation/medical_history_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:get/get.dart' as gets;


import '../bottom_navigation_bar_page.dart';

class ConsultationVideoPage extends StatefulWidget {
  @override
  _ConsultationVideoPageState createState() => _ConsultationVideoPageState();
}

class _ConsultationVideoPageState extends State<ConsultationVideoPage> {



  // String url = Get.arguments;
  String url = "https://apolloeclinic.com/apollo_e_clinic/uploads/course_video/2f5c8a3054e54ba324576af38281e576.mp4";

  FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
      VideoPlayerController.network(url),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: AppColors.appbarbackgroundColor,
      //   centerTitle: true,
      //   title: Text(videosData.title,
      //     style: StringsStyle.pagetitlestyle,
      //   ),
      //   leading: IconButton(
      //       onPressed: () {
      //         Get.back();
      //       },
      //       icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            _skipbutton(),
            Expanded(
              flex: 8,
              child: Center(
                child: Container(
                  height: 200,
                  child: VisibilityDetector(
                    key: ObjectKey(flickManager),
                    onVisibilityChanged: (visibility) {
                      if (visibility.visibleFraction == 0 && this.mounted) {
                        flickManager.flickControlManager?.autoPause();
                      } else if (visibility.visibleFraction == 1) {
                        flickManager.flickControlManager?.autoResume();
                      }
                    },

                    child: FlickVideoPlayer(
                      flickManager: flickManager,
                      flickVideoWithControlsFullscreen: FlickVideoWithControls(
                        controls: FlickLandscapeControls(),
                        videoFit: BoxFit.fitWidth,
                        willVideoPlayerControllerChange: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _skipbutton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        alignment: Alignment.topRight,
        child: FlatButton(
            onPressed: () {
              gets.Get.offAll(
              BottomNavigationBarPage(),
                  transition: Transition.rightToLeftWithFade,
                  duration: Duration(milliseconds: 600));
            },
            child: Text("skip",style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: AppColors.blueColor),)),
      ),
    );
  }
}
