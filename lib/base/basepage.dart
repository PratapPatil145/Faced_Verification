

import 'package:flutter/cupertino.dart';

class BasePage extends StatefulWidget{

  BasePage({Key? key}) : super(key: key);

  @override
  BaseState createState(){
    print(this.runtimeType);
    return BaseState();
  }

}

class BaseState<T extends BasePage> extends State<T>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }

}