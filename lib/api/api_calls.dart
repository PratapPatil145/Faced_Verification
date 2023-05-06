
import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ApiCall {
  /*static String baseUrl = "https://csat.sisindia.com:8443/CSATLIVE_Api/";

  String loginUrl = baseUrl + "api/module.login/SendOTP";
  String otpValidation = baseUrl + "api/otpvalidation";
  String addNote = baseUrl + "api/csat/AddNote";
  String uploadFile = baseUrl + "api/UploadFile/PostFile";
  String unitScoreDetails = baseUrl + "/api/csat/UnitScoreDetails";
  String unitDetailLastDataApiCall = baseUrl + "/api/csat/LastCSATDetails";
  String unitOpsPerformanceApiCall = baseUrl + "/api/csat/OPSPerformance";
  String getContacts = baseUrl + "api/csat/CustomerByBranch";
  String sendContact = baseUrl + "api/csat/LinkNotification";
  String surveyQuestionLink = baseUrl + "api/csat/GetLink";
  String updateSurveyStatus = baseUrl + "api/csat/UpdateSurveyStatus";
  String getCSATOTP = baseUrl + "api/csat/GetValidateBH";

  static String getCSATDetails =
      "http://iopsanalytics-dev.azurewebsites.net/api/CSAT/CustomerDetail";*/


  /*Future<String> callApi(
      String url, String body, Map<String, String> header) async {
    print(url);
    print(body);
    try {
      var token = BHRHSharedPrefrence().getToken();
      header['Authorization'] = 'Bearer $token';

      final http.Response response = await http
          .post(
            url,
            headers: header,
            body: body,
          )
          .timeout(
            Duration(seconds: 60),
          );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print(response.statusCode.toString() + " " + response.body);
        return "failure";
      }
    } on TimeoutException catch (e) {
      print('Timeout');
      return "failure";
    } on Error catch (e) {
      print('Error: $e');
      return "failure";
    }
  }*/

//  Future<String> callUrlFormApi(
//      String url, Map<String, dynamic> body, Map<String, String> header) async {
//    print(url);
//    print(body);
//    try {
//      final http.Response response = await http
//          .post(
//        url,
//        headers: header,
//        body: body,
//      )
//          .timeout(
//        Duration(seconds: 60),
//      );
//
//      if (response.statusCode == 200) {
//        return response.body;
//      } else {
//        print(response.statusCode.toString() + " " + response.body);
//        return "failure";
//      }
//    } on TimeoutException catch (e) {
//      print('Timeout');
//      return "failure";
//    } on Error catch (e) {
//      print('Error: $e');
//      return "failure";
//    }
//  }

  // Used in CSAT only
  /*Future<String> getApi(String url, Map<String, String> header) async {
    print(url);
    var token = BHRHSharedPrefrence().getToken();
    header['Authorization'] = 'Bearer $token';

    try {
      final http.Response response =
          await http.get(url, headers: header).timeout(
                Duration(seconds: 60),
              );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print(response.statusCode.toString() + " " + response.body);
        return "failure";
      }
    } on TimeoutException catch (e) {
      print('Timeout');
      return "failure";
    } on Error catch (e) {
      print('Error: $e');
      return "failure";
    }
  }*/

  // Used in CSAT only
  /*Future<String> callMultiPartApi(String url, List<String> images,
      Map<String, String> header, String audioPath) async {
    var token = BHRHSharedPrefrence().getToken();
    header['Authorization'] = 'Bearer $token';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      for (String image in images) {
        if (!image.endsWith("svg")) {
          request.files.add(http.MultipartFile('file',
              File(image).readAsBytes().asStream(), File(image).lengthSync(),
              filename: image.split("/").last));
        }
      }
      if (audioPath != "") {
        request.files.add(http.MultipartFile(
            'file',
            File(audioPath).readAsBytes().asStream(),
            File(audioPath).lengthSync(),
            filename: audioPath.split("/").last));
      }
      var response = await request.send().timeout(
            Duration(seconds: 60),
          );
      var responseString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return responseString;
      } else {
        print(response.statusCode.toString() + " " + response.toString());
        return "failure";
      }
    } on TimeoutException catch (e) {
      print('Timeout');
      return "failure";
    } on Error catch (e) {
      print('Error: $e');
      return "failure";
    }
  }*/

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  showLoaderDialog(BuildContext context,{String text = 'Loading...'}){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          SizedBox(width: 10,),
          CircularProgressIndicator(strokeWidth: 5,),
          SizedBox(width: 20,),
          Container(margin: EdgeInsets.only(left: 7),child:Text(text ,style: TextStyle(fontSize: 18,color: Colors.black),)),
          SizedBox(width: 10,),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  void showToast(String message, BuildContext context) {
    Fluttertoast.showToast(msg:message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,);
  }

  /*ProgressDialog progressDialog(String text, BuildContext context) {
    ProgressDialog progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    return progressDialog;
  }*/

  String formatDate(String date, String format) {
    log("Date -> $date   format -> $format");
    String formattedDate = DateFormat(format).format(DateTime.parse(date));
    //DateTime.parse(formattedString);
    print(formattedDate);
    return formattedDate;
  }

  bool validateEmail1(String value) {
    RegExp regex = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool validateEmail(String value) {
 /*   Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';*/
    RegExp regex = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return (!regex.hasMatch(value)) ? false : true;
  }

  /*Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }*/
}
