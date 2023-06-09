

import 'dart:async';

import 'package:flutter/services.dart';

import '../bloc/bloc.dart';

class DeepLinkBloc extends Bloc {

  //Event Channel creation
  static const stream = const EventChannel('learnonchat.deeplink.flutter.dev/events');

  //Method channel creation
  static const platform = const MethodChannel('learnonchat.deeplink.flutter.dev/channel');

  StreamController<String> _stateController = StreamController();

  Stream<String> get state => _stateController.stream;

  Sink<String> get stateSink => _stateController.sink;


  //Adding the listener into contructor
  DeepLinkBloc() {
    //Checking application start by deep link
    startUri().then(_onRedirected);
    //Checking broadcast stream, if deep link was clicked in opened appication
    stream.receiveBroadcastStream().listen((d) => _onRedirected(d));
  }


  _onRedirected(dynamic uri) {
    // Here can be any uri analysis, checking tokens etc, if it’s necessary
    // Throw deep link URI into the BloC's stream
    stateSink.add(uri.toString());
  }


  @override
  void dispose() {
    _stateController.close();
  }


  Future<dynamic> startUri() async {
    try {
      return platform.invokeMethod('initialLink');
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }
}