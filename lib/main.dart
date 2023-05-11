// @dart=2.9

import 'dart:async';
import 'package:aec_medical/api/repository/chat_repo.dart';
import 'package:aec_medical/api/repository/consultation_repo.dart';
import 'package:aec_medical/api/repository/counselling_repo.dart';
import 'package:aec_medical/api/repository/courses_repo.dart';
import 'package:aec_medical/api/repository/medicalrecord_repo.dart';
import 'package:aec_medical/api/repository/profile_repo.dart';
import 'package:aec_medical/pages/dashboard/AcceptPage.dart';
import 'package:aec_medical/pages/splash/splash_page.dart';
import 'package:aec_medical/service/routes_generator.dart';
import 'package:aec_medical/service/service_locator.dart';
import 'package:connectycube_flutter_call_kit/connectycube_flutter_call_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ringtone_player/ringtone_player.dart';
import 'api/sharedprefrence.dart';
import 'newchat/newchatscreen.dart';
import 'pages/dashboard/bottom_navigation_bar_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart' as gets;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print('_firebaseMessagingBackgroundHandler');
  // message.notification.
  print(message.messageId);
  print(message.notification.body);
  print(message.notification.title);
  print(message.data.toString());
  print(message.data["doctor"]);
  print(message.data["url"]);
  RingtonePlayer.ringtone();

  // {doctor: amritesh, icon: https://apolloeclinic.com/apollo_e_clinic/assets/images/logo/mono.png, url: https://meet.aarasocial.com/467497569720717}

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'big text channel name',
    'big text channel name',
    // 'big text channel description',
    // styleInformation: bigPictureStyleInformation,
    icon: '@mipmap/ic_launcher',
    color: const Color.fromARGB(255, 255, 0, 0),
    ledColor: const Color.fromARGB(255, 255, 0, 0),
    ledOnMs: 1000,
    ledOffMs: 500,
    playSound: true,
    enableVibration: true,
    importance: Importance.high,
    priority: Priority.max,
    enableLights: true,
    // sound:'ringtone',
    sound: RawResourceAndroidNotificationSound('ringtone'),
  );

  // flutterLocalNotificationsPlugin.show(
  // message.notification.hashCode,
  // message.notification.title,
  // message.notification.body,
  //     NotificationDetails(
  //       android:androidPlatformChannelSpecifics,
  //     ),payload: message.data.toString()
  // );

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  // final initializationSettings = InitializationSettings(
  //     // android: initializationSettingsAndroid,
  //     android: androidPlatformChannelSpecifics,
  //     );

  // await flutterLocalNotificationsPlugin.initialize(
  //   initializationSettings,
  //   onSelectNotification: selectNotification,
  // );

  ///Not able to stop default notification
  ///there fore when custom notification is called
  ///result is 2 notifications displayed.

  // NotificationDetails _notificationDetails;
  // _notificationDetails = await customNotification(message: message);
  // flutterLocalNotificationsPlugin.show(
  //   message.notification.hashCode,
  //   message.notification.title,
  //   message.notification.body,
  //   _notificationDetails,
  //   payload: '',
  // );

  // await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');

  ConnectycubeFlutterCallKit.clearCallData(sessionId: '121212');


  showNotification(message);
  // goToChat(message);
}

void showNotification(RemoteMessage message) {
  Set<int> gfg2 = {1, 2, 3};
  // P2PCallSession incomingCall; // the call received somewhere
  CallEvent callEvent = CallEvent(
      sessionId: '121212',
      callType: 0,
      callerId: 12,
      callerName: message.data["doctor"],
      opponentsIds: gfg2,
      userInfo: {
        'doctor': message.data["doctor"],
        'url': message.data["url"],
        'consultid': message.data["consultid"],
      });

  ConnectycubeFlutterCallKit.instance.init(
      onCallAccepted: _onCallAccepted,
      onCallRejected: _onCallRejected
  );

  ConnectycubeFlutterCallKit.instance.updateConfig( icon: 'logo');
  ConnectycubeFlutterCallKit.showCallNotification(callEvent);
  ConnectycubeFlutterCallKit.clearCallData(sessionId: '121212');
  ConnectycubeFlutterCallKit.initEventsHandler();

}

Future<void> _onCallAccepted(CallEvent callEvent) async {
  print('_onCallAccepted');
  RingtonePlayer.stop();
  print(callEvent.userInfo["doctor"]);
  print(callEvent.userInfo["url"]);
  print(callEvent.userInfo["consultid"]);
  Get.to(
    ChatScreenNew(),
    arguments: [
      callEvent.userInfo["doctor"],
      callEvent.userInfo["url"],
      callEvent.userInfo["consultid"]
    ],
  );
  // the call was accepted
}

Future<dynamic> onCallAcceptedWhenTerminated(CallEvent callEvent) async {

  RingtonePlayer.stop();
  print('onCallAcceptedWhenTerminated');
  print(callEvent.userInfo["doctor"]);
  print(callEvent.userInfo["url"]);
  print(callEvent.userInfo["consultid"]);
  Get.to(
    ChatScreenNew(),
    arguments: [
      callEvent.userInfo["doctor"],
      callEvent.userInfo["url"],
      callEvent.userInfo["consultid"]
    ],
  );
  // the call was accepted
}
Future<dynamic> onCallRejectedWhenTerminated(CallEvent callEvent) async {

  RingtonePlayer.stop();
  print('onCallAcceptedWhenTerminated');
  print(callEvent.userInfo["doctor"]);
  print(callEvent.userInfo["url"]);
  print(callEvent.userInfo["consultid"]);
  // the call was accepted
}

Future<void> _onCallRejected(CallEvent callEvent) async {
  RingtonePlayer.stop();
  print('call rejected!');
  // the call was rejected
}

void main() async {
  Get.testMode = true;
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RingtonePlayer.notification();
    //when application open

    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;
    // AndroidNotificationSound sound = new AndroidNotificationSound();

    // showSimpleNotification(
    //   Container(child: Text(notification.body)),
    //   position: NotificationPosition.top,
    // );

    print("opening chat onMessage");

    print(message.messageId);
    print(message.notification.body);
    print(message.notification.title);
    print(message.data.toString());
    print(message.data["doctor"]);
    print(message.data["url"]);

    if (notification != null && android != null) {
      var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      // final androidNotificationSound = AndroidNotificationSound();

      final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel name',
        'big text channel name',
        // 'big text channel description',
        // styleInformation: bigPictureStyleInformation,
        icon: '@mipmap/ic_launcher',
        color: const Color.fromARGB(255, 0, 255, 0),
        ledColor: const Color.fromARGB(255, 0, 255, 0),
        ledOnMs: 1000,
        ledOffMs: 500,
        playSound: true,
        enableVibration: true,
        importance: Importance.high,
        priority: Priority.max,
        enableLights: true,
        // sound:'ringtone',
        sound: RawResourceAndroidNotificationSound('ringtone'),
      );

      // flutterLocalNotificationsPlugin.show(
      //     notification.hashCode,
      //     notification.title,
      //     notification.body,
      //     NotificationDetails(
      //       android: androidPlatformChannelSpecifics,
      //     ));

      // showSimpleNotification(
      //   Text("Subscribe to FilledStacks"),
      //   background: Colors.purple,
      //   autoDismiss: false,
      //   trailing: Builder(builder: (context) {
      //     return FlatButton(
      //         textColor: Colors.yellow,
      //         onPressed: () {
      //           OverlaySupportEntry.of(context).dismiss();
      //         },
      //         child: Text('Dismiss'));
      //   }),
      // );
      goToChat(message);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //on notification tap
    print("opening chat onMessageOpenedApp");
    print(message.data.toString());
    print(message.data["doctor"]);
    print(message.data["url"]);
    print('A new onMessageOpenedApp event was published!');

    goToChat(message);
  });

  ConnectycubeFlutterCallKit.instance.updateConfig( icon: 'logo');

  ConnectycubeFlutterCallKit.onCallRejectedWhenTerminated = onCallRejectedWhenTerminated;
  ConnectycubeFlutterCallKit.onCallAcceptedWhenTerminated = onCallAcceptedWhenTerminated;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  ConnectycubeFlutterCallKit.setOnLockScreenVisibility(isVisible: true);

  Widget _default = new MyApp();
  bool status = await SharedPrefManager.getBooleanPreferences() != null;

  if (status == true) {
    _default = BottomNavigationBarPage();
  }

  initializeService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProfileRepo(),
        ),
        ChangeNotifierProvider(
          create: (_) => CoursesRepo(),
        ),
        ChangeNotifierProvider(
          create: (_) => ConsultationRepo(),
        ),
        ChangeNotifierProvider(
          create: (_) => MedicalRecordRepo(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatRepo(),
        ),
        ChangeNotifierProvider(
          create: (_) => CounsellingRepo(),
        ),
      ],
      child: Consumer<ProfileRepo>(
          builder: (ctx, auth, _) => GetMaterialApp(
                onGenerateRoute: (RouteSettings settings) =>
                    RouteGenerator.generateRoute(settings),
                theme: ThemeData(fontFamily: GoogleFonts.karla().fontFamily),
                debugShowCheckedModeBanner: false,
                home: _default,
              )),
    ),
  );
}

void goToChat(RemoteMessage message) {
  // locator.registerLazySingleton<NavigationService>(() => NavigationService());
  // final NavigationService navigationService = locator<NavigationService>();
  // navigationService.navigateTo(routes.ChatScreen,arguments:[
  //             message.data["doctor"],
  //             message.data["url"],
  //             message.data["consultid"]
  //           ] );
  if (!message.data["screen"].toString().isBlank) {
    gets.Get.to(AcceptPage(),
        arguments: [
          message.data["doctor"],
          message.data["url"],
          message.data["consultid"]
        ],
        transition: Transition.rightToLeftWithFade,
        duration: Duration(milliseconds: 600));
  }
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.setNotificationInfo(title: "",content: "");
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will executed when app is in foreground or background in separated isolate
      onStart: onStart,
      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,
      // this will executed when app is in foreground in separated isolate
      onForeground: onStart,
      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}

void onStart() {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  service.onDataReceived.listen((event) {
    if (event["action"] == "setAsForeground") {
      print("1" + event["action"]);
      service.setForegroundMode(true);
      return;
    }

    if (event["action"] == "setAsBackground") {
      print("2" + event["action"]);
      service.setForegroundMode(false);
    }

    if (event["action"] == "stopService") {
      print("3" + event["action"]);
      service.stopBackgroundService();
    }
  });

  // bring to foreground
  service.setForegroundMode(true);
  Timer.periodic(Duration(seconds: 1), (timer) async {
    if (!(await service.isServiceRunning())) timer.cancel();
    // ConsultationRepo consultationRepo = new ConsultationRepo();
    // Future future = consultationRepo.myConsultationApi();

    // locator.registerLazySingleton<NavigationService>(() => NavigationService());
    // final NavigationService navigationService = locator<NavigationService>();
    // if (!GetIt.I.isRegistered<NavigationService>()) {
    //   print("Trying to register navigator");
    //   GetIt.I.registerLazySingleton<NavigationService>(() => NavigationService());
    // }
    // navigationService.navigateTo(routes.ChatScreen);

    // service.setNotificationInfo(
    //   title: "My App Service",
    //   content: "Updated at ${DateTime.now()}",
    // );
    // service.sendData(
    //   {"current_date": DateTime.now().toIso8601String()},
    // );
  });
}

// to ensure this executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
void onIosBackground() {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) =>
          RouteGenerator.generateRoute(settings),
      home: Scaffold(
        body: SplashPage(),
      ),
    );
  }
}

// AAAA0v-fjfY:APA91bGLxPRrj5BVnwTpVlznRDINxRg268b563fty9h8PuKYecuZA2BIaERHASsdS7S7y01APJlKZxpmXWp5P5DknSLWdnYd8tFq87NdWphwWcjvxOvDcaR-zq5J01pkzGOTgxdYVmfV

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
