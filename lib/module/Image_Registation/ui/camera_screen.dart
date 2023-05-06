// import 'dart:async';
// import 'dart:io';
// import 'dart:convert';
// import 'package:awesome_dialog/awesome_dialog.dart';
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

// class CameraScreen extends StatefulWidget {
//   CameraScreen({
//     Key? key,
//     //super.key
//   }) : super(key: key);

//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   LibraryBloc adddataBloc = LibraryBloc();

//   TextEditingController namecontroller = TextEditingController();
//   File? image;
//   var loading;
//   var dialog;
//   int isActive = 1;
//   int? statusCodes;
//   final _formKey = GlobalKey<FormState>();
//   //late SharedPreference logindata;
//   late bool newuser;

//   late String basevar;

//   @override
//   void initState() {
//     adddataBloc.getlibrarystream.listen((event) async {
//       switch (event.status) {
//         case Status.LOADING:
//           loading = await ApiCall().showLoaderDialog(context);
//           break;
//         case Status.COMPLETED:
//           if (event.data!.status == 200) {
//             //dialog.dismiss();
//             AwesomeDialog(
//               context: context,
//               dialogType: DialogType.success,
//               // animType: AnimType.bottomSlide,
//               // showCloseIcon: true,
//               title: " ${namecontroller.text} faced Registered ......",
//             ).show();

//             statuscheck();
//           } else {
//             AwesomeDialog(
//               context: context,
//               dialogType: DialogType.error,
//               // animType: AnimType.bottomSlide,
//               // showCloseIcon: true,
//               title: "faced Not Registered ......",
//             ).show();
//           }

//           // if (event.data!.status == 200) {
//           //   statusCodes = event.data!.status;
//           //   //loading.dispose;
//           //   statuscheck();

//           //   print("Statuscode${event.data!.status}");
//           // } else {
//           //   print("This is not a status 200");
//           // }
//           break;
//         case Status.ERROR:
//           break;
//       }
//     });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     ApiCall();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double _deviceHeight = MediaQuery.of(context).size.height;
//     double _deviceWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Form(
//         key: _formKey,
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 imageProfile(),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: TextFormField(
//                         controller: namecontroller,
//                         decoration: InputDecoration(
//                           //filled: true,
//                           //fillColor: Colors.white,
//                           //focusColor: Colors.white,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.grey, width: 1.0),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           hintText: 'Enter Your Name',
//                           hintStyle: TextStyle(color: Colors.grey),
//                         ),
//                         validator: (value) {
//                           if (image == null) {
//                             return ImageToast();
//                           } else if (value!.isEmpty) {
//                             return showtoast();
//                           } else if (value.length < 3) {
//                             return MinValueToast();
//                           } else if (value.length > 14) {
//                             return "Name is greater than 15 character";
//                           }
//                           return null;
//                         },
//                         inputFormatters: <TextInputFormatter>[
//                           FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
//                           // LengthLimitingTextInputFormatter(
//                           //               15),
//                         ],
//                         keyboardType: TextInputType.text,
//                         textCapitalization: TextCapitalization.words,
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                       //color: Colors.amber,

//                       child: AnimatedButton(
//                         text: "Register",
//                         color: Colors.amber,
//                         pressEvent: () {
//                           if (_formKey.currentState!.validate()) {
//                             // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                             //   content: Text("Resistation  Successfully"),
//                             // ));
//                           }

//                           // var dialog = AwesomeDialog(
//                           //   context: context,
//                           //   dialogType: DialogType.question,
//                           //   // animType: AnimType.bottomSlide,
//                           //   // showCloseIcon: true,
//                           //   title: " Registering ......",
//                           // );
//                           // dialog.show();

//                           var map = {
//                             "username": namecontroller.text,
//                             "imagestring": basevar,
//                             "companyid": 0
//                           };
//                           var body = jsonEncode(map);
//                           print("Request datt $body");
//                           adddataBloc.insertNewData(body);

//                           //  print(" CODEEEEEEE ${status}.");
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void pickImageC() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.camera);
//       print("Image capture");
//       if (image == null) {
//         return ImageToast();
//       }

//       final imageTemp = File(image.path);

//       setState(() => this.image = imageTemp);

//       //final filecontent =await File.fromUri(Uri.parse(image)).readAsBytes();

//       final bytes = await imageTemp.readAsBytes();
//       setState(() {
//         basevar = base64Encode(bytes);
//       });

//       if (image != null && image.path != null) {
//         setState(() {
//           print("loading Image....");
//         });
//         GallerySaver.saveImage(image.path).then((imageTemp) {
//           setState(() {
//             print("Image Saved");
//           });
//         });
//       }
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }

//   Widget imageProfile() {
//     return Center(
//       child: Container(
//         //height: _deviceHeight/
//         child: Stack(children: <Widget>[
//           image == null
//               ? CircleAvatar(
//                   radius: 60.0,
//                   backgroundColor: Colors.transparent,
//                   backgroundImage: (image == null
//                       ? AssetImage("assets/images/userprofile1.png")
//                       : FileImage(File(image!.path))) as ImageProvider<Object>?,
//                 )
//               : CircleAvatar(
//                   radius: 60.0,
//                   backgroundColor: Colors.transparent,
//                   backgroundImage: image != null
//                       ? FileImage(File(image!.path))
//                       : (image == null
//                               ? AssetImage("assets/images/userprofile1.png")
//                               : FileImage(File(image!.path)))
//                           as ImageProvider<Object>?,
//                 ),
//           Positioned(
//             bottom: 10.0,
//             right: 0,
//             child: InkWell(
//               onTap: () {
//                 pickImageC();
//                 // showModalBottomSheet(
//                 //   context: context,
//                 //   builder: ((builder) =>
//                 //  // bottomSheet()
//                 //   ),
//                 // );
//               },
//               child: Icon(
//                 Icons.camera_alt,
//                 color: HexColor(AppColors.primary_color),
//                 size: 28.0,
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
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
//     //dispose().ApiCall();
//     SharedPrefrence().setisLogin(true);
//     SharedPrefrence().setIsName(namecontroller.text);
//     SharedPrefrence().setProfileImage('');

//     // Fluttertoast.showToast(
//     //   msg: "Registation Succesfull...",
//     //   toastLength: Toast.LENGTH_LONG,
//     //   gravity: ToastGravity.BOTTOM,
//     // );
//     myFunction();
//   }

//   Future<void> myFunction() async {
//     print("Function started");

//     // Wait for 10 seconds
//     await Future.delayed(Duration(seconds: 2));

//     await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => RegisterButtonScreen(),
//         ));

//     print("Function completed after 10 seconds");
//   }
// }






import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
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
//import 'package:sharedpreference/sharedpreference.dart';

import '../../../SharedPreference/shared_preference.dart';
import '../../../api/api_calls.dart';
import '../../../base/HexColor.dart';
import '../../../base/base_response.dart';
import '../../../base/constants_color.dart';
import '../../../registering.dart';
import '../../../sample.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({
    Key? key,
    //super.key
  }) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  LibraryBloc adddataBloc = LibraryBloc();

  TextEditingController namecontroller = TextEditingController();
  File? image;
  var loading;
  var dialog;
  int isActive = 1;
  int? statusCodes;
  final _formKey = GlobalKey<FormState>();
  
  //late SharedPreference logindata;
  late bool newuser;

  late String basevar;

  @override
  void initState() {
   // pickImageC();
    // adddataBloc.getlibrarystream.listen((event) async {
    //   switch (event.status) {
    //     case Status.LOADING:
    //       loading = await ApiCall().showLoaderDialog(context);
    //       break;
    //     case Status.COMPLETED:
    //       if (event.data!.status == 200) {
    //         //dialog.dismiss();
    //         AwesomeDialog(
    //           context: context,
    //           dialogType: DialogType.success,
    //           // animType: AnimType.bottomSlide,
    //           // showCloseIcon: true,
    //           title: " ${namecontroller.text} faced Registered ......",
    //         ).show();

    //         statuscheck();
    //       } else {
    //         AwesomeDialog(
    //           context: context,
    //           dialogType: DialogType.error,
    //           // animType: AnimType.bottomSlide,
    //           // showCloseIcon: true,
    //           title: "faced Not Registered ......",
    //         ).show();
    //       }

    //       // if (event.data!.status == 200) {
    //       //   statusCodes = event.data!.status;
    //       //   //loading.dispose;
    //       //   statuscheck();

    //       //   print("Statuscode${event.data!.status}");
    //       // } else {
    //       //   print("This is not a status 200");
    //       // }
    //       break;
    //     case Status.ERROR:
    //       break;
    //   }
    // });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    ApiCall();
  }

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // body: Stack(children: [
      //  Container(child: pickImageC(),),
      // Positioned(child: Text("RRRRRRRRR",style: TextStyle(fontSize: 14),))
      // ]),



      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imageProfile(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: namecontroller,
                        decoration: InputDecoration(
                          //filled: true,
                          //fillColor: Colors.white,
                          //focusColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'Enter Your Name',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (value) {
                          if (image == null) {
                            return ImageToast();
                          } else if (value!.isEmpty) {
                            return showtoast();
                          } else if (value.length < 3) {
                            return MinValueToast();
                          } else if (value.length > 14) {
                            return "Name is greater than 15 character";
                          }
                          return null;
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                          // LengthLimitingTextInputFormatter(
                          //               15),
                        ],
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      //color: Colors.amber,

                      child: AnimatedButton(
                        text: "Register",
                        color: Colors.amber,
                        pressEvent: () {
                          if (_formKey.currentState!.validate()) {
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   content: Text("Resistation  Successfully"),
                            // ));
                          }

                          // var dialog = AwesomeDialog(
                          //   context: context,
                          //   dialogType: DialogType.question,
                          //   // animType: AnimType.bottomSlide,
                          //   // showCloseIcon: true,
                          //   title: " Registering ......",
                          // );
                          // dialog.show();

                          var map = {
                            "username": namecontroller.text,
                            "imagestring": basevar,
                            "companyid": 0
                          };
                          var body = jsonEncode(map);
                          print("Request datt $body");
                          adddataBloc.insertNewData(body);

                          //  print(" CODEEEEEEE ${status}.");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }







   pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      print("Image capture");
      if (image == null) {
        return ImageToast();
      }

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);

      //final filecontent =await File.fromUri(Uri.parse(image)).readAsBytes();

      final bytes = await imageTemp.readAsBytes();
      setState(() {
        basevar = base64Encode(bytes);
      });

      if (image != null && image.path != null) {
        setState(() {
          print("loading Image....");
        });
        GallerySaver.saveImage(image.path).then((imageTemp) {
          setState(() {
            print("Image Saved");
          });
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget imageProfile() {
    return Center(
      child: Container(
        //height: _deviceHeight/
        child: Stack(children: <Widget>[
          image == null
              ? CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: (image == null
                      ? AssetImage("assets/images/userprofile1.png")
                      : FileImage(File(image!.path))) as ImageProvider<Object>?,
                )
              : CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: image != null
                      ? FileImage(File(image!.path))
                      : (image == null
                              ? AssetImage("assets/images/userprofile1.png")
                              : FileImage(File(image!.path)))
                          as ImageProvider<Object>?,
                ),
          Positioned(
            bottom: 10.0,
            right: 0,
            child: InkWell(
              onTap: () {
                pickImageC();
                // showModalBottomSheet(
                //   context: context,
                //   builder: ((builder) =>
                //  // bottomSheet()
                //   ),
                // );
              },
              child: Icon(
                Icons.camera_alt,
                color: HexColor(AppColors.primary_color),
                size: 28.0,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  showtoast() {
    Fluttertoast.showToast(
      msg: "Enter the name First",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  ImageToast() {
    Fluttertoast.showToast(
      msg: "Select image First",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  MinValueToast() {
    Fluttertoast.showToast(
      msg: "Enter Minimum Three Character",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  statuscheck() {
    //dispose().ApiCall();
    SharedPrefrence().setisLogin(true);
    SharedPrefrence().setIsName(namecontroller.text);
    SharedPrefrence().setProfileImage('');

    // Fluttertoast.showToast(
    //   msg: "Registation Succesfull...",
    //   toastLength: Toast.LENGTH_LONG,
    //   gravity: ToastGravity.BOTTOM,
    // );
    myFunction();
  }

  Future<void> myFunction() async {
    print("Function started");

    // Wait for 10 seconds
    await Future.delayed(Duration(seconds: 2));

    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterButtonScreen(),
        ));

    print("Function completed after 10 seconds");
  }
}
