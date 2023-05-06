// import 'dart:async';
// import 'dart:io';
// import 'dart:convert';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:faced/SharedPreference/shared_preference.dart';
// import 'package:faced/main.dart';
// import 'package:faced/module/Image_Registation/bloc/registationbloc.dart';
// import 'package:faced/module/Image_Registation/ui/camera_screen.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gallery_saver/gallery_saver.dart';
// import 'package:http/http.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../base/HexColor.dart';
// import '../../../base/base_response.dart';
// import '../../../base/constants_color.dart';

// class DashboardScreen extends StatefulWidget {
//   File? images;
//   String? name;
//   DashboardScreen({Key? key, this.images, this.name}) : super(key: key);

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   //SharedPrefrence? sharedPrefrence;

//   File? image;
//   final _formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     image = widget.images;
//   }

//   Widget build(BuildContext context) {
//     double _deviceHeight = MediaQuery.of(context).size.height;
//     double _deviceWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: Drawer(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
              
//               Row(
               
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 20),
//                     //height: _deviceHeight/
//                     child: Stack(children: <Widget>[
//                       SharedPrefrence().getProfileImage()==''
//                       // image == null
//                           ? CircleAvatar(
//                               radius: 40.0,
//                               backgroundColor: Colors.transparent,
//                               backgroundImage:
//                                   (image == null
//                                           ? AssetImage(
//                                               "assets/images/userprofile1.png")
//                                           : FileImage(File(image!.path)))
//                                       as ImageProvider<Object>?,
//                             )
//                           : CircleAvatar(
//                               radius: 40.0,
//                               backgroundColor: Colors.transparent,
//                               backgroundImage: image != null
//                                   ? FileImage(File(image!.path))
//                                   : (image == null
//                                           ? AssetImage(
//                                               "assets/images/userprofile1.png")
//                                           : FileImage(File(image!.path)))
//                                       as ImageProvider<Object>?,
//                             ),
//                     ]),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 30),
//                 // name=sharedPrefrence!.getString("name"),

//                child: Text(
//                 // widget.name ??
//                   " The Name of User =  ${SharedPrefrence().getIsName()}",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
               
//               ),
//               SizedBox(height: _deviceHeight*0.6,),
//               TextButton(
//                   onPressed: () {
//                     SharedPrefrence().setisLogin(false);
//                     sharedPrefrence!.clear();

//                     Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (context) => CameraScreen()),
//                         (route) => false);
//                   },
//                   child: const Text(
//                     "LogOut",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ))
//             ],
//           ),
//         ),
//       ),
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             //Navigator.pop(context);
//             _scaffoldKey.currentState!.openDrawer();
//           },
//           icon: SvgPicture.asset(
//             'assets/images/drawer.svg',
//             alignment: Alignment.centerLeft,
//             color: HexColor("#FFFFFF"),
//           ),
//         ),
        
//         title: Text("Face Verification app"),
//       ),
//       body: SafeArea(
//         child: Text("DDDDDDDDDDDDfffffffffffffD"),
//       ),
//     );
//   }

//  }
