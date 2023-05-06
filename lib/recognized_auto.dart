// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:opencv/core/core.dart';
// import 'package:opencv/core/core.dart' as cv;
// import 'package:opencv/core/imgproc.dart';
// import 'package:opencv/opencv.dart';

// class FaceDetector extends StatefulWidget {
//   @override
//   _FaceDetectorState createState() => _FaceDetectorState();
// }

// class _FaceDetectorState extends State<FaceDetector> {
//   final picker = ImagePicker();
//   List _faces = [];

//   void detectFaces(File image) async {
//     // Load image with OpenCV
//     Img img = await Img.fromFile(image.path);
//     Mat mat = await img.toMat();

//     // Convert to grayscale
//     Imgproc.cvtColor(mat, mat, Imgproc.COLOR_BGR2GRAY);

//     // Load pre-trained classifier for frontal faces
//     String cascade = await rootBundle
//         .loadString('assets/haarcascade_frontalface_default.xml');
//     cv.CascadeClassifier classifier = cv.CascadeClassifier.fromString(cascade);

//     // Detect faces
//     List faces = await classifier.detectMultiScale(mat);

//     // Update state with detected faces
//     setState(() {
//       _faces = faces;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Face Detector'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (_faces.isNotEmpty)
//               Expanded(
//                 child: Image.file(
//                   File(_faces.first['path']),
//                   fit: BoxFit.contain,
//                   alignment: Alignment.topCenter,
//                   filterQuality: FilterQuality.high,
//                   frameBuilder: (BuildContext context, Widget child, int frame,
//                       bool wasSynchronouslyLoaded) {
//                     if (wasSynchronouslyLoaded) return child;
//                     return AnimatedOpacity(
//                       child: child,
//                       opacity: frame == null ? 0 : 1,
//                       duration: const Duration(milliseconds: 500),
//                       curve: Curves.easeOut,
//                     );
//                   },
//                 ),
//               ),
//             ElevatedButton(
//               onPressed: () async {
//                 final pickedFile =
//                     await picker.getImage(source: ImageSource.gallery);
//                 if (pickedFile != null) {
//                   // Detect faces in selected image
//                   detectFaces(File(pickedFile.path));
//                 }
//               },
//               child: Text('Select Image'),
//             ),
//             if (_faces.isNotEmpty)
//               Expanded(
//                 child: CustomPaint(
//                   painter: FacePainter(_faces),
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: double.infinity,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FacePainter extends CustomPainter {
//   final List faces;

//   FacePainter(this.faces);

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Draw face rectangles

// // Draw face rectangles
//     for (Rect face in faces) {
//       Paint paint = Paint()
//         ..color = Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
//             Random().nextInt(255), 1)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2;

//       canvas.drawRect(
//         Rect.fromLTWH(face.left.toDouble(), face.top.toDouble(),
//             face.width.toDouble(), face.height.toDouble()),
//         paint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(FacePainter oldDelegate) {
//     return faces != oldDelegate.faces;
//   }
// }
