import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({Key? key}) : super(key: key);

  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {

   String vurl = Get.arguments;

  late InAppWebViewController _webViewController;

  Future webViewMethod() async {
    print('In Microphone permission method');
    //WidgetsFlutterBinding.ensureInitialized();

    await Permission.microphone.request();
    WebViewMethodForCamera();

  }
  Future WebViewMethodForCamera() async{
    print('In Camera permission method');
    //WidgetsFlutterBinding.ensureInitialized();
    await Permission.camera.request();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webViewMethod();
    WebViewMethodForCamera();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InAppWebView(
              initialUrlRequest: URLRequest(url:Uri.parse(vurl)),
            // initialUrl: "https://appr.tc/r/158489234",
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                mediaPlaybackRequiresUserGesture: false,
              ),
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              _webViewController = controller;
            },
            androidOnPermissionRequest: (
                InAppWebViewController controller, String origin,
                List<String> resources) async {
              return PermissionRequestResponse(resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            }
        )
    );
  } }