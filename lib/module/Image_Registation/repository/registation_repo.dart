import 'dart:convert';
import 'dart:developer';

import '../../../base/api_constants.dart';
import '../../../base/base_httpcall.dart';
import '../model/model.dart';
import 'package:http/http.dart' as http;

class ImageRegLibrary {
  Future<dynamic> insertNewData(dynamic body) async {
    BaseHTTP baseHTTP = BaseHTTP();
    final response =
        await baseHTTP.postWithBody2(ApiConstants.REGISTATION_URL, body);
    log("Image Registation_ ${response}");

    print("libraryresponse ${response}");

    return FaceDataModel.fromJson(response);
  }
}
