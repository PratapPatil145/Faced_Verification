import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

import 'package:http_parser/http_parser.dart';

import 'custom_exception.dart';

enum RequestType { POST, GET }

class BaseHTTP {
  static final BaseHTTP _baseHTTP = BaseHTTP._internal();

  // OtpRepository otpRepository = OtpRepository();

  factory BaseHTTP() {
    return _baseHTTP;
  }

  BaseHTTP._internal();

//   Future<dynamic> get(String url1) async {
//    var token = SharedPrefrence().getToken();
//     //log("$token");
//     Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
//     log("Get[BASE_HTTP] -> $url1");
//     var responseJson;
//     try {
// //      var token = SharedSellerPrefrences().getToken();
// //      log("$token");
// //      Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};

//       var url = Uri.parse(url1);
//       final response = await http.get(url, headers: requestHeaders);
//       log("Body -> ${response.body}  Code -> ${response.statusCode}");
//       if (response.statusCode == 401) {
//         log("GOT 401 ERROR");
//         //var newToken = await refreshToken();
//         requestHeaders['Authorization'] = 'Bearer $token';
//         responseJson = _response(await http.get(url, headers: requestHeaders));
//       } else{
//         log("${response.body}");
//         responseJson = _getresponse(response);
//       }
//     } catch (e) {
//       /*on SocketException {*/
//       log(e.toString());
//       throw FetchDataException('No Internet connection');
//     }
//     return responseJson;
//   }

  Future<dynamic> getwithoutqueryparams(String url1) async {
    //log("$token");
    log("Get[BASE_HTTP] -> $url1");
    var responseJson;
    try {
      Map<String, String> requestHeaders = {
        "Accept": "application/json",
        "content-type": "application/json",
      };
      var url = Uri.parse(url1);
      final response = await http.get(url, headers: requestHeaders);
      log("Body -> ${response.body}  Code -> ${response.statusCode}");
      if (response.statusCode == 401) {
        log("GOT 401 ERROR");
        responseJson = _response(await http.get(url));
      } else
        responseJson = _response(response);
    } catch (e) {
      /*on SocketException {*/
      log(e.toString());
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

//   Future<dynamic> post(String url1) async {
//     log("Base http -> $url1");
//     var responseJson;
//     log(url1);

//     try {
// //      var token = SharedSellerPrefrences().getToken();
// //      log("$token");
// //      Map<String, String> requestHeaders = {
// //        'Authorization': 'Bearer $token'
// //      };
//       var token = SharedPrefrence().getToken();
// //      log("$token");
//       Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
//       var url = Uri.parse(url1);
//       final response = await http.post(url, headers: requestHeaders);
//       log('${response.statusCode}  Body ${response.body}');
//       if (response.statusCode == 401) {
//         log("GOT 401 ERROR");
//         //var newToken = await refreshToken();
//         requestHeaders['Authorization'] = 'Bearer $token';
//         responseJson = _response(await http.post(url, headers: requestHeaders));
//       } else
//         responseJson = _response(response);

//       log('${response.statusCode}  Body ${response.body}');
//     } on SocketException {
//       throw FetchDataException('No Internet connection');
//     }
//     return responseJson;
//   }

//   Future<dynamic> getWithqueryparameters1(String url1, Map<String,dynamic> body) async {
//     log("$body $url1");
//     var responseJson;
//     try {
// //      var token = SharedSellerPrefrences().getToken();
// //      log("$token");
//      Map<String, String> requestHeaders = {
//        'Content-Type': 'application/json;charset=UTF-8',
//        'Charset': 'utf-8'
//      };

//       var urlencoded = Uri.https(ApiConstants.BASE_URL1,url1,body);
//       print("urlencoded: $urlencoded");
//       final response = await http.get(urlencoded,headers: requestHeaders);
//       if (response.statusCode == 401) {
//         //var newToken = await refreshToken();
//         //requestHeaders['Authorization'] = 'Bearer $newToken';
//         var url = Uri.parse(url1);
//         responseJson = _response1(await http.post(url, body: body));
//       } else
//         responseJson = _response1(response);
//     } /*catch(e){
//       print("Erroe: ${e.toString()}");*/
//     on SocketException {
//       throw FetchDataException('No Internet connection');
//     }
//     /*}*/
//     return responseJson;
//   }

//   Future<dynamic> getWithqueryparameters(String url1, Map<String,dynamic> body) async {
//     log("$body $url1");
//     var responseJson;
//     try {
// //      var token = SharedSellerPrefrences().getToken();
// //      log("$token");

//       var urlencoded = Uri.https(ApiConstants.BASE_URL1,url1,body);
//       print("urlencoded: $urlencoded");
//       final response = await http.get(urlencoded);
//       if (response.statusCode == 401) {
//         //var newToken = await refreshToken();
//         //requestHeaders['Authorization'] = 'Bearer $newToken';
//         var url = Uri.parse(url1);
//         responseJson = _response(await http.post(url, body: body));
//       } else
//         responseJson = _response(response);
//     } /*catch(e){
//       print("Erroe: ${e.toString()}");*/
//       on SocketException {
//       throw FetchDataException('No Internet connection');
//     }
//     /*}*/
//     return responseJson;
//   }

  Future<dynamic> postWithURLEncoded(String url1, body) async {
    log("$body $url1");
    var responseJson;
    try {
//      var token = SharedSellerPrefrences().getToken();
//      log("$token");

      var url = Uri.parse(url1);
      final response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: body);
      if (response.statusCode == 401) {
        //var newToken = await refreshToken();
        //requestHeaders['Authorization'] = 'Bearer $newToken';
        responseJson = _response(await http.post(url, body: body));
      } else {
        print("response ${response.body.toString()}");
        responseJson = _response(response);
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  // Future<dynamic> putWithURLEncoded(String url1,body) async {
  //   log("$body $url1");
  //   var responseJson;
  //   try {
  //    var token = SharedPrefrence().getToken();
  //    log("$token");
  //     var url = Uri.parse(url1);
  //     final response = await http.put(url,headers: {
  //       "Accept": "application/json",
  //       "content-type":"application/json",
  //       'Authorization': 'Bearer $token'
  //     }, body: body);
  //     if (response.statusCode == 401) {
  //       var newToken = await refreshToken();
  //       //requestHeaders['Authorization'] = 'Bearer $newToken';
  //       responseJson = _response(await http.put(url, body: body,headers: {
  //         'Authorization': 'Bearer $newToken'
  //       }));
  //     } else{
  //       print("response ${response.statusCode}");
  //       responseJson = _response(response);
  //     }

  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  //   return responseJson;
  // }
  Future<dynamic> postWithURL(String url1, body) async {
    log("$body $url1");
    var responseJson;
    try {
//      var token = SharedSellerPrefrences().getToken();
//      log("$token");
//      Map<String, String> requestHeaders = {
//        'Authorization': 'Bearer $token'
//      };
      var url = Uri.parse(url1);
      final response = await http.post(url, body: body);
      if (response.statusCode == 401) {
        //var newToken = await refreshToken();
        //requestHeaders['Authorization'] = 'Bearer $newToken';
        responseJson = _response(await http.post(url, body: body));
      } else
        responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postWithBody2(String url1, dynamic body) async {
    log("$url1  yyyyyyyyyyyyyy:::$body");
    var responseJson;

    try {
      //For Testing
      // var expToken =
      //     "Bearer_eyJhbGciOiJSUzI1NiIsImtpZBzMk1hc3RlckFwaXMiXSwiY2xpZW50X2lkIjoiQkhSSEFwcCIsInN1YiI6IjE3NjMiLCJhdXRoX3RpbWUiOjE2MDcxNDk2OTksImlkcCI6ImxvY2FsIiwiQ29udGFjdE5vIjoiODg2MDIxOTk4OCIsIkJyYW5jaElkIjoiNzkiLCJSYW5rSWQiOiIyMDQiLCJBcHBUeXBlSWQiOiIxMiIsIkZ1bGxOYW1lIjoiRElXQUtBUiBQQU5ERVkgICIsImVtYWlsIjoiZGl3YWthckBzaXNpbmRpYS5jb20iLCJab25lIjoiMyIsIlJlZ2lvbiI6IjE0IiwiUmVnaW9uQ29kZSI6IjI0IiwiQnJhbmNoZXMiOiI3OSIsIkJyYW5jaGVDb2RlcyI6IkJSMDAwMTczIiwiQ2x1c3RlcnMiOiIxLDIiLCJVc2VyVHlwZSI6ImVtcGxveWVlIiwiRW1wbG95ZWVJZCI6IjgyNzczIiwiRW1wbG95ZWVObyI6IlBBVDA1NTg2MSIsIkxhbmd1YWdlSWQiOiIxIiwiQ29tcGFueUlkIjoiMSIsIk9wc1Jldmlld1dlYkFwcCI6IkJIIiwiaU9wc1JPQ0NXZWJBcHAiOiJST0NDIiwibmFtZSI6IkRJV0FLQVIgUEFOREVZICAiLCJCSFJIQXBwIjoiQkgiLCJUb2tlblR5cGUiOiJKV1QiLCJUb2tlbklkIjoiOGE4NDYyNzU5NDVkNDViM2JmMzNkZGRkMjU5NDhjNmEiLCJzY29wZSI6WyJCSFJIQXBpcyIsImlPcHMyQXBpcyIsImlPcHMyR1BTQXBpcyIsImlPcHMyTWFzdGVyQXBpcyJdLCJhbXIiOlsiQ3VzdG9tIl19.M315tcyPhUDr4tEwNHv6Lq4ju9ZJ-ytrXuHtQKcwMT9bpF7ZtFG-eQ1vu35M6TfRI6MtOd4mYrldg0fOpzRf5ElF9jFjz_zL34wVAG9NPMHX28efIUC89xuSw2xmcGb51ofDe8qk8UbSQud3B2I8klph2L53AFCNYEHLY-KnULKIirIAlqJkXhE54Q6c7npZbV4sQD8BDCaWvOGR8KBJ4gWn78VngF0xbVE4PoBGWZ5KbiKtiGj_CxrDwHx_SCC7M6gJ78cO4vHVealafM5ASSPOUe_GNpFSax2OvgL3TwnQN0OF51Rf0NcKSfO-IpPP0ehpKFrHyMGSnsolI2b6SQ";
      //var token = SharedPrefrence().getToken();
      //log("$token");
      Map<String, String> requestHeaders = {
        "Accept": "application/json",
        "content-type": "application/json",
        /*"content-type":"application/json",*/
//'Authorization': 'Bearer $token'
        //'Authorization': 'Bearer $expToken'
      };
      // if(BHRHSharedPrefrence().hasRefreshToken())
      //   requestHeaders['Authorization'] = 'Bearer $expToken';
      // log(requestHeaders.toString());
      var url = Uri.parse(url1);
      final response =
          await http.post(url, body: body, headers: requestHeaders);

      //log(response.statusCode.toString());
      if (response.statusCode == 401) {
        log("GOT 401 ERROR");
        // var newToken = await refreshToken();
        // requestHeaders['Authorization'] = 'Bearer $newToken';
        // log("venki ${requestHeaders}");
        responseJson = _response(await http.post(url, body: body));
      } else
        responseJson = _response(response);
      print("libraryresponse ${response}");
      print("what in this${responseJson}");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
    // List list = [responseJson, CodeStatus];
    // return list;
  }

  // Future<dynamic> putWithBody2(String url1, dynamic body) async {
  //   log("$url1 $body");
  //   var responseJson;
  //   try {
  //     //For Testing
  //     // var expToken =
  //     //     "Bearer_eyJhbGciOiJSUzI1NiIsImtpZBzMk1hc3RlckFwaXMiXSwiY2xpZW50X2lkIjoiQkhSSEFwcCIsInN1YiI6IjE3NjMiLCJhdXRoX3RpbWUiOjE2MDcxNDk2OTksImlkcCI6ImxvY2FsIiwiQ29udGFjdE5vIjoiODg2MDIxOTk4OCIsIkJyYW5jaElkIjoiNzkiLCJSYW5rSWQiOiIyMDQiLCJBcHBUeXBlSWQiOiIxMiIsIkZ1bGxOYW1lIjoiRElXQUtBUiBQQU5ERVkgICIsImVtYWlsIjoiZGl3YWthckBzaXNpbmRpYS5jb20iLCJab25lIjoiMyIsIlJlZ2lvbiI6IjE0IiwiUmVnaW9uQ29kZSI6IjI0IiwiQnJhbmNoZXMiOiI3OSIsIkJyYW5jaGVDb2RlcyI6IkJSMDAwMTczIiwiQ2x1c3RlcnMiOiIxLDIiLCJVc2VyVHlwZSI6ImVtcGxveWVlIiwiRW1wbG95ZWVJZCI6IjgyNzczIiwiRW1wbG95ZWVObyI6IlBBVDA1NTg2MSIsIkxhbmd1YWdlSWQiOiIxIiwiQ29tcGFueUlkIjoiMSIsIk9wc1Jldmlld1dlYkFwcCI6IkJIIiwiaU9wc1JPQ0NXZWJBcHAiOiJST0NDIiwibmFtZSI6IkRJV0FLQVIgUEFOREVZICAiLCJCSFJIQXBwIjoiQkgiLCJUb2tlblR5cGUiOiJKV1QiLCJUb2tlbklkIjoiOGE4NDYyNzU5NDVkNDViM2JmMzNkZGRkMjU5NDhjNmEiLCJzY29wZSI6WyJCSFJIQXBpcyIsImlPcHMyQXBpcyIsImlPcHMyR1BTQXBpcyIsImlPcHMyTWFzdGVyQXBpcyJdLCJhbXIiOlsiQ3VzdG9tIl19.M315tcyPhUDr4tEwNHv6Lq4ju9ZJ-ytrXuHtQKcwMT9bpF7ZtFG-eQ1vu35M6TfRI6MtOd4mYrldg0fOpzRf5ElF9jFjz_zL34wVAG9NPMHX28efIUC89xuSw2xmcGb51ofDe8qk8UbSQud3B2I8klph2L53AFCNYEHLY-KnULKIirIAlqJkXhE54Q6c7npZbV4sQD8BDCaWvOGR8KBJ4gWn78VngF0xbVE4PoBGWZ5KbiKtiGj_CxrDwHx_SCC7M6gJ78cO4vHVealafM5ASSPOUe_GNpFSax2OvgL3TwnQN0OF51Rf0NcKSfO-IpPP0ehpKFrHyMGSnsolI2b6SQ";
  //     var token = SharedPrefrence().getToken();
  //     log("$token");
  //     Map<String, String> requestHeaders = {
  //       "Accept": "application/json",
  //       "content-type":"application/json",
  //       /*"content-type":"application/json",*/
  //       'Authorization': 'Bearer $token'
  //       //'Authorization': 'Bearer $expToken'
  //     };
  //     // if(BHRHSharedPrefrence().hasRefreshToken())
  //     //   requestHeaders['Authorization'] = 'Bearer $expToken';
  //     // log(requestHeaders.toString());
  //     var url = Uri.parse(url1);
  //     final response = await http.put(url, body: body, headers: requestHeaders);

  //     //log(response.statusCode.toString());
  //     if (response.statusCode == 401) {
  //       log("GOT 401 ERROR");
  //       var newToken = await refreshToken();
  //       requestHeaders['Authorization'] = 'Bearer $newToken';
  //       log("venki ${requestHeaders}");
  //       responseJson = _response(await http.put(url, body: body, headers: requestHeaders));
  //     } else
  //       responseJson = _response(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  //   return responseJson;
  // }

  // Future<dynamic> postWithQueryParameter(String url1, Map<String,String> body) async {
  //   log("$url1 $body");
  //   var responseJson;
  //   try {
  //     //For Testing
  //     // var expToken =
  //     //     "Bearer_eyJhbGciOiJSUzI1NiIsImtpZBzMk1hc3RlckFwaXMiXSwiY2xpZW50X2lkIjoiQkhSSEFwcCIsInN1YiI6IjE3NjMiLCJhdXRoX3RpbWUiOjE2MDcxNDk2OTksImlkcCI6ImxvY2FsIiwiQ29udGFjdE5vIjoiODg2MDIxOTk4OCIsIkJyYW5jaElkIjoiNzkiLCJSYW5rSWQiOiIyMDQiLCJBcHBUeXBlSWQiOiIxMiIsIkZ1bGxOYW1lIjoiRElXQUtBUiBQQU5ERVkgICIsImVtYWlsIjoiZGl3YWthckBzaXNpbmRpYS5jb20iLCJab25lIjoiMyIsIlJlZ2lvbiI6IjE0IiwiUmVnaW9uQ29kZSI6IjI0IiwiQnJhbmNoZXMiOiI3OSIsIkJyYW5jaGVDb2RlcyI6IkJSMDAwMTczIiwiQ2x1c3RlcnMiOiIxLDIiLCJVc2VyVHlwZSI6ImVtcGxveWVlIiwiRW1wbG95ZWVJZCI6IjgyNzczIiwiRW1wbG95ZWVObyI6IlBBVDA1NTg2MSIsIkxhbmd1YWdlSWQiOiIxIiwiQ29tcGFueUlkIjoiMSIsIk9wc1Jldmlld1dlYkFwcCI6IkJIIiwiaU9wc1JPQ0NXZWJBcHAiOiJST0NDIiwibmFtZSI6IkRJV0FLQVIgUEFOREVZICAiLCJCSFJIQXBwIjoiQkgiLCJUb2tlblR5cGUiOiJKV1QiLCJUb2tlbklkIjoiOGE4NDYyNzU5NDVkNDViM2JmMzNkZGRkMjU5NDhjNmEiLCJzY29wZSI6WyJCSFJIQXBpcyIsImlPcHMyQXBpcyIsImlPcHMyR1BTQXBpcyIsImlPcHMyTWFzdGVyQXBpcyJdLCJhbXIiOlsiQ3VzdG9tIl19.M315tcyPhUDr4tEwNHv6Lq4ju9ZJ-ytrXuHtQKcwMT9bpF7ZtFG-eQ1vu35M6TfRI6MtOd4mYrldg0fOpzRf5ElF9jFjz_zL34wVAG9NPMHX28efIUC89xuSw2xmcGb51ofDe8qk8UbSQud3B2I8klph2L53AFCNYEHLY-KnULKIirIAlqJkXhE54Q6c7npZbV4sQD8BDCaWvOGR8KBJ4gWn78VngF0xbVE4PoBGWZ5KbiKtiGj_CxrDwHx_SCC7M6gJ78cO4vHVealafM5ASSPOUe_GNpFSax2OvgL3TwnQN0OF51Rf0NcKSfO-IpPP0ehpKFrHyMGSnsolI2b6SQ";
  //     var token = SharedPrefrence().getToken();
  //     log("$token");
  //     Map<String, String> requestHeaders = {
  //       "Authorization":"Bearer ${token}"
  //       //'Authorization': 'Bearer $expToken'
  //     };
  //     var url = Uri.parse(url1);
  //     url = url.replace(queryParameters: body);
  //     final response = await http.post(url, body: body, headers: requestHeaders);

  //     //log(response.statusCode.toString());
  //     if (response.statusCode == 401) {
  //       log("GOT 401 ERROR");
  //       var newToken = await refreshToken();
  //       requestHeaders['Authorization'] = 'Bearer $newToken';
  //       log("venki ${requestHeaders}");
  //       responseJson = _response(
  //           await http.post(url, body: body, headers: requestHeaders));
  //     } else
  //       responseJson = _response(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  //   return responseJson;
  // }

  // Future<dynamic> multipartWithParameter(String url, File file,
  //     Map<String, String> parameters) async {
  //   log("$url $parameters");
  //   var responseJson;
  //   try {
  //     var token = SharedPrefrence().getToken();
  //    Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};

  //     final request = http.MultipartRequest('POST', Uri.parse(url));
  //     request.headers.addAll(requestHeaders);
  //     request.fields.addAll(parameters);

  //     request.files.add(await http.MultipartFile.fromPath('file', file.path,
  //         contentType: MediaType(
  //             'image', file.path.substring(file.path.lastIndexOf('.') + 1))));

  //     final response = await http.Response.fromStream(await request.send());
  //     if (response.statusCode == 401) {
  //       var newToken = await refreshToken();
  //       //request.headers[];
  //       request.headers['Authorization'] = 'Bearer $newToken';
  //       responseJson =
  //           _response(await http.Response.fromStream(await request.send()));
  //     } else
  //       responseJson = _response(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  //   return responseJson;
  // }

  // Future<String?> refreshToken() async {
  //   log("Getting... Refresh Token");
  //   TokenModel tokenResponse = await otpRepository.gettoken();
  //   //log("Body -> ${tokenResponse.body}  Code -> ${tokenResponse.statusCode}");
  //   log(" StatusCode -> ${tokenResponse.token} New Token Generated and Here is the New Refresh Token -> ${tokenResponse.token}");
  //   if (tokenResponse != null && tokenResponse.token != null) {
  //     SharedPrefrence().setToken(tokenResponse.token!);
  //     return tokenResponse.token;
  //   } else
  //     throw FetchDataException('Unable to refetch Token');
  // }
}

class TaskhopsApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      data.headers[HttpHeaders.contentTypeHeader] = "application/json";
    } catch (e) {
      print(e);
    }
    print(data.params);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}

dynamic _response1(http.Response response) async {
  switch (response.statusCode) {
    case 200:
      var responseJson = await json.decode(json.encode(response.body));
      print("otp: $responseJson");
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:

    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:

    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}

dynamic _getresponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = response.body;
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:

    case 403:
      throw UnauthorisedException(response.body.toString());
    case 404:
      throw FetchDataException(response.body.toString());
    case 500:

    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}

dynamic _response(http.Response response) {
  switch (response.statusCode) {
    case 200:

      // if(json.decode(response.body) is String ){
      //   return response.body.toString();

      // }
      print("Hhhhhhhhhhhhhhhhhhhh ${response.body}");
      var responseJson = json.decode(response.body.toString());

      return responseJson;
    case 400:
      throw BadRequestException(json.decode(response.body.toString()));
    case 401:

    case 403:
      throw UnauthorisedException(response.body.toString());
    case 404:
      throw FetchDataException(response.body.toString());
    // case 500:

    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
