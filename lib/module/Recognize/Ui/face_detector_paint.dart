// import 'dart:math';
// import 'dart:ui';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

// double translateX(
//     double x, InputImageRotation rotation, Size size, Size absoluteImageSize) {
//   switch (rotation) {
//     case InputImageRotation.Rotation_0deg:
//       return x *
//           size.width /
//           (Platform.isIOS ? absoluteImageSize.width : absoluteImageSize.height);
//     case InputImageRotation.Rotation_270deg:
//       return size.width -
//           x *
//               size.width /
//               (Platform.isIOS
//                   ? absoluteImageSize.width
//                   : absoluteImageSize.height);
//     default:
//       return x * size.width / absoluteImageSize.width;
//   }
// }

// double translateY(
//     double y, InputImageRotation rotation, Size size, Size absoluteImageSize) {
//   switch (rotation) {
//     case InputImageRotation.Rotation_0deg:
//     case InputImageRotation.Rotation_270deg:
//       return y *
//           size.height /
//           (Platform.isIOS ? absoluteImageSize.height : absoluteImageSize.width);
//     default:
//       return y * size.height / absoluteImageSize.height;
//   }
// }

// class FaceDetectorPainter extends CustomPainter {
//   FaceDetectorPainter(this.faces, this.absoluteImageSize, this.rotation);

//   final List<Face> faces;
//   final Size absoluteImageSize;
//   final InputImageRotation rotation;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;  //increase the thickness of the drawing
      
//     if (faces.isEmpty) {
//       // Reinitialize bounding box size to zero if no faces detected
//       const boundingBoxSize = Size.zero;
//     } else {
//       final firstFace = faces.first;
//       final boundingBoxSize = Size(
//         firstFace.boundingBox.width,
//         firstFace.boundingBox.height,
//       );
//       final diagonalLength = _calculateDiagonalLength(boundingBoxSize);

//       print('Bounding Box Size: $boundingBoxSize');
//       print('Bounding Box Width: ${firstFace.boundingBox.width}');
//       print('Bounding Box Height: ${firstFace.boundingBox.width}');
//       print('Diagonal Length: $diagonalLength');

//       if (diagonalLength > 750) {
//         paint.color = Colors.green;
        
//       } else {
//         paint.color = Colors.red;
//       }
//     }

//     for (final Face face in faces) {

//       canvas.drawRect(
//         Rect.fromLTRB(
//           translateX(face.boundingBox.left -10, rotation, size, absoluteImageSize),
//           translateY(face.boundingBox.top -10, rotation, size, absoluteImageSize),
//           translateX(face.boundingBox.right +10, rotation, size, absoluteImageSize),
//           translateY(face.boundingBox.bottom +50, rotation, size, absoluteImageSize),
//         ),
//         paint,
//       );

//       void paintContour(FaceContourType type) {
//         final faceContour = face.getContour(type);
//         if (faceContour?.positionsList != null) {
//           for (Offset point in faceContour!.positionsList) {
//             canvas.drawCircle(
//                 Offset(
//                   translateX(point.dx, rotation, size, absoluteImageSize),
//                   translateY(point.dy, rotation, size, absoluteImageSize),
//                 ),
//                 1,
//                 paint);
//           }
//         }
//       }

//       paintContour(FaceContourType.face);
//       // paintContour(FaceContourType.leftEyebrowTop);
//       // paintContour(FaceContourType.leftEyebrowBottom);
//       // paintContour(FaceContourType.rightEyebrowTop);
//       // paintContour(FaceContourType.rightEyebrowBottom);
//       // paintContour(FaceContourType.leftEye);
//       // paintContour(FaceContourType.rightEye);
//       // paintContour(FaceContourType.upperLipTop);
//       // paintContour(FaceContourType.upperLipBottom);
//       // paintContour(FaceContourType.lowerLipTop);
//       // paintContour(FaceContourType.lowerLipBottom);
//       // paintContour(FaceContourType.noseBridge);
//       // paintContour(FaceContourType.noseBottom);
//       // paintContour(FaceContourType.leftCheek);
//       // paintContour(FaceContourType.rightCheek);

//     }
//   }
//   double _calculateDiagonalLength(Size size) {
//     return sqrt(size.width * size.width + size.height * size.height);
//   }
//   @override
//   bool shouldRepaint(FaceDetectorPainter oldDelegate) {
//     return oldDelegate.absoluteImageSize != absoluteImageSize ||
//         oldDelegate.faces != faces;
//   }
// }

// // Future<void> captureAndCrop(Size boundingBoxSize) async {
// //   // capture screen bytes
// //   final List<Uint8List> bytesList = await _cameraController.takePicture();
// //   final Uint8List bytes = bytesList.first;
// //   // decode the capture bytes to image
// //   final ui.Image image = await decodeImageFromList(bytes);
// //   final double diagonalLength = _calculateDiagonalLength(boundingBoxSize);

// //   # define ltrb values to crop
// //   final double margin = 100.0;
// //   final double bottomMargin = 150.0;
// //   final Rect cropRect = Rect.fromLTRB(
// //     boundingBoxRect.left - margin,
// //     boundingBoxRect.top - margin,
// //     boundingBoxRect.right + margin,
// //     boundingBoxRect.bottom + bottomMargin,
// //   );

// //   // cropp image using flutter library
// //   final ui.Image croppedImage = await cropImage(image, cropRect);
  
// //   // save the cropped image
// //   final directory = await getTemporaryDirectory();
// //   final filePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
  
// //   final ByteData byteData = await croppedImage.toByteData(format: ui.ImageByteFormat.png);
// //   await File(filePath).writeAsBytes(byteData.buffer.asUint8List());
// // }
