

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mark/loading.dart';
// import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/widgets.dart';

//Pages
import 'package:mark/pageTransitions/bouncyPageRoute.dart';
import 'package:mark/pageTransitions/centerTransition.dart';
import 'package:mark/pageTransitions/sideTransition.dart';
import 'package:mark/student/subjectPageStudent.dart';
import 'package:mark/teacher/teacherprofile.dart';
import 'package:mark/services/usermanagement.dart';
// import 'subjectPage.dart';

//Time
// import 'package:time/time.dart';

//firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


//pages
import 'package:mark/services/usermanagement.dart';


class StudentDashboard extends StatefulWidget {

  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  String alert = 'Enter Class Name';
  // final GlobalKey _scaffoldKey = new GlobalKey();
  String em='';
  String classCode;
  String userName = '';
  String uid='';
  // Stream<QuerySnapshot> snapshot;
  int classCount;
  var document;
  var user = FirebaseAuth.instance.currentUser;
  var userDocID;
  Stream spq;
  String rollNo='';
  String lastName;
  var list=new List();



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


  // curvedValue * 200
  Future <void> alt(BuildContext context) async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('You have already Joined this class'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
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
              title: Text('Enter Class Code'),
              content:TextFormField(

                // autofocus:false,
                onChanged: (val) {
                  setState(() {
                    classCode = val;
                  });
                },
              ),
              actions: <Widget>[

                Center(
                  child: FlatButton(
                    child: Text('Submit', style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),),
                    onPressed: () async{
                      if (classCode != null) {



                        UserManagement().addStudent(classCode,userName,em,uid,rollNo,lastName);
                        Navigator.of(context).pop();
                        // print(v);
                        // if(v==false)
                        //   {
                        //       alt(context);
                        //   }


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

    String name;
    String _email;
    String id;
    String roll;
    String ln;
    var user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((docs){
      setState(() {
        userDocID=docs.documents[0].documentID;
        spq=FirebaseFirestore.instance.collection('/users/${docs.documents[0].documentID}/classes').snapshots() ;

        name = docs.documents[0].data()['details']['firstName'].toString();
        _email=docs.documents[0].data()['email'].toString();
        id=docs.documents[0].data()['uid'].toString();
        roll=docs.documents[0].data()['rollNo'].toString();
        ln=docs.documents[0].data()['details']['lastName'].toString();

        if (docs != null)  {
          setState(() {
            userName = name;
            document=docs;
            em=_email;
            uid=id;
            rollNo=roll;
            lastName=ln;
          }
          );
        }
      });

    }).catchError((e){
      print(e);
    }) ;

    // FirebaseFirestore.instance.collection('/users').where(
    //     'uid', isEqualTo: user.uid).getDocuments().then((docs) async {
    //   assert(docs != null);
    //
    //
    //           // print('classes');
    //   // print(docs.documents[0].data()['classses'][].toString());
    //
    //
    //   // print("Name $name");
    //   if (docs != null)  {
    //     setState(() {
    //       userName = name;
    //       document=docs;
    //       em=_email;
    //       uid=id;
    //       rollNo=roll;
    //     }
    //     );
    //   }
    //
    //
    // }).catchError((e) {
    //   print(e);
    // });



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
          Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Container(
              padding: EdgeInsets.only(left: 10),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.grey.shade200,
              ),
              child: Row(
                children: <Widget>[

                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
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


            FlutterLogo(textColor: Colors.red, size: 40, ),

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
          drawerEdgeDragWidth: 100,



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
                  accountName: Text(userName),
                  accountEmail: Text(em),

                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                  ),
                ),


                ListTile(
                  title: Text('Settings'),
                  onTap: (){
                    // UserManagement().signOut();
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
          backgroundColor: Colors.white,
          body:StreamBuilder  (

            // stream: FirebaseFirestore.instance.collection('/users/${document.documents[0].documentID}/classes').snapshots(),
            stream: spq,
            builder: (BuildContext context,snapshot){
              if(!snapshot.hasData || snapshot.data.documents == null||snapshot.connectionState==ConnectionState.waiting)
              {
                return LoadingScreen();
              }

              // if(snapshot.hasData) {
              //   if(snapshot.connectionState==ConnectionState.done&& snapshot.hasData) {
              // try{
              return CustomScrollView(
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
                          child: content(),
                        ),

                      ),
                    ),
                    SliverList(

                      delegate: SliverChildBuilderDelegate((context,
                          index) =>
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                return SubjectStudent(ref: snapshot.data.documents[index].data()['classRef'],userDocId: userDocID,);
                              }));
                              // print(snapshot.data.documents[index].data()['classRef']);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 5, bottom: 5),
                              child: new Material(
                                // color: Colors.transparent,
                                  elevation: 10,
                                  // color: Colors.red.shade300,
                                  color: Colors.red.shade400,
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(

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
                                                    .start,
                                                children: <Widget>[
                                                  Text(snapshot.data
                                                      .documents[index]
                                                      .data()['className']
                                                      .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 20),)
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

                    )

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




