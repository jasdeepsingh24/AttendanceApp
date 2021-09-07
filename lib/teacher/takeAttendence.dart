import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mark/loading.dart';
import 'package:mark/services/getAttendenceInfo.dart';
// import 'package:mark/services/searchService.dart';
// import 'package:mark/services/usermanagement.dart';
//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:mark/teacher/attendenceLists.dart';


class TakeAttendence extends StatefulWidget {
  String i;
  String userDocId;
  String classDocId;
  List<attendenceListMain> listAll;
  TakeAttendence({this.i,this.userDocId,this.classDocId,this.listAll});

  @override
  _TakeAttendenceState createState() => _TakeAttendenceState();
}

class _TakeAttendenceState extends State<TakeAttendence> with SingleTickerProviderStateMixin{
  Stream st;
  int sp;
  int emptyCards=0;
  Map<String,dynamic> attendence={};
  bool left;
  DateTime dt=DateTime.now();
  bool submitted=false;
  var user=FirebaseAuth.instance.currentUser;
  var weekday=['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
  DateTime current=DateTime.now();
  var docID;
  var classDocID;
  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    setState(() {
      attendence={};
      user=user;
      docID=widget.userDocId;
      classDocID=widget.classDocId;
      st=FirebaseFirestore.instance.collection('/users/$docID/classes/$classDocID/Students').orderBy('rollNo',descending: false).snapshots();
    });
    _timer=Timer.periodic(Duration(seconds: 1), (timer) {
      if(dt!=DateTime.now()){
        setState(() {
          dt=DateTime.now();
        });
      }
    });


    // setState(() => );
    // setState(() => st=FirebaseFirestore.instance.collection('/users/${docID}/classes/${classDocID}/Students').snapshots());


  }
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CardController controller;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // title: FlutterLogo(textColor: Colors.red,size: 40,),
          // centerTitle: true,

          leading:Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 25,),
              onPressed: () {
                Navigator.of(context).pop();

              },),
          ),

        ),

        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.only(bottom: 50),
        //   child: Row(
        //
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: <Widget>[
        //       Container(
        //         height: 60,
        //         width: 60,
        //         decoration: BoxDecoration(
        //           // color: Colors.redAccent,
        //           gradient: LinearGradient(
        //               begin: Alignment.topRight,
        //               end: Alignment.bottomLeft,
        //               colors: [Colors.red, Colors.yellow]),
        //           borderRadius: BorderRadius.circular(30),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.deepOrange,
        //               blurRadius: 10,
        //               // spreadRadius: 1,
        //             ),
        //
        //           ]
        //         ),
        //         child: IconButton(
        //           icon: Icon(Icons.close,color: Colors.white,),
        //           onPressed: (){
        //             // controller.triggerLeft();
        //           },
        //         ),
        //       ),
        //       // IconButton(
        //       //   icon: Icon(Icons.close),
        //       // ),
        //
        //       Container(
        //         height:60,
        //         width: 60,
        //         decoration: BoxDecoration(
        //           // color: Colors.redAccent,
        //             gradient: LinearGradient(
        //                 begin: Alignment.topRight,
        //                 end: Alignment.bottomLeft,
        //                 colors: [Colors.blue, Colors.green]),
        //           borderRadius: BorderRadius.circular(30),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.blueAccent,
        //               blurRadius: 10,
        //               // spreadRadius: 1,
        //             ),
        //           ]
        //         ),
        //         child: IconButton(
        //           icon: Icon(Icons.done_outlined,color: Colors.white,),
        //           onPressed: (){
        //
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        body: StreamBuilder(

          stream: st,
          builder: (context,snapshot){

            int l=snapshot.data.documents.length;
            if(!snapshot.hasData || snapshot.data.documents == null || snapshot.connectionState==ConnectionState.waiting)
            {
              return LoadingScreen();
            }
            if(l==0)
              {
                return Center(
                  child: Text('You need to add Students first',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                );
              }

                return Stack(
                  children: [
                    Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            submitted==true?Icon(Icons.done_outlined,color: Colors.green,size: 40,):Container(),
                            SizedBox(height: 20,),
                            submitted==false?Text('Submit Attendence Record',style:TextStyle(fontWeight: FontWeight.bold)):Text('Submitted Successfully',style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),),
                            SizedBox(height: 8,),
                            submitted==false?InkWell(

                              onTap: (){
                                print(attendence);
                                // FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((doc){
                                //   var docID=doc.documents[0].documentID;
                                //   FirebaseFirestore.instance.collection('/users/${docID}/classes').getDocuments().then((classDoc){
                                //     var classDocID=classDoc.documents[int.parse(widget.i)].documentID;
                                    FirebaseFirestore.instance.collection('/users/$docID/classes/$classDocID/Attendence').add({'attendence':attendence,'dateTime':dt});

                                //   }).catchError((e){
                                //     print(e);
                                //   });
                                //
                                // }).catchError((e){
                                //   print(e);
                                // });
                                setState(() {
                                  submitted=true;
                                });


                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(30),
                                child: Container(

                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(child: Text('SUBMIT',style: TextStyle(color: Colors.white),)),
                                ),
                              ),
                            ):Container(),

                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 100),
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: new TinderSwapCard(
                        swipeUp: true,
                        swipeDown: true,
                        animDuration: 50,
                        allowVerticalMovement: false,
                        orientation: AmassOrientation.TOP,
                        totalNum: snapshot.data.documents.length,

                        stackNum: 3,
                        swipeEdge: 3.0,
                        maxWidth: MediaQuery.of(context).size.width * 0.8,
                        maxHeight: MediaQuery.of(context).size.width * 0.95,
                        minWidth: MediaQuery.of(context).size.width * 0.7,
                        minHeight: MediaQuery.of(context).size.width * 0.9,
                        cardBuilder: (context, index) => Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(45),
                          child:Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,

                                      colors: [Colors.white, getAttendenceList().getAttendenceColors(snapshot.data.documents[index].data()['uid'], widget.listAll)]),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                child: Center(

                                  child: Padding(

                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            CircleAvatar(

                                              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80'),
                                              minRadius: 40,
                                              maxRadius: 60,
                                            ),
                                            SizedBox(height: 10,),
                                            Text(snapshot.data.documents[index].data()['studentName'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color:Colors.black),),
                                            Text(snapshot.data.documents[index].data()['lastName'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color:Colors.black),),

                                          ],
                                        ),
                                        // SizedBox(height: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            // Text('hi'),
                                                    Text('${getAttendenceList().getAttendencePercentage(snapshot.data.documents[index].data()['uid'].toString(), widget.listAll)}%',style: TextStyle(color:Colors.black,fontSize: 16,letterSpacing: 2,fontWeight: FontWeight.bold),),

                                            Text('ROLL NO',style: TextStyle(fontSize: 20,color: Colors.white38,fontWeight: FontWeight.bold),),
                                            Text(snapshot.data.documents[index].data()['rollNo'].toString(),style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.bold),),
                                            // Text('EMAIL',style: TextStyle(fontSize: 20,color: Colors.grey.shade500,fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text('EMAIL',style: TextStyle(fontSize: 20,color: Colors.white38,fontWeight: FontWeight.bold),),
                                            // Text(snapshot.data.documents[index].data()['rollNo'].toString(),style: TextStyle(fontSize: 20),),
                                            Text(snapshot.data.documents[index].data()['email'].toString(),style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.bold),),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: left==false?Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 30,top:70),
                                      child: Text('P',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),
                                    ),
                                  ],
                                ):Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(left: 30,top: 70),
                                        child: Text('A',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),)
                                    ),
                                  ],
                                ),
                              )
                            ],

                          ),
                        ),
                        cardController: controller = CardController(),
                        swipeUpdateCallback:
                            (DragUpdateDetails details, Alignment align) {
                          /// Get swiping card's alignment
                          if (align.x < 0) {

                            setState(() {
                              left=true;
                            });
                            //Card is LEFT swiping
                          } else if (align.x > 0) {
                            //Card is RIGHT swiping
                            setState(() {
                              left=false;
                            });

                          }
                        },
                        swipeCompleteCallback:
                            (CardSwipeOrientation orientation, int index) {
                          /// Get orientation & index of swiped card!
                          ///
                          Map<String,dynamic> sta={
                            snapshot.data.documents[index].data()['rollNo'].toString():{
                              'studentName':snapshot.data.documents[index].data()['studentName'].toString(),
                              'rollNo':snapshot.data.documents[index].data()['rollNo'].toString(),
                              'attendence':orientation==CardSwipeOrientation.LEFT?'Absent':'Present',
                              'uid':snapshot.data.documents[index].data()['uid'].toString(),
                              'lastName':snapshot.data.documents[index].data()['lastName'].toString(),
                            }
                          };


                          // print(attendence);
                          setState(() {
                            attendence={}..addAll(attendence)..addAll(sta);
                            left=null;
                          });

                          // print('orientation $orientation ${snapshot.data.documents[index].data()['email'].toString()}');

                        },
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          // Text('${DateFormat.yMd().format(DateTime.now())}'),
                          Text('${DateFormat.yMd().format(dt)}',style: TextStyle(color: Colors.black,fontSize: 17),),
                          // Text('${DateFormat.jm().format(dt)}',style: TextStyle(color: Colors.black,fontSize: 17),),
                          Text('${weekday[current.weekday-1]}',style: TextStyle(color: Colors.black,letterSpacing: 2,fontSize: 22,fontWeight: FontWeight.bold),),
                          // Text('${current.hour}:${current.minute}',style: TextStyle(color: Colors.black,fontSize: 17),),
                          Text('${DateFormat.jm().format(dt)}',style: TextStyle(color: Colors.black,fontSize: 17),),
                        ],
                      ),
                    ),

                  ],
                );



          },

        ),
      ),
    );
  }
}
