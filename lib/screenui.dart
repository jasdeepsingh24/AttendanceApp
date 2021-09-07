import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ui extends StatefulWidget {
  @override
  _uiState createState() => _uiState();
}

class _uiState extends State<ui> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.redAccent.shade100,
          body: Stack(
            children: <Widget>[
              ClipPath(
                  clipper: getClipper(),
                  child:Container(
                    color: Colors.white,
                  )

              )
            ],
          )

      ),
    );


  }


}
class getClipper extends CustomClipper<Path>{
  double radius=20;
  @override
  Path getClip(Size size)
  {

    var path=new Path();
    path.lineTo(0, size.height/2.8-100);

    var firstControl=new Offset(10 ,size.height/2.8);
    var firstEnd=new Offset(100, size.height/2.8);
    path.quadraticBezierTo(firstControl.dx, firstControl.dy ,firstEnd.dx, firstEnd.dy);

    path.lineTo(size.width/2, size.height/2.8);

    var secondControl=new Offset(size.width/2+30,size.height/2.8);
    var secondEnd=new Offset(size.width/2+30, size.height/2.8+30);
    path.quadraticBezierTo(secondControl.dx, secondControl.dy ,secondEnd.dx, secondEnd.dy);


    path.lineTo(size.width/2+30, size.height/2-60);



    var thirdControl=new Offset(size.width/2+30,size.height/2);
    var thirdEnd=new Offset(size.width/2+90, size.height/2);
    path.quadraticBezierTo(thirdControl.dx, thirdControl.dy ,thirdEnd.dx, thirdEnd.dy);

    path.lineTo(size.width/2+85, size.height/2);

    var fourthControl=new Offset(size.width/2+135,size.height/2);
    var fourthEnd=new Offset(size.width/2+130, size.height/2-60);
    path.quadraticBezierTo(fourthControl.dx, fourthControl.dy ,fourthEnd.dx, fourthEnd.dy);


    path.lineTo(size.width/2+130, size.height/2.8+30);

    var fifthControl=new Offset(size.width/2+130,size.height/2.8);
    var fifthEnd=new Offset(size.width/2+160, size.height/2.8);
    path.quadraticBezierTo(fifthControl.dx, fifthControl.dy ,fifthEnd.dx, fifthEnd.dy);


    path.lineTo(size.width, size.height/2.8);



    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)
  {
    return true;
  }
}

