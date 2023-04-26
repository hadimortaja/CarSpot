import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_rental/core/controllers/app_controller.dart';
import 'package:car_rental/core/controllers/auth_controller.dart';
import 'package:car_rental/core/controllers/home_controller.dart';
import 'package:car_rental/core/controllers/profile_controllr.dart';
import 'package:car_rental/core/controllers/upload_ads_controller.dart';
import 'package:car_rental/core/services/dynamic_link.dart';
import 'package:car_rental/core/services/notification_firebase.dart';
import 'package:car_rental/core/services/sp_helper.dart';
import 'package:car_rental/core/services/translations/internationalization.dart';
import 'package:car_rental/core/value/colors.dart';
import 'package:car_rental/features/splash_view/presentation/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPHelper.spHelper.initSharedPrefrences();
  await Permission.camera.request();
  await Permission.storage.request();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Timer? _timerLink;

  @override
  void initState() {
    NotificationHelper().initialNotification();
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _timerLink = new Timer(
        const Duration(milliseconds: 1000),
        () {
          DynamicLinkService().retrieveDynamicLink();
        },
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    if (_timerLink != null) {
      _timerLink!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SPHelper.spHelper.setToken("");
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        Get.put(UploadAdsController());

        Get.put(AppController());
        Get.put(AuthController());
        Get.put(HomeController());

        Get.put(ProfileController());

        return GetMaterialApp(
            title: "CAR SPOT",
            builder: BotToastInit(),
            navigatorObservers: [
              BotToastNavigatorObserver(),
            ],
            theme: ThemeData(
              fontFamily: "montserrat",
              scaffoldBackgroundColor: Color(0xffFBFBFB),
            ),
            defaultTransition: Transition.fadeIn,
            transitionDuration: Duration(milliseconds: 300),
            debugShowCheckedModeBanner: false,
            locale: InternationalizationService.getCurrentLocal(),
            fallbackLocale: InternationalizationService.getCurrentLocal(),
            translations: InternationalizationMessages(),
            localizationsDelegates: [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            // supportedLocales: [
            //   Locale('en', 'US'),
            // ],
            home: SplashView());
      },
    );
  }
}
