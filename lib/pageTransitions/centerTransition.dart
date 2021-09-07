import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class CenterTransition extends PageRouteBuilder{
  final Widget widget;
  CenterTransition({this.widget})
      :super(
    // ignore: missing_required_param
      transitionDuration:Duration(milliseconds: 200),
      transitionsBuilder:(BuildContext context,
          Animation<double> animation,
          Animation<double> secAnimation,
          Widget child){
        animation=CurvedAnimation(
          parent: animation,
          curve: Curves.elasticInOut,
        );

        return ScaleTransition(
          alignment: Alignment.centerRight,
          scale: animation,
          child:child ,

        );
      },
      pageBuilder:(BuildContext context,Animation<double> animation,Animation<double> secAnimation){

        return widget;
      });

}