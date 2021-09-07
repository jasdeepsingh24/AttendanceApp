import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(textColor: Colors.red,size: 50,),
              SizedBox(height: 20,),
              CircularProgressIndicator(backgroundColor: Colors.red,strokeWidth: 3),
              // LinearProgressIndicator(minHeight: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
