import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Views/CreateAccount/index.dart';
import 'package:soloconneckt/Views/Interests/menuDropDown.dart';
import 'package:soloconneckt/Views/NewsFeed/index.dart';
import 'Controllers/globalBinding.dart';
import 'dart:async';
import 'dart:io';

import 'Styles/theme.dart';
import 'Views/NewsFeed/swipeCard.dart';
import 'Views/Nfc.dart';
import 'Views/NfcDashboard/pages/webViewPage/index.dart';
import 'Views/QrCode/index.dart';
import 'Views/SplashScreen/index.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future<void> main() async {
   GlobalBindings().dependencies();

     WidgetsFlutterBinding.ensureInitialized();
  // await Permission.camera.request();
  // await Permission.microphone.request();
  // await Permission.storage.request();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      ));
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String usename = "", email = "", image = "";
  int id = 0;
  String islogin = "No";
  bool isloading=true;
  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("is_logged_in"));
    usename = prefs.getString("user_name")!;
    email = prefs.getString("user_email") != null
        ? prefs.getString("user_email")!
        : "";
    // image = prefs.getString("image")!;
    id = int.parse(prefs.getString("user_id")!);
    islogin = prefs.getString("is_logged_in")!;
    isloading=false;
    setState(() {});
  }
  @override
  void initState() {
    addStringToSF();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Solo Conneckt',
      theme: Themes.light,
      // theme: ThemeData(
      //   fontFamily: "Poppins",
      // ),
      darkTheme: Themes.dark,
      //  themeMode: ThemeService().theme, 
      // home: MyApp(),
      home:
      // Home()
       islogin == "yes"? NewsFeed(): SplashScreen(),
    );
  }
}
