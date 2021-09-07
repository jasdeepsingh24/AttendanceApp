

import'dart:io';
// import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
// import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:mark/loading.dart';
// import 'dart:math' as math;
import 'dart:async';

import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/widgets.dart';

//Pages
// import 'package:mark/pageTransitions/bouncyPageRoute.dart';
// import 'package:mark/pageTransitions/centerTransition.dart';
// import 'package:mark/pageTransitions/sideTransition.dart';
// import 'package:mark/pageTransitions/toptransition.dart';
// import 'package:mark/teacher/teacherprofile.dart';
// import 'package:mark/services/usermanagement.dart';







class SettingsPage extends StatefulWidget {
  String userDocID;
  SettingsPage({this.userDocID});
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String firstName='';
  String lastName='';
  String photoUrl='';
  String email='';
  String rollNo='';
  String uid='';
  String role='';
  bool changed=false;

  File newProfilePic;
  var user = FirebaseAuth.instance.currentUser;
  // Future getImage() async{
  // PickedFile timage=await ImagePicker().getImage(source: ImageSource.gallery);
  //   // var tempImage=await ImagePicker().getImage(source: ImageSource.camera);
  //
  //
  //   // var tempImage=await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     newProfilePic=timage as File;
  //     print(newProfilePic.path);
  //   });
  // }
  Future getImage() async{
    var tempImage=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      newProfilePic=tempImage;
    });
  }
  // uploadImage() async{
  //   String profilepicname=FirebaseAuth.instance.currentUser.uid.toString();
  //   final StorageReference firebaseStorageRef=FirebaseStorage.instance.ref().child('profilepics/$profilepicname.jpg');
  //   final StorageUploadTask task=firebaseStorageRef.putFile(newProfilePic);
  //   task.futureComments
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((docs){
      setState(() {

        firstName=docs.documents[0].data()['details']['firstName'].toString();
        lastName=docs.documents[0].data()['details']['lastName'].toString();
        email=docs.documents[0].data()['email'].toString();
        role=docs.documents[0].data()['details']['role'].toString();
        uid=docs.documents[0].data()['uid'].toString();
      });
    }).catchError((e){
      print(e);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading:IconButton(
            padding:EdgeInsets.only(left: 15),
            icon: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 25,),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ) ,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0,bottom: 20),
                    child: Material(
                      borderRadius: BorderRadius.circular(60),
                      elevation: 10,
                      child: Stack(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5,top: 5),
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(



                                  borderRadius: BorderRadius.circular(55),
                                  color: Colors.red,
                                  image: DecorationImage(

                                    image: NetworkImage(
                                        'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1189&q=80'),
                                    fit: BoxFit.cover,
                                  )
                              ),

                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: (){
                                  getImage();
                                },
                              )
                            ),
                          )
                        ],

                      ),
                    ),
                  ),




                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('First Name  ',style: TextStyle(color: Colors.black,),),
                      Expanded(
                        child: Container(
                          
                          child: Material(

                            borderRadius: BorderRadius.circular(20),
                            elevation: 10,
                            child: Container(

                              

                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: TextFormField(

                                decoration: InputDecoration(

                                  contentPadding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
                                  border: InputBorder.none,
                                  hintText: firstName,
                                  hintStyle: TextStyle(color: Colors.redAccent,),
                                  // alignLabelWithHint: true,


                                ),
                                style: TextStyle(color: Colors.redAccent),
                                onChanged: (val){
                                  changed=true;
                                  setState(() {
                                    firstName=val;
                                    // _rollNo=val;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   height: 40,
                      //   width: 100,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //     color: Colors.grey.shade100
                      //   ),
                      //   child: TextField(
                      //     decoration: InputDecoration(hintText: firstName,hintStyle: TextStyle(color: Colors.black)),
                      //   ),
                      // ),
                      // Text(firstName),
                      // TextField(
                      //   decoration: InputDecoration(
                      //     hintText: firstName,
                      //     hintStyle: TextStyle(color: Colors.black),
                      //   ),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Last Name  ',style: TextStyle(color: Colors.black,),),
                        Expanded(
                          child: Material(

                            borderRadius: BorderRadius.circular(20),
                            elevation: 10,
                            child: Container(

                              width: 200,

                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: TextFormField(


                                decoration: InputDecoration(

                                  contentPadding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
                                  border: InputBorder.none,
                                  hintText: lastName,
                                  hintStyle: TextStyle(color: Colors.redAccent,),


                                ),
                                style: TextStyle(color: Colors.redAccent),
                                onChanged: (val){
                                  changed=true;
                                  setState(() {
                                    lastName=val;
                                    // _rollNo=val;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Email           ',style: TextStyle(color: Colors.black,),),
                        Expanded(
                          child: Material(

                            borderRadius: BorderRadius.circular(20),
                            elevation: 10,
                            child: Container(

                              width: 200,

                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: TextFormField(



                                decoration:  InputDecoration(

                                  contentPadding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
                                  border: InputBorder.none,
                                  hintText: email,
                                  hintStyle: TextStyle(color: Colors.redAccent,),



                                ),
                                style: TextStyle(color: Colors.redAccent),
                                onChanged: (val){
                                  changed=true;
                                  setState(() {
                                    email=val;
                                    // _rollNo=val;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  role=='student'?Padding(
                    padding: EdgeInsets.only(top: 20),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Roll No        ',style: TextStyle(color: Colors.black,),),
                        Expanded(
                          child: Material(

                            borderRadius: BorderRadius.circular(20),
                            elevation: 10,
                            child: Container(

                              width: 200,

                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(

                                  contentPadding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
                                  border: InputBorder.none,
                                  hintText: role,
                                  hintStyle: TextStyle(color: Colors.redAccent,),



                                ),
                                style: TextStyle(color: Colors.redAccent),
                                onChanged: (val){
                                  setState(() {
                                    rollNo=val;
                                    // _rollNo=val;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ):Container(),



                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(25),

                      child: Container(
                        height: 40,
                        width: 140,
                        // child: IconButton(
                        //   icon: Icon(Icons.done,color: Colors.black,),
                        //   onPressed: (){},
                        // ),
                        child: Center(child: Text('SAVE CHANGES',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 2),)),

                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end:Alignment.topRight,
                            colors: [Colors.white,Colors.grey.shade300],
                          ),

                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


