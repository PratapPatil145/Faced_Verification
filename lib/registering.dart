// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:faced/module/Image_Registation/ui/camera_screen.dart';
// import 'package:faced/module/Recognize/Ui/recognize_screen.dart';
// import 'package:flutter/material.dart';

// class RegisterButtonScreen extends StatefulWidget {
//   const RegisterButtonScreen({super.key});

//   @override
//   State<RegisterButtonScreen> createState() => _RegisterButtonScreenState();
// }

// class _RegisterButtonScreenState extends State<RegisterButtonScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(30.0),
//             child: Column(
              
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 AnimatedButton(
//                     text: "Registation",
//                     color: Colors.amber,
//                     buttonTextStyle:
//                         TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                     pressEvent: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => CameraScreen(),
//                           ));
//                     }),
//                     SizedBox(height:30,),
               
//                 AnimatedButton(
//                     text: "Recognition",
//                     buttonTextStyle:
//                         TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                     pressEvent: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => RecognizeScreen(),
//                           ));
//                     }),
//               ],
//             ),
//           )),
//     );
//   }
// }
