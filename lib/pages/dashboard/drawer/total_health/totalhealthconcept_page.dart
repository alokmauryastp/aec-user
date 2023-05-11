// @dart=2.9
import 'package:aec_medical/model/courseModel/mycoursesModel/videos_model.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class TotalHealthConceptPage extends StatefulWidget {
  @override
  _TotalHealthConceptPageState createState() => _TotalHealthConceptPageState();
}

class _TotalHealthConceptPageState extends State<TotalHealthConceptPage> {



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
      backgroundColor: Colors.black,
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
    );
  }
}
