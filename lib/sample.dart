import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class FaceRecognization {
  String username = "";
  List<dynamic> responseList = [];

  Future<String> fetchAlbum(int ID) async {
    final response = await http
        .get(Uri.parse('http://50.31.147.142:821/get_Face_info/${ID}'));

    if (response.statusCode == 200) {
      responseList = jsonDecode(response.body);
      List req_resp = responseList[1];
      username = req_resp[0]["username"];
      return username;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

// class Sample extends StatefulWidget {
//   const Sample({super.key});

//   @override
//   State<Sample> createState() => _SampleState();
// }

// class _SampleState extends State<Sample> {
//   String? username1;

//   @override
//   void initState() {
//     fetchusername();
//     super.initState();
//   }

//   Future<void> fetchusername() async {
//     FaceRecognization recognition = FaceRecognization();
//     String result = await recognition.fetchAlbum(6);
//     setState(() {
//       username1 = result;
//     });
//   }


// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     title: 'Fetch Data Example',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//     home: Scaffold(
//       appBar: AppBar(
//         title: const Text('Fetch Data Example'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Text("fffffffffffff"),
//             Text("${username1}")
//             // Text(recogization.username),
//           ],
//         ),
//         // child: FutureBuilder<String>(
//         //   future: futureAlbum,
//         //   builder: (context, snapshot) {
//         //     if (snapshot.hasData) {
//         //       return Text("${recogization.username}");
//         //       //Text(snapshot.data!.username);
//         //     } else if (snapshot.hasError) {
//         //       return Text('${snapshot.error}');
//         //     }

//         //     // By default, show a loading spinner.
//         //     return const CircularProgressIndicator();
//         //   },
//         // ),
//       ),
//     ),
//   );
// }
// }