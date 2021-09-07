import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BouncyPageRoute extends PageRouteBuilder{
  final Widget widget;
  BouncyPageRoute({this.widget})
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
        alignment: Alignment.bottomRight,
        scale: animation,
        child:child ,

      );
    },
    pageBuilder:(BuildContext context,Animation<double> animation,Animation<double> secAnimation){

      return widget;
    });

}