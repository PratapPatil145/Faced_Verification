// import 'dart:convert';
// import 'dart:developer';

// import '../../../base/api_constants.dart';
// import '../../../base/base_httpcall.dart';

// import 'package:http/http.dart' as http;

// import '../Model/recognize_model.dart';

// class ImageRecognization {
//   Future<dynamic> recognizeface(dynamic body) async {
//     BaseHTTP baseHTTP = BaseHTTP();
//     final response =
//         await baseHTTP.postWithBody2(ApiConstants.RECOGNIZE_URL, body);
//     log("Image Registation_ ${response}");

//     print("libraryresponse ${response}");
    
    

//     return RecognizeDataModel.fromJson(response);
   
//   }
// }
