

// // import 'package:camera/camera.dart';
// // import 'package:flutter/material.dart';

// // import 'dart:async';
// // import 'dart:io';
// // import 'dart:convert';
// // import 'package:awesome_dialog/awesome_dialog.dart';
// // import 'package:flutter_image_compress/flutter_image_compress.dart';
// // import 'package:faced/main.dart';
// // import 'package:faced/module/Dashboard/ui/dashboard.dart';
// // import 'package:faced/module/Image_Registation/bloc/registationbloc.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:http/http.dart' as http;

// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:gallery_saver/gallery_saver.dart';
// // import 'package:http/http.dart';
// // import 'package:image_picker/image_picker.dart';
// // //import 'package:sharedpreference/sharedpreference.dart';

// // import '../../../SharedPreference/shared_preference.dart';
// // import '../../../api/api_calls.dart';
// // import '../../../base/HexColor.dart';
// // import '../../../base/base_response.dart';
// // import '../../../base/constants_color.dart';
// // import '../../../registering.dart';
// // import '../../../sample.dart';
// // import '../Bloc/recognize_bloc.dart';

// // class RecognizeScreen extends StatefulWidget {
// //   const RecognizeScreen({super.key});

// //   @override
// //   State<RecognizeScreen> createState() => _RecognizeScreenState();
// // }

// // class _RecognizeScreenState extends State<RecognizeScreen> {
// //   RecognizeBloc adddataBloc = RecognizeBloc();
// //   FaceRecognization recogization = FaceRecognization();

// //   TextEditingController namecontroller = TextEditingController();
// //   File? image;
// //   var loading;
// //   int isActive = 1;
// //   int? statusCodes;
// //   int? faceId;
// //   final _formKey = GlobalKey<FormState>();
// //   //late SharedPreference logindata;
// //   late bool newuser;
// //   var NAME;

// //   String? basevar;
// //   late CameraController _controller;
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     _controller = CameraController(cameras[1], ResolutionPreset.max);
// //     _controller.initialize().then((_) {
// //       if (!mounted) {
// //         return;
// //       }
// //       setState(() {});
// //     }).catchError((Object e) {
// //       if (e is CameraException) {
// //         switch (e.code) {
// //           case 'CameraAccessDenied':
// //             print("access was denied");
// //             break;
// //           default:
// //             print(e.description);
// //             break;
// //         }
// //       }
// //     });

// //     adddataBloc.getrecognizestream.listen((event) async {
// //       switch (event.status) {
// //         case Status.LOADING:
// //           loading = await ApiCall().showLoaderDialog(context);
// //           break;
// //         case Status.COMPLETED:
// //           if (event.data!.status == 200) {
// //             statusCodes = event.data!.status;
// //             faceId = event.data!.faceID;

// //             print("faceId ${faceId}");
// //             if (faceId! > 0) {
// //               NAME = await recogization.fetchAlbum(faceId!);
// //             } else {
// //               NAME = "UNKNOWN";
// //             }

// //             print("waited string value in class.... ${recogization.username}");
// //             print("waited .... ${NAME}");

// //             //loading.dispose;
// //             statuscheck();

// //             print("Statuscodeeeeeeeeee${event.data!.status}");
// //           } else {
// //             print("This is not a status 200");
// //           }
// //           break;
// //         case Status.ERROR:
// //           break;
// //       }
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     super.dispose();
// //     ApiCall();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     double _deviceHeight = MediaQuery.of(context).size.height;
// //     double _deviceWidth = MediaQuery.of(context).size.width;
// //     print("w:${_deviceWidth}, H:${_deviceHeight}");

// //     return Scaffold(
// //       body: imageProfile(),
// //     );
// //   }

// //   pickImageC(XFile image) async {
// //     try {
// //       print("Image capture");
// //       if (image == null) {
// //         return ImageToast();
// //       }
// //       final bytes = await image.readAsBytes();
// //       print("Original size of image: ${bytes.lengthInBytes}");

// //       final compressedBytes = await FlutterImageCompress.compressWithList(
// //         bytes,
// //         minWidth: 500, // Change as needed
// //         minHeight: 500, // Change as needed
// //         quality: 70, // Change as needed
// //       );

// //       print("Compressed size of image: ${compressedBytes.length}");

// //       final imageTemp = File(image.path);
// //       await imageTemp.writeAsBytes(compressedBytes);
// //       setState(() => this.image = imageTemp);

// //       basevar = base64Encode(compressedBytes);

// //       var map = {
// //         "imagestring": basevar,
// //       };

     
// //       var body = jsonEncode(map);
// //       print("Request datt $body");
// //       adddataBloc.recognizeMethod(body);

// //       if (image != null && image.path != null) {
// //         setState(() {
// //           print("loading Image....");
// //         });
// //         GallerySaver.saveImage(image.path).then((imageTemp) {
// //           setState(() {
// //             print("Image Saved${image.path}");
// //           });
// //         });
// //       }
// //     } on PlatformException catch (e) {
// //       print('Failed to pick image: $e');
// //     }
// //   }

// //   Widget imageProfile() {
// //     return Stack(
// //       children: [
// //         Container(
// //           height: double.infinity,
// //           child: CameraPreview(_controller),
// //         ),
// //         Positioned(
// //           bottom: 10,
// //           left: MediaQuery.of(context).size.width / 3.4,
// //           child: Center(
// //             child: Container(
// //               margin: EdgeInsets.all(20.0),
// //               child: MaterialButton(
// //                 onPressed: () async {
// //                   if (!_controller.value.isInitialized) {
// //                     return null;
// //                   }
// //                   if (_controller.value.isTakingPicture) {
// //                     return null;
// //                   }

// //                   try {
// //                     await _controller.setFlashMode(FlashMode.auto);
// //                     XFile Picture = await _controller.takePicture();
// //                     pickImageC(Picture);
// //                   } on CameraException catch (e) {
// //                     debugPrint("Error occured while taking Picture: $e");
// //                     return null;
// //                   }
// //                 },
// //                 color: Colors.white,
// //                 child: Text("Take a Picture"),
// //               ),
// //             ),
// //           ),
// //         )
// //       ],
// //     );
// //   }

// //   showtoast() {
// //     Fluttertoast.showToast(
// //       msg: "Enter the name First",
// //       toastLength: Toast.LENGTH_LONG,
// //       gravity: ToastGravity.BOTTOM,
// //     );
// //   }

// //   ImageToast() {
// //     Fluttertoast.showToast(
// //       msg: "Select image First",
// //       toastLength: Toast.LENGTH_LONG,
// //       gravity: ToastGravity.BOTTOM,
// //     );
// //   }

// //   MinValueToast() {
// //     Fluttertoast.showToast(
// //       msg: "Enter Minimum Three Character",
// //       toastLength: Toast.LENGTH_LONG,
// //       gravity: ToastGravity.BOTTOM,
// //     );
// //   }

// //   statuscheck() {
// //     //ApiCall().dispose;

// //     //dispose().ApiCall();
// //     SharedPrefrence().setisLogin(true);
// //     SharedPrefrence().setIsName(namecontroller.text);
// //     SharedPrefrence().setProfileImage('');

// //     Fluttertoast.showToast(
// //       msg: "Recognized ${NAME}...",
// //       toastLength: Toast.LENGTH_LONG,
// //       gravity: ToastGravity.BOTTOM,
// //     );

// //     if (faceId == 0) {
// //       AwesomeDialog(
// //         context: context,
// //         dialogType: DialogType.warning,
// //         // animType: AnimType.bottomSlide,
// //         // showCloseIcon: true,
// //         title: "${NAME} Recognized ...",
// //       ).show();
// //     } else {
// //       AwesomeDialog(
// //         context: context,
// //         dialogType: DialogType.success,
// //         // animType: AnimType.bottomSlide,
// //         // showCloseIcon: true,
// //         title: "Recognized ${NAME}...",
// //       ).show();
// //     }

// //     myFunction();
// //   }

// //   Future<void> myFunction() async {
// //     print("Function started");

// //     // Wait for 10 seconds
// //     await Future.delayed(Duration(seconds: 10));

// //     await Navigator.push(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => RegisterButtonScreen(),
// //         ));

// //     print("Function completed after 10 seconds");
// //   }
// // }









// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// import 'dart:async';
// import 'dart:io';
// import 'dart:convert';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:faced/main.dart';
// import 'package:faced/module/Dashboard/ui/dashboard.dart';
// import 'package:faced/module/Image_Registation/bloc/registationbloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gallery_saver/gallery_saver.dart';
// import 'package:http/http.dart';
// import 'package:image_picker/image_picker.dart';
// //import 'package:sharedpreference/sharedpreference.dart';

// import '../../../SharedPreference/shared_preference.dart';
// import '../../../api/api_calls.dart';
// import '../../../base/HexColor.dart';
// import '../../../base/base_response.dart';
// import '../../../base/constants_color.dart';
// import '../../../registering.dart';
// import '../../../sample.dart';
// import '../Bloc/recognize_bloc.dart';

// import 'package:google_ml_kit/google_ml_kit.dart';
// // import 'camera_view.dart';
// import 'camera_view.dart';
// import 'face_detector_paint.dart';

// class RecognizeScreen extends StatefulWidget {
//   const RecognizeScreen({super.key});

//   @override
//   State<RecognizeScreen> createState() => _RecognizeScreenState();
// }

// class _RecognizeScreenState extends State<RecognizeScreen> {
//   RecognizeBloc adddataBloc = RecognizeBloc();
//   FaceRecognization recogization = FaceRecognization();

//   TextEditingController namecontroller = TextEditingController();
//   File? image;
//   var loading;
//   int isActive = 1;
//   int? statusCodes;
//   int? faceId;
//   final _formKey = GlobalKey<FormState>();
//   //late SharedPreference logindata;
//   late bool newuser;
//   var NAME;

//   String? basevar;
//   // late CameraController _controller;
//     FaceDetector faceDetector =
//       GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
//     enableContours: true,
//     enableClassification: true,
//   ));
//     bool _canProcess = true;
//   bool isBusy = false;
//   CustomPaint? customPaint;
//     String? _text;


//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // _controller = CameraController(cameras[1], ResolutionPreset.medium);
//     // _controller.initialize().then((_) {
//     //   if (!mounted) {
//     //     return;
//     //   }
//     //   setState(() {});
//     // }).catchError((Object e) {
//     //   if (e is CameraException) {
//     //     switch (e.code) {
//     //       case 'CameraAccessDenied':
//     //         print("access was denied");
//     //         break;
//     //       default:
//     //         print(e.description);
//     //         break;
//     //     }
//     //   }
//     // });



//     adddataBloc.getrecognizestream.listen((event) async {
//       switch (event.status) {
//         case Status.LOADING:
//           loading = await ApiCall().showLoaderDialog(context);
//           break;
//         case Status.COMPLETED:
//           if (event.data!.status == 200) {
//             statusCodes = event.data!.status;
//             faceId = event.data!.faceID;

//             print("faceId ${faceId}");
//             if (faceId! > 0) {
//               NAME = await recogization.fetchAlbum(faceId!);
//             } else {
//               NAME = "UNKNOWN";
//             }

//             print("waited string value in class.... ${recogization.username}");
//             print("waited .... ${NAME}");

//             //loading.dispose;
//             statuscheck();

//             print("Statuscodeeeeeeeeee${event.data!.status}");
//           } else {
//             print("This is not a status 200");
//           }
//           break;
//         case Status.ERROR:
//           break;
//       }
//     });
//   }

//   @override
//   void dispose() {
//       _canProcess = false;
//     faceDetector.close();
//     super.dispose();
//     ApiCall();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double _deviceHeight = MediaQuery.of(context).size.height;
//     double _deviceWidth = MediaQuery.of(context).size.width;
//     // print("w:${_deviceWidth}, H:${_deviceHeight}");

//     return Scaffold(
//       body: imageProfile(),
//     );
//   }

//   pickImageC(XFile image) async {
//     try {
//       print("Image capture");
//       if (image == null) {
//         return ImageToast();
//       }
//       final bytes = await image.readAsBytes();
//       print("Original size of image: ${bytes.lengthInBytes}");

//       final compressedBytes = await FlutterImageCompress.compressWithList(
//         bytes,
//         minWidth: 500, // Change as needed
//         minHeight: 500, // Change as needed
//         quality: 70, // Change as needed
//       );

//       print("Compressed size of image: ${compressedBytes.length}");

//       final imageTemp = File(image.path);
//       await imageTemp.writeAsBytes(compressedBytes);
//       setState(() => this.image = imageTemp);

//       basevar = base64Encode(compressedBytes);

//       var map = {
//         "imagestring": basevar,
//       };

     
//       var body = jsonEncode(map);
//       print("Request datt $body");
//       adddataBloc.recognizeMethod(body);

//       if (image != null && image.path != null) {
//         setState(() {
//           print("loading Image....");
//         });
//         GallerySaver.saveImage(image.path).then((imageTemp) {
//           setState(() {
//             print("Image Saved${image.path}");
//           });
//         });
//       }
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }

//   Widget imageProfile() {
//     return Stack(
//       children: [
//         Container(
//           height: double.infinity,  
//           child: CameraView(
//       customPaint: customPaint,
//       onImage: (inputImage) {
//         processImage(inputImage);
//       },
//       initialDirection: CameraLensDirection.front,
//     )
//           // child: CameraPreview(_controller), // to check
//         ),
//         // Positioned(
//         //   bottom: 10,
//         //   left: MediaQuery.of(context).size.width / 3.4,
//         //   child: Center(
//         //     child: Container(
//         //       margin: EdgeInsets.all(20.0),
//         //       child: MaterialButton(
//         //         onPressed: () async {
//         //         //   if (!_controller.value.isInitialized) {
//         //         //     return null;
//         //         //   }
//         //         //   if (_controller.value.isTakingPicture) {
//         //         //     return null;
//         //         //   }

//         //         //   try {
//         //         //     await _controller.setFlashMode(FlashMode.auto);
//         //         //     XFile Picture = await _controller.takePicture();  
//         //         //     pickImageC(Picture);
//         //         //   } on CameraException catch (e) {
//         //         //     debugPrint("Error occured while taking Picture: $e");
//         //         //     return null;
//         //         //   }
//         //         },
//         //         color: Colors.white,
//         //         child: Text("Take a Picture"),// btn
//         //       ),
//         //     ),
//         //   ),
//         // )
//       ],
//     );
//   }

//     sendImageToAPI(InputImage image) async {
//       print("Image ${image}");
//             final bytes = image.bytes;
//             // Below example uses metadata values based on an RGBA-encoded 1080x1080 image

// final visionImage = InputImage.fromBytes( bytes: image.bytes!, inputImageData: image.inputImageData!);
//   try {
//     if(visionImage != null){
//       print("vision ${visionImage}");
//       final compressedBytes = await FlutterImageCompress.compressWithList(
//         visionImage.bytes!,
//         minWidth: 500, // Change as needed
//         minHeight: 500, // Change as needed
//         quality: 70, // Change as needed
//       );

//       print("Compressed size of image: ${compressedBytes.length}");
//     }
//    } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
// //   try {
// //             if(bytes != null){
// // final compressedBytes = await FlutterImageCompress.compressWithList(
// //         bytes,
// //         minWidth: 500, // Change as needed
// //         minHeight: 500, // Change as needed
// //         quality: 70, // Change as needed
// //       );

// //       print("Compressed size of image: ${compressedBytes.length}");


// //       basevar = base64Encode(compressedBytes);
// //       print("base================ ${basevar}");
      
// //             }
// //              } on PlatformException catch (e) {
// //       print('Failed to pick image: $e');
// //     }
// //       // print("Original size of image: ${bytes.lengthInBytes}");
// //       // Iterable<int> iterable = bytes!;
      
// //       // var map = {
//       //   "imagestring": basevar,
//       // };
      
//   }

//     Future<void> processImage(InputImage inputImage) async {
//           if (!_canProcess) return;
//     if (isBusy) return;
//     isBusy = true;
//         setState(() {
//       _text = "";
//     });
//     final faces = await faceDetector.processImage(inputImage);
//           // print("Faces data ${faces.toString()}");

//     if (inputImage.inputImageData?.size != null &&
//         inputImage.inputImageData?.imageRotation != null) {
//       final painter = FaceDetectorPainter(
//           faces,
//           inputImage.inputImageData!.size,
//           inputImage.inputImageData!.imageRotation);
//       customPaint = CustomPaint(painter: painter);
//       // if(faces.length > 0)
//       // sendImageToAPI(inputImage);

//           // print("customPaint data ${customPaint}");
//     } else {
//             String text = 'face found ${faces.length}\n\n';
//       for (final face in faces) {
//         text += 'face ${face.boundingBox}\n\n';
//       }
//       _text = text;
//       customPaint = null;
//     }
//     isBusy = false;
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   showtoast() {
//     Fluttertoast.showToast(
//       msg: "Enter the name First",
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//     );
//   }

//   ImageToast() {
//     Fluttertoast.showToast(
//       msg: "Select image First",
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//     );
//   }

//   MinValueToast() {
//     Fluttertoast.showToast(
//       msg: "Enter Minimum Three Character",
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//     );
//   }

//   statuscheck() {
//     //ApiCall().dispose;

//     //dispose().ApiCall();
//     SharedPrefrence().setisLogin(true);
//     SharedPrefrence().setIsName(namecontroller.text);
//     SharedPrefrence().setProfileImage('');

//     Fluttertoast.showToast(
//       msg: "Recognized ${NAME}...",
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//     );

//     if (faceId == 0) {
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.warning,
//         // animType: AnimType.bottomSlide,
//         // showCloseIcon: true,
//         title: "${NAME} Recognized ...",
//       ).show();
//     } else {
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.success,
//         // animType: AnimType.bottomSlide,
//         // showCloseIcon: true,
//         title: "Recognized ${NAME}...",
//       ).show();
//     }

//     myFunction();
//   }

//   Future<void> myFunction() async {
//     print("Function started");

//     // Wait for 10 seconds
//     await Future.delayed(Duration(seconds: 10));

//     // await Navigator.push(
//     //     context,
//     //     MaterialPageRoute(
//     //       builder: (context) => RegisterButtonScreen(),
//     //     ));

//     print("Function completed after 10 seconds");
//   }
// }









