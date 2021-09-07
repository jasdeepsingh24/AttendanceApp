import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mark/loading.dart';
import 'package:mark/services/getAttendenceInfo.dart';
// import 'package:mark/services/searchService.dart';
import 'package:mark/services/usermanagement.dart';
//firebase

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mark/teacher/attendenceLists.dart';



class TotalStudents extends StatefulWidget {
  String i;
  String userDocID;
  String classDocID;
  String ref;

  List<attendenceListMain> listAll;
  TotalStudents({this.i,this.userDocID,this.classDocID,this.ref,this.listAll});
  @override
  _TotalStudentsState createState() => _TotalStudentsState();

}


class _TotalStudentsState extends State<TotalStudents> {

  var docID;
  var classDocID;
  Stream st;

  var queryResultSet = [];
  var tempSearchStore = [];
  String studentPath='';
  String studentClassPath='';
  int totalStudents=0;

  // initiateSearch(value) {
  //   if (value.length == 0) {
  //     setState(() {
  //       queryResultSet = [];
  //       tempSearchStore = [];
  //       l=0;
  //     });
  //   }
  //
  //   var capitalizedValue =
  //       value.substring(0, 1).toUpperCase() + value.substring(1);
  //
  //   if (queryResultSet.length == 0 && value.length == 1) {
  //     // var user=FirebaseAuth.instance.currentUser;
  //     //  FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((doc)async{
  //     //   var docID=doc.documents[0].documentID;
  //     //   await FirebaseFirestore.instance.collection('/users/${docID}/classes').getDocuments().then((classDoc)async{
  //     //     var classDocID=classDoc.documents[int.parse(widget.i)].documentID;
  //     //     await FirebaseFirestore.instance.collection('/users/${docID}/classes/${classDocID}/Students').where('searchKey',isEqualTo: value.substring(0,1).toUpperCase()).getDocuments().then((QuerySnapshot docs) {
  //     //       for (int i= 0; i < docs.documents.length; ++i) {
  //     //         queryResultSet.add(docs.documents[i].data()['studentName'].toString());
  //     //         setState(() {
  //     //           l=1;
  //     //         });
  //     //         print(queryResultSet[i]['studentName'].toString());
  //     //         // print();
  //     //       }
  //     //
  //     //     });
  //     //
  //     //   }).catchError((e){
  //     //     print(e);
  //     //   });
  //     //
  //     // }).catchError((e){
  //     //   print(e);
  //     // });
  //   //   SearchService().searchByName(value,int.parse(widget.i)).then((QuerySnapshot docs) {
  //   //     for (int i = 0; i < docs.documents.length; ++i) {
  //   //       queryResultSet.add(docs.documents[i].data()['studentName']);
  //   //       setState(() {
  //   //         l=1;
  //   //       });
  //   //       print(queryResultSet[i]['studentName'].toString());
  //   //       print('hello');
  //   //     }
  //   //
  //   //   });
  //   } else {
  //     tempSearchStore = [];
  //     queryResultSet.forEach((element) {
  //       if (element['studentName'].startsWith(capitalizedValue)) {
  //         setState(() {
  //           tempSearchStore.add(element);
  //           l=2;
  //         });
  //       }
  //     });
  //   }
  // }





  // var user=FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var user=FirebaseAuth.instance.currentUser;

    setState(() {
      u=widget.ref;
      var docID=widget.userDocID;
      var classDocID=widget.classDocID;
      studentPath='/users/${widget.userDocID}/classes/${widget.classDocID}/Students';
      studentClassPath='/users/${widget.userDocID}/classes/${widget.classDocID}';
      // st=FirebaseFirestore.instance.collection('/users/$docID/classes/$classDocID/Students').orderBy('rollNo',descending: false).snapshots();
      // st=FirebaseFirestore.instance.collection('/users/$docID/classes/$classDocID/Students').snapshots();
    });


    // FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((doc){
    //   var docID=doc.documents[0].documentID;
    //   FirebaseFirestore.instance.collection('/users/${docID}/classes').getDocuments().then((classDoc){
    //     var classDocID=classDoc.documents[int.parse(widget.i)].documentID;
    //     setState(() => st=FirebaseFirestore.instance.collection('/users/${docID}/classes/${classDocID}/Students').snapshots());
    //
    //   }).catchError((e){
    //     print(e);
    //   });
    //
    // }).catchError((e){
    //   print(e);
    // });

    // String code;
    // int x=int.parse(widget.i);
    // FirebaseFirestore.instance.collection('/users/$docID/classes').getDocuments().then((docum){
    //   code=docum.documents[x].data()['ref'].toString();
    //   // print(code);
    //   setState(() {
    //     u=code;
    //   });
    // }).catchError((e){
    //   print(e);
    // });
    // FirebaseFirestore.instance.collection('/users').where('uid',isEqualTo: user.uid).getDocuments().then((docs){
    //   FirebaseFirestore.instance.collection('/users/${docs.documents[0].documentID}/classes').getDocuments().then((docum){
    //     code=docum.documents[x].data()['ref'].toString();
    //     // print(code);
    //         setState(() {
    //           u=code;
    //         });
    //   }).catchError((e){
    //     print(e);
    //   });
    // }).catchError((e){
    //   print(e);
    // });
    // print(widget.listAll[0].attendence.values.contains(element))
  }
  
  String u;
  double w;

  Future <void> deleteConfirmation(BuildContext context,String uid,String studentPath,String studentClassPath,String studentDocIDPath,String name) async{

    return showDialog(

        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Remove Student',style: TextStyle(color: Colors.black,),),
            content: Text('Once you remove $name you may not be able to mark their attendence.But their previous attendence will still be in your record'),
            // content: Text('Provide the following code to participants in order to join the class',style: TextStyle(color: Colors.grey,),),
            // content:Container(
            //     height: 200,
            //     child: Column(
            //
            //       children: <Widget>[
            //
            //         SizedBox(height: 50,),
            //         // Text(u),
            //         // TextField(
            //         //   decoration: InputDecoration(
            //         //
            //         //       contentPadding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
            //         //       hintText: u
            //         //   ),
            //         //   readOnly: true,
            //         //
            //         // )
            //       ],
            //     )) ,

            actions: <Widget>[
              FlatButton(
                child: Text('Cancel',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Remove',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                onPressed: (){

                  Clipboard.setData(new ClipboardData(text: u));
                  UserManagement().deleteStudentFromTeacher(uid, studentPath, studentClassPath, studentDocIDPath);
                  Navigator.of(context).pop();
                },

              ),
            ],
            elevation: 10,
            shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(30)
            ),


          );
        }
    );
  }


  Future <void> addDialog(BuildContext context,String i) async{

    return showDialog(

        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Add Members',style: TextStyle(color: Colors.black,),),
            // content: Text('Provide the following code to participants in order to join the class',style: TextStyle(color: Colors.grey,),),
            content:Container(
              height: 200,
                child: Column(

                    children: <Widget>[
                      Text('Provide the following code to participants in order to join the class',style: TextStyle(color: Colors.black,),),
                      SizedBox(height: 50,),
                      // Text(u),
                      TextField(
                        decoration: InputDecoration(

                          contentPadding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
                          hintText: u,hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        readOnly: true,

                      )
                    ],
            )) ,

            actions: <Widget>[
              FlatButton(
                child: Text('Cancel',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Copy',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                onPressed: (){
                  // Navigator.of(context).pop();
                  Clipboard.setData(new ClipboardData(text: u));
                  Navigator.of(context).pop();
                },

              ),
            ],
            elevation: 10,
            shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(30)
            ),


          );
        }
    );
  }
  Widget abc(String i){
    return Material(
      color: Colors.transparent,
      // borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.only(left: 0,top: 15,right: 0,bottom: 15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 25,),
                    onPressed: () {
                      Navigator.of(context).pop();

                    },),
                  // FlutterLogo(textColor: Colors.red,size: 30,),
                  IconButton(
                    icon: Icon(Icons.person_add_outlined,color: Colors.grey,size: 30,),
                    onPressed: (){

                      addDialog(context,i);

                    },

                  ),
                  // InkWell(
                  //     onTap: (){
                  //         addDialog(context);
                  //     },
                  //     child:Center(child: Padding(
                  //       padding: const EdgeInsets.only(left: 10,right: 10),
                  //       child: Row(
                  //         children: <Widget>[
                  //           Icon(Icons.add,color: Colors.grey,size: 35,),
                  //           // Text('Add Students',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  //         ],
                  //       ),
                  //     ))
                  // )
                  // FlutterLogo(colors: Colors.red, size: 30,),


                  // IconButton(
                  //   color: Colors.grey,
                  //   icon: Icon(Icons.group,size: 30,),
                  //   onPressed: (){
                  //     // Navigator.push(
                  //     //     context, SideTransition(widget: TotalStudents()));
                  //   },
                  // )
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
       w= MediaQuery.of(context).size.width;
    });

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body:StreamBuilder(

          stream: FirebaseFirestore.instance.collection('/users/${widget.userDocID}/classes/${widget.classDocID}/Students').orderBy('rollNo',descending: false).snapshots(),
          // stream: st,
          builder: (context, snapshot) {
            int l=snapshot.data.documents.length;
            // setState(() {
            //   totalStudents=l;
            // });
            if (!snapshot.hasData || snapshot.data==null|| snapshot.data.documents == null ||snapshot.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }



              return new CustomScrollView(

                  physics: ScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  slivers: <Widget>[
                    SliverAppBar(
                      title: abc(widget.i),
                      expandedHeight: 200,
                      backgroundColor: Colors.white,

                      floating: true,
                      pinned: true,
                      // stretchTriggerOffset: 150,

                      flexibleSpace: FlexibleSpaceBar(


                        background: Padding(
                          padding: const EdgeInsets.only(top: 100,
                              left: 15,
                              right: 15),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('Students',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: (w *
                                            70) / 360,
                                        fontWeight: FontWeight.bold),),
                                  Text('.', style: TextStyle(color: Colors.red,
                                      fontSize: 70,
                                      fontWeight: FontWeight.bold),)
                                ],
                              ),
                              // Material(
                              //   elevation: 10,
                              //   borderRadius: BorderRadius.circular(30),
                              //   child: Container(
                              //     height: 40,
                              //     child: TextFormField(
                              //       decoration: InputDecoration(
                              //
                              //         contentPadding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
                              //         border: InputBorder.none,
                              //         hintText: 'Search',
                              //         hintStyle: TextStyle(fontSize: 20),
                              //
                              //         suffixIcon: InkWell(
                              //
                              //           onTap: (){},
                              //           child: Icon(
                              //             Icons.search,
                              //
                              //           ),
                              //         ),
                              //
                              //
                              //
                              //       ),
                              //
                              //       style: TextStyle(color: Colors.redAccent),
                              //
                              //       onChanged: (val){
                              //
                              //         // initiateSearch(val);
                              //       },
                              //     ),
                              //     decoration: BoxDecoration(
                              //       color: Colors.grey.shade100,
                              //       borderRadius: BorderRadius.circular(30),
                              //     ),
                              //   ),
                              // ),
                              Row(

                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  // SizedBox(width: 20,),
                                  // Material(
                                  //   elevation: 10,
                                  //   borderRadius: BorderRadius.circular(30),
                                  //   child: Container(
                                  //     height: 40,
                                  //     width: w-70,
                                  //     child: TextFormField(
                                  //       decoration: InputDecoration(
                                  //
                                  //         contentPadding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
                                  //         border: InputBorder.none,
                                  //         hintText: 'Search',
                                  //         hintStyle: TextStyle(fontSize: 20),
                                  //
                                  //         suffixIcon: InkWell(
                                  //
                                  //           onTap: (){},
                                  //           child: Icon(
                                  //             Icons.search,
                                  //
                                  //           ),
                                  //         ),
                                  //
                                  //
                                  //
                                  //       ),
                                  //
                                  //       style: TextStyle(color: Colors.redAccent),
                                  //
                                  //       onChanged: (val){
                                  //
                                  //         // initiateSearch(val);
                                  //       },
                                  //     ),
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.grey.shade100,
                                  //       borderRadius: BorderRadius.circular(30),
                                  //     ),
                                  //   ),
                                  // ),
                                  Row(
                                    children: [
                                      Icon(Icons.person,color: Colors.grey[700],size: 25,),
                                      Text(l.toString(),style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 25),),
                                    ],
                                  )
                                ],
                              ),

                            ],

                          ),
                        ),

                      ),
                    ),

                    l!=0?
                    new SliverList(
                      delegate: new SliverChildBuilderDelegate(
                            (BuildContext context, index) {
                          return Padding(

                            padding: const EdgeInsets.all(8.0),
                            child: new Material(
                              // color: Colors.transparent,
                              elevation: 10,
                              borderRadius: BorderRadius.circular(40),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            CircleAvatar(
                                              minRadius: 30,
                                              backgroundColor: Colors.redAccent,
                                              backgroundImage: NetworkImage(
                                                  'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80'
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  snapshot.data.documents[index]
                                                      .data()['studentName']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontSize: 25),),
                                                Text(
                                                  snapshot.data.documents[index]
                                                      .data()['lastName']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontSize: 25),),
                                                Text(
                                                  snapshot.data.documents[index]
                                                      .data()['rollNo']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15),),
                                                Text(
                                                  snapshot.data.documents[index]
                                                      .data()['email']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15),),

                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('${getAttendenceList()
                                                .getAttendencePercentage(
                                                snapshot.data.documents[index]
                                                    .data()['uid'],
                                                widget.listAll)}%',
                                              style: TextStyle(
                                                  color: getAttendenceList()
                                                      .getAttendenceColors(
                                                      snapshot.data
                                                          .documents[index]
                                                          .data()['uid'],
                                                      widget.listAll),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),),
                                            IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: (){
                                                deleteConfirmation(context,snapshot.data.documents[index].data()['uid'],studentPath,studentClassPath,snapshot.data.documents[index].documentID,'${snapshot.data.documents[index].data()['studentName'].toString()} ${snapshot.data.documents[index].data()['lastName'].toString()}');
                                                // UserManagement().deleteStudentFromTeacher(snapshot.data.documents[index].data()['uid'],studentPath,studentClassPath,snapshot.data.documents[index].documentID);

                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // Text(snapshot.data.documents[index].data()['studentName'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                                  ],
                                ),
                                // child: Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: <Widget>[
                                //     Row(
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       children: <Widget>[
                                //         CircleAvatar(
                                //           minRadius: 30,
                                //           backgroundColor: Colors.redAccent,
                                //           backgroundImage: NetworkImage(
                                //             'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80'
                                //           ),
                                //         ),
                                //
                                //         Column(
                                //           mainAxisAlignment: MainAxisAlignment.start,
                                //           children: <Widget>[
                                //
                                //             Text(snapshot.data.documents[index].data()['studentName'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                                //             Text(snapshot.data.documents[index].data()['rollNo'].toString(),style: TextStyle(fontSize: 20),),
                                //             // Text(snapshot.data.documents[index].data()['email'].toString(),style: TextStyle(fontSize: 20),),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //     SizedBox(height: 25,),
                                //     IconButton(
                                //
                                //       icon: Icon(Icons.delete),
                                //       onPressed: (){},
                                //     )
                                //
                                //
                                //   ],
                                // ),
                              ),
                            ),
                          );
                        },


                        childCount: l,
                        //   childCount:2,
                      ),

                    ):SliverToBoxAdapter(
                      child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('To add Students, Click on ',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                          Icon(Icons.person_add_outlined),
                        ],
                      )),
                    ),
                    // GridView.count(
                    //     padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    //     crossAxisCount: 2,
                    //     crossAxisSpacing: 4.0,
                    //     mainAxisSpacing: 4.0,
                    //     primary: false,
                    //     shrinkWrap: true,
                    //     children: tempSearchStore.map((element) {
                    //       return buildResultCard(element);
                    //     }).toList()),


                  ]

              );


          }
        ),

      ),
    );
  }
//   Widget buildResultCard(data) {
//     return Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//         elevation: 2.0,
//         child: Container(
//             child: Center(
//                 child: Text(data['studentName'],
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20.0,
//                   ),
//                 )
//             )
//         )
//     );
// }

}
