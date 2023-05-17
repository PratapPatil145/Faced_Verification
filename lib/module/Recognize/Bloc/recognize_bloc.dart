// import 'dart:async';
// import 'dart:developer';

// import '../../../../base/base_response.dart';
// import '../../../../bloc/bloc.dart';
// import '../Model/recognize_model.dart';
// import '../Repository/recognize_repo.dart';

// class RecognizeBloc extends Bloc {
//   StreamController<Response<RecognizeDataModel>> getRecognizeController =StreamController<Response<RecognizeDataModel>>();
//   Stream<Response<RecognizeDataModel>> get getrecognizestream => getRecognizeController.stream;
//   StreamSink<Response<RecognizeDataModel>> get getrecognizesink =>getRecognizeController.sink;

//   var repository = ImageRecognization();

//   Future<void> recognizeMethod(dynamic map) async {
//     getrecognizesink.add(Response.loading("Loading"));
//     try {
//       //print(map);
//       final client = await repository.recognizeface(map);
//      print("clientdata ${client}");
//       getrecognizesink.add(Response.completed(client));
//     } catch (e) {
//       getrecognizesink.add(Response.error(e.toString()));
//       log("login: ${e.toString()}");
//     }
//   }

//   @override
//   void dispose() {
//     getRecognizeController.close();
//   }
// }
