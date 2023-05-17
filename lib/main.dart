import 'dart:io';

import 'package:faced/registering.dart';
import 'package:faced/sample.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'module/Dashboard/ui/dashboard.dart';
import 'package:camera/camera.dart';
import 'package:faced/recognized_auto.dart';
import 'module/Image_Registation/ui/camera_screen.dart';
import 'recogniced2/Ui/recognize_screen.dart';   



SharedPreferences? sharedPrefrence;
late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //HttpOverrides.global=MyHttpOverrides();
  cameras = await availableCameras();
  sharedPrefrence = await SharedPreferences.getInstance();
  bool? islogin = sharedPrefrence!.containsKey('Face_isLogin')
      ? sharedPrefrence!.getBool('Face_isLogin')
      : false;

  runApp(MyApp(
    islogin: islogin,
  ));
}

class MyApp extends StatelessWidget {
  bool? islogin;
  // File? images;
  // String? name;
  MyApp({
    super.key,
    this.islogin,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: islogin! ? DashboardScreen() : CameraScreen(),
      home: RecognizeScreen(),
    );
  }
}
