import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:faced/main.dart';
import 'package:faced/module/Dashboard/ui/dashboard.dart';
import 'package:faced/module/Image_Registation/bloc/registationbloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:sharedpreference/sharedpreference.dart';
import 'dart:typed_data';

import '../../../SharedPreference/shared_preference.dart';
import '../../../api/api_calls.dart';
import '../../../base/HexColor.dart';
import '../../../base/base_response.dart';
import '../../../base/constants_color.dart';
import '../../../registering.dart';
import '../../../sample.dart';
import '../Bloc/recognize_bloc.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
// import 'camera_view.dart';
import 'camera_view.dart';
import 'face_detector_paint.dart';

class RecognizeScreen extends StatefulWidget {
  const RecognizeScreen({super.key});

  @override
  State<RecognizeScreen> createState() => _RecognizeScreenState();
}

class _RecognizeScreenState extends State<RecognizeScreen> {
  // late CameraController _controller;
  FaceDetector faceDetector =
      GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
  ));
  bool _canProcess = true;
  bool isBusy = false;
  CustomPaint? customPaint;
  String? _text;

  @override
  void dispose() {
    _canProcess = false;
    faceDetector.close();
    super.dispose();
    ApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: imageProfile(),
    );
  }

  Widget imageProfile() {
   return CameraView(
              customPaint: customPaint,
              onImage: (inputImage) {
                processImage(inputImage);
              },
              initialDirection: CameraLensDirection.front,
            );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (isBusy) return;
    isBusy = true;
    setState(() {
      _text = "";
    });
    final  faces = await faceDetector.processImage(inputImage);

   // Uint8List imagedata=await inputImage.inputImageData;

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null && faces.length!=0) {
      final painter = FaceDetectorPainter(
          faces[0],
          inputImage,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      customPaint = CustomPaint(painter: painter);


      // if(faces.length > 0)
      // sendImageToAPI(inputImage);

      // print("customPaint data ${customPaint}");
    } else {
      String text = 'face found ${faces.length}\n\n';
      for (final face in faces) {
        text += 'face ${face.boundingBox}\n\n';
      }
      _text = text;
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

 
}
