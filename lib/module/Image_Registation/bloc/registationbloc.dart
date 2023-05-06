import 'dart:async';
import 'dart:developer';

import '../../../../base/base_response.dart';
import '../../../../bloc/bloc.dart';
import '../model/model.dart';

import '../repository/registation_repo.dart';

class LibraryBloc extends Bloc {
  StreamController<Response<FaceDataModel>> getlibraryController =StreamController<Response<FaceDataModel>>();
  Stream<Response<FaceDataModel>> get getlibrarystream =>getlibraryController.stream;
  StreamSink<Response<FaceDataModel>> get getlibrarysink =>getlibraryController.sink;

  var repository = ImageRegLibrary();

  Future<void> insertNewData(dynamic map) async {
    getlibrarysink.add(Response.loading("Loading"));
    try {
      //print(map);
      final client = await repository.insertNewData(map);

      getlibrarysink.add(Response.completed(client));
    } catch (e) {
      getlibrarysink.add(Response.error(e.toString()));
      log("login: ${e.toString()}");
    }
  }

  @override
  void dispose() {
    getlibraryController.close();
  }
}
