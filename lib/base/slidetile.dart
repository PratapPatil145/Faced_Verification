

import 'package:flutter/material.dart';


class SlideTile extends StatelessWidget {
  String? imagePath, title, desc,sub;

  SlideTile({required this.imagePath, required this.title, required this.desc,required this.sub});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath!,width: 150,height: 150,),
          SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text(title!, textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline3!.copyWith(color: Color(0xff1D2B5A)),),
             Text(sub!, textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline3!.copyWith(color: Color(0xff02BAEA)),)
           ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(desc!, textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle1)
        ],
      ),
    );
  }
}