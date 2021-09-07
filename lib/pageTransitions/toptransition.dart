import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class TopTransition extends PageRouteBuilder{
  final Widget widget;
  TopTransition({this.widget})
      :super(
    // ignore: missing_required_param
      transitionDuration:Duration(seconds: 1),
      transitionsBuilder:(BuildContext context,
          Animation<double> animation,
          Animation<double> secAnimation,
          Widget child){
        animation=CurvedAnimation(
          parent: animation,
          curve: Curves.elasticInOut,
        );

        return ScaleTransition(
          alignment: Alignment.topCenter,
          scale: animation,
          child:child ,

        );
      },
      pageBuilder:(BuildContext context,Animation<double> animation,Animation<double> secAnimation){

        return widget;
      });

}