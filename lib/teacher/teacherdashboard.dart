

import 'dart:math';
// import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mark/loading.dart';
// import 'dart:math' as math;
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

//Pages
import 'package:mark/settingsPage.dart';

import 'package:mark/pageTransitions/bouncyPageRoute.dart';
import 'package:mark/pageTransitions/centerTransition.dart';
import 'package:mark/pageTransitions/sideTransition.dart';
import 'package:mark/pageTransitions/toptransition.dart';
import 'package:mark/teacher/teacherprofile.dart';
import 'package:mark/services/usermanagement.dart';
import 'subjectPage.dart';

//Time
// import 'package:time/time.dart';

//firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class TeacherDashboard extends StatefulWidget {

  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  String alert = 'Enter Class Name';
  // final GlobalKey _scaffoldKey = new GlobalKey();
  String em='';
  String className='';
  String userName = '';
  String lastName='';
  // Stream<QuerySnapshot> snapshot;
  int classCount;
  var document;
  var user = FirebaseAuth.instance.currentUser;
  Stream spq;
  DocumentSnapshot d;
  String userDocId='';
  Timer _timer;

  // getWeather() async{
  //   http.Response response=await http.get(url);
  // }
  getTime() {
    DateTime time = DateTime.now();
    if (time.hour >= 4 && time.hour <= 11) {
      return 'Good Morning';
    }
    else if (time.hour >= 12 && time.hour <= 15) {
      return 'Good Afternoon';
    }
    else if (time.hour >= 16 && time.hour <= 19) {
      return 'Good Evening';
    }
    else {
      return 'Hello';
    }
  }
  DateTime dt=DateTime.now();


  // curvedValue * 200
  Future <void> Dialog(BuildContext context,String path,String className) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
              title: Text('Are you sure'),
              content: Text('Once you delete $className Class,all your data and records will be deleted permanently'),
              actions: <Widget>[

                Center(
                  child: FlatButton(
                    child: Text('Sure', style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),),
                    onPressed: () {
                      UserManagement().deleteClassFromTeacher(path);
                      Navigator.of(context).pop();
                    },

                  ),
                ),
                Center(
                  child: FlatButton(
                    child: Text('Cancel', style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },

                  ),
                ),
              ],
              elevation: 10,
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(30)
              )
          );
        }
    );

  }
  Future <void> addDialog(BuildContext context) async {
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Enter Class Name'),
            content:TextFormField(

              // autofocus:false,
              onChanged: (val) {
                setState(() {
                  className = val;
                });
              },
            ),
            actions: <Widget>[

              Center(
                child: FlatButton(
                  child: Text('Submit', style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),),
                  onPressed: () {
                    if (className != null) {
                      UserManagement().createNewClass(className);

                      Navigator.of(context).pop();
                    }
                  },

                ),
              ),
              Center(
                child: FlatButton(
                  child: Text('Cancel', style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },

                ),
              ),
            ],
              elevation: 10,
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(30)
              )
          );
        }
      );

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    var user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((docs){


        if (docs != null)  {
          setState(() {
            userName = docs.documents[0].data()['details']['firstName'].toString();
            document=docs;
            em=docs.documents[0].data()['email'].toString();
            lastName=docs.documents[0].data()['details']['lastName'].toString();
          }
          );
        }
        userDocId=docs.documents[0].documentID;
        // d=docs as DocumentSnapshot;
        spq=FirebaseFirestore.instance.collection('/users/$userDocId/classes').snapshots() ;



      // print(d.data());

    }).catchError((e){
      print(e);
    }) ;
    _timer=Timer.periodic(Duration(seconds: 1), (timer) {
      if(dt!=DateTime.now()){
        setState(() {
          dt=DateTime.now();
        });
      }
    });

    // FirebaseFirestore.instance.collection('/users').where(
    //     'uid', isEqualTo: user.uid).getDocuments().then((docs) async {
    //       assert(docs != null);
    //
    //    name = docs.documents[0].data()['details']['firstName'].toString();
    //    _email=docs.documents[0].data()['email'].toString();
    //    // print('classes');
    //    // print(docs.documents[0].data()['classse
    //
    //
    //    // print("Name $name");
    //    if (docs != null)  {
    //      setState(() {
    //        userName = name;
    //        document=docs;
    //        em=_email;
    //      }
    //      );
    //    }
    //
    //
    // }).catchError((e) {
    //   print(e);
    // });




  }
  void dispose(){
  _timer.cancel();
    super.dispose();
  }


  Widget content(){
    return Container(
      
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: 15, right: 15, top: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(getTime(),
                      style: TextStyle(color: Colors.grey, fontSize: 20,letterSpacing: 2),),
                    Text(userName, style: TextStyle(color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),),
                  ],
                )
              ],
            ),
          ),


          SizedBox(
            height: 240,
            child: ListView.builder(
                clipBehavior:Clip.antiAliasWithSaveLayer ,
                physics:ScrollPhysics(
                  parent:BouncingScrollPhysics(),

                ),
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (BuildContext context,int index){
                  return Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),

                      child:Material(
                        elevation: 10,

                        borderRadius: BorderRadius.circular(40),
                        child:Container(

                          height: 240,
                          width: MediaQuery.of(context).size.width-30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            // color: Colors.grey.shade200,
                            color: Colors.grey.shade200,

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Stack(
                                children:[
                                  Container(
                                    height: 126,
                                    width: 126,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(65)
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 3,top:3),
                                    child: Container(
                                      height: 120,
                                      width: 120,

                                      decoration: BoxDecoration(
                                        // color: Colors.black,
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          colors: [
                                            Colors.black,Colors.black,Colors.black,Colors.black54
                                          ]
                                        ),
                                        borderRadius: BorderRadius.circular(60),


                                      ),
                                      child: Transform.rotate(
                                        angle: -pi/2,
                                        child: CustomPaint(
                                          painter: ClockPainter(context,dt),
                                        ),
                                      ),
                                    ),
                                  ),
                          ]

                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${new DateFormat.jm().format(dt)}',style: TextStyle(color: Colors.black,fontSize: 40,),),
                                    // Text('${DateFormat.jm().format(DateTime.now())}'),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ) ,
                      )
                  );
                }),
          ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          //
          //   child: Container(
          //     padding: EdgeInsets.only(left: 10),
          //     height: 200,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(40),
          //       color: Colors.grey.shade200,
          //     ),
          //   ),
          // ),
          Expanded(

            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Classes', style: TextStyle(color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),),


                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget appBar(){

    return Container(
      color: Colors.white,
      child: Padding(

        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Builder(

              builder: (BuildContext context){
                return InkWell(


                  onTap: () {

                    // _scaffoldKey.currentState.openDrawer();
                    Scaffold.of(context).openDrawer();

                    // Navigator.push(
                    //     context, SideTransition(widget: TeacherProfile()));
                  },
                  child: Container(

                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                          fit: BoxFit.cover,
                        )
                    ),
                  ),
                );
              },
            ),


            FlutterLogo(textColor: Colors.red, size: 40,),

            IconButton(
              icon: Icon(Icons.add, color: Colors.grey, size: 35,),
              onPressed: () {
                // Navigator.push(context,BouncyPageRoute(widget: addDialog(context)));
                addDialog(context);
              },),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        drawerEdgeDragWidth: 20,
        drawerScrimColor: Colors.red,
        backgroundColor: Colors.white,

        drawer: Drawer(

          // key: _scaffoldKey,
          child: ListView(

            children: <Widget>[

              UserAccountsDrawerHeader(
                // arrowColor: Colors.orange,

                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),

                  // borderRadius: BorderRadius.only(bottomRight: Radius.circular(40),bottomLeft: Radius.circular(40)),
                  color: Colors.red.shade300,
                  // image: DecorationImage(
                  //
                  //     image: NetworkImage('https://images.unsplash.com/photo-1541417904950-b855846fe074?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                  //   fit: BoxFit.cover,
                  // )
                ),
                accountName: Text('$userName $lastName'),
                accountEmail: Text(em),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                ),
              ),

              ListTile(
                title: Text('Settings'),
                onTap: (){
                  Navigator.push(context, TopTransition(
                      widget: SettingsPage(userDocID: userDocId)));

                },
              ),

              ListTile(
                title: Text('Logout'),
                onTap: (){
                  UserManagement().signOut();
                },
              ),
            ],
          ),
        ),
        // backgroundColor:Colors.white,

        body:StreamBuilder  (

          // stream: FirebaseFirestore.instance.collection('/users/${document.documents[0].documentID}/classes').snapshots(),
            stream: spq,
          builder: (BuildContext context,snapshot){
            if(!snapshot.hasData || snapshot.data.documents == null || snapshot.connectionState==ConnectionState.waiting)
              {
                return LoadingScreen();
              }

              // if(snapshot.hasData) {
              //   if(snapshot.connectionState==ConnectionState.done&& snapshot.hasData) {
              // try{
                return CustomScrollView(

                    physics: ScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    slivers: <Widget>[
                      SliverAppBar(
                        title: appBar(),
                        automaticallyImplyLeading: false,
                        expandedHeight: 460,
                        backgroundColor: Colors.white,
                        floating: true,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,

                          background: Padding(
                            padding: const EdgeInsets.only(top: 99),
                            child:content(),
                          ),

                        ),
                      ),

                      //Original Sliver list========================================


                      SliverList(

                        delegate: SliverChildBuilderDelegate(

                              (context,
                            index) =>

                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, TopTransition(
                                    widget: Subject(i: index.toString(),userDocId: userDocId,classDocID: snapshot.data.documents[index].documentID,ref:snapshot.data.documents[index].data()['ref'])));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, top: 5, bottom: 5),
                                child: new Material(
                                  // color: Colors.transparent,
                                    elevation: 10,
                                    // color: Colors.red.shade300,
                                    // color: Colors.orange,
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        gradient:LinearGradient(
                                            begin: Alignment.centerRight,
                                            end: Alignment.bottomLeft,
                                            colors: [Colors.white38, Colors.red,]),
                                        borderRadius: BorderRadius.circular(30),

                                      ),
                                      child: Center(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets
                                                    .only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Text(snapshot.data
                                                        .documents[index]
                                                        .data()['className']
                                                        .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 20),),
                                                      IconButton(
                                                        icon: Icon(Icons.delete),
                                                        onPressed: (){
                                                          Dialog(context,'/users/$userDocId/classes/${snapshot.data.documents[index].documentID}',snapshot.data.documents[index].data()['className'].toString());
                                                          // UserManagement().deleteClassFromTeacher('users/$userDocId/classes/${snapshot.data.documents[index].documentID}');
                                                        },
                                                      )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                ),
                              ),
                            ),
                          childCount: snapshot.data.documents.length,

                        ),

                      ),




                      //Original Sliver list========================================


                      // SliverList(
                      //
                      //   delegate: SliverChildBuilderDelegate(
                      //
                      //         (context,
                      //         index) =>
                      //
                      //         GestureDetector(
                      //           onTap: () {
                      //             Navigator.push(context, TopTransition(
                      //                 widget: Subject(i: index.toString(),userDocId: userDocId,classDocID: snapshot.data.documents[index].documentID,ref:snapshot.data.documents[index].data()['ref'])));
                      //           },
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(
                      //                 left: 15.0, right: 15, top: 5, bottom: 5),
                      //             child: new Material(
                      //                 // color: Colors.transparent,
                      //                   elevation: 10,
                      //                   color: Colors.deepOrange,
                      //                   // color: Colors.red.shade300,
                      //                   // color: Colors.orange,
                      //                   borderRadius: BorderRadius.circular(30),
                      //                   child: Dismissible(
                      //
                      //                     secondaryBackground:Material(
                      //                       elevation: 0,
                      //                       borderRadius: BorderRadius.circular(30),
                      //                       color: Colors.red,
                      //                       child: Row(mainAxisAlignment: MainAxisAlignment.end,
                      //                         children: [
                      //                           Text('Delete  ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                     key: Key('hi'),
                      //                     onDismissed: (direction)async {
                      //                       if(direction==DismissDirection.startToEnd){
                      //                         Navigator.push(context, TopTransition(
                      //                             widget: Subject(i: index.toString(),userDocId: userDocId,classDocID: snapshot.data.documents[index].documentID,ref:snapshot.data.documents[index].data()['ref'])));
                      //
                      //                       }
                      //                       else
                      //                         {
                      //                           await  Dialog(context);
                      //                           Scaffold.of(context).showSnackBar(new SnackBar(
                      //                             content: Text('Deleted'),
                      //                             elevation: 10,
                      //                             duration: Duration(seconds: 3),
                      //
                      //
                      //                           ));
                      //                         }
                      //
                      //
                      //                     },
                      //                     background: Material(
                      //                       elevation: 0,
                      //                       borderRadius: BorderRadius.circular(30),
                      //                       color: Colors.green,
                      //                       child: Row(mainAxisAlignment: MainAxisAlignment.start,
                      //                         children: [
                      //                           Text('  Open',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                     child: Container(
                      //                       height: 100,
                      //                       decoration: BoxDecoration(
                      //
                      //                         // gradient:LinearGradient(
                      //                         //     begin: Alignment.centerRight,
                      //                         //     end: Alignment.bottomLeft,
                      //                         //     colors: [Colors.white38, Colors.red,]),
                      //                         borderRadius: BorderRadius.circular(30),
                      //
                      //                       ),
                      //                       child: Center(
                      //                         child: Container(
                      //                           child: Column(
                      //                             mainAxisAlignment: MainAxisAlignment
                      //                                 .center,
                      //                             children: <Widget>[
                      //                               Padding(
                      //                                 padding: const EdgeInsets
                      //                                     .only(
                      //                                     left: 15, right: 15),
                      //                                 child: Row(
                      //                                   mainAxisAlignment: MainAxisAlignment
                      //                                       .spaceBetween,
                      //                                   children: <Widget>[
                      //                                     Text(snapshot.data
                      //                                         .documents[index]
                      //                                         .data()['className']
                      //                                         .toString(),
                      //                                       style: TextStyle(
                      //                                           color: Colors.white,
                      //                                           fontWeight: FontWeight
                      //                                               .bold,
                      //                                           fontSize: 20),),
                      //                                     IconButton(
                      //                                       icon: Icon(Icons.delete),
                      //                                       onPressed: (){},
                      //                                     )
                      //                                   ],
                      //                                 ),
                      //                               )
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   )
                      //               ),
                      //             // ),
                      //           ),
                      //         ),
                      //     childCount: snapshot.data.documents.length,
                      //
                      //   ),
                      //
                      // ),



                    ]

                );
              // }
              // catch(){
              //   return LoadingScreen();
              // }

                // }




          },
        )
      ),
    );
  }




}
class ClockPainter extends CustomPainter{
  final BuildContext context;
  final DateTime dateTime;
  ClockPainter(this.context,this.dateTime);

  @override
  void paint(Canvas canvas,Size size){
    double centerX=size.width/2;
    double centerY=size.height/2;
    Offset center=Offset(centerX,centerY);
    //minute line

    // double minX=centerX+size.width*0.35*cos((dateTime.minute*6)*pi/180);
    // double minY=centerY+size.width*0.35*cos((dateTime.minute*6)*pi/180);

    double minX =
        centerX + size.width * 0.35 * cos((dateTime.minute * 6) * pi / 180);
    double minY =
        centerY + size.width * 0.35 * sin((dateTime.minute * 6) * pi / 180);
    //minute line

    canvas.drawLine(center,Offset(minX,minY),Paint()..color=Colors.grey.shade300..style=PaintingStyle.stroke..strokeWidth=2);

    //hour clock

    // double hourX=centerX+size.width*0.3*cos((dateTime.hour*30+dateTime.minute*0.5)*pi/180);
    // double hourY=centerY+size.width*0.3*cos((dateTime.hour*30+dateTime.minute*0.5)*pi/180);
    double hourX = centerX +
        size.width *
            0.3 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    double hourY = centerY +
        size.width *
            0.3 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);

    //hour line

    canvas.drawLine(center,Offset(hourX,hourY),Paint()..color=Colors.red..style=PaintingStyle.stroke..strokeWidth=3);

    //Seconds calculation
    // size.width*0.4 defines line length
    //datetime.second * 6 because 360/60=6
    double secondX=centerX+size.width*0.4*cos((dateTime.second*6)*pi/180);
    double secondY=centerY+size.width*0.4*sin((dateTime.second*6)*pi/180);

    //Seconds line
    canvas.drawLine(center, Offset(secondX,secondY), Paint()..color=Colors.grey.shade300);






    //Center Dot


    Paint dotPainter=Paint()..color=Colors.white;
    canvas.drawCircle(center, 5, dotPainter);
    canvas.drawCircle(center,10,Paint()..color=Colors.grey.shade300);
    canvas.drawCircle(center, 5, dotPainter);
  }

  bool shouldRepaint(CustomPainter oldDelegate){
    return true;
  }
}




