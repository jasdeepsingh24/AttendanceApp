import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Transition Page
import 'pageTransitions/toptransition.dart';

//Pages
import 'details2.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isSwitched=true;
  String _role;
  String _firstName,_lastName;
  Stream details;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('First name',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
                            Text('.',style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Material(
                          // color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(30),
                          elevation: 10,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(

                              contentPadding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
                              border: InputBorder.none,
                              hintText: '. . .',
                              hintStyle: TextStyle(color: Colors.grey,),



                            ),
                            style: TextStyle(color: Colors.redAccent),
                            onChanged: (val){
                              setState(() {
                                _firstName=val;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Last name',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
                            Text('.',style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Material(

                          borderRadius: BorderRadius.circular(30),
                          elevation: 10,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(

                              contentPadding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
                              border: InputBorder.none,
                              hintText: '. . .',
                              hintStyle: TextStyle(color: Colors.grey,),


                            ),
                            style: TextStyle(color: Colors.redAccent),
                            onChanged: (val){
                              setState(() {
                                _lastName=val;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('I am',style: TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.bold),),
                          Text('.',style: TextStyle(color: Colors.red,fontSize: 40,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Teacher',style: TextStyle(color: isSwitched==false? Colors.red:Colors.grey,fontSize: isSwitched==false? 32:30,fontWeight: FontWeight.bold),
                            ),
                            Switch(

                              value: isSwitched,
                              onChanged: (value){
                                setState(() {
                                  isSwitched=value;

                                });
                              },
                              activeTrackColor: Colors.red,
                              activeColor: Colors.white,
                              inactiveTrackColor: Colors.red,
                              inactiveThumbColor: Colors.white,
                            ),
                            Text(
                              'Student',style: TextStyle(color: isSwitched==true? Colors.red:Colors.grey,fontSize: isSwitched==true?32:30,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(height: 30,),
                IconButton(

                  icon: Icon(Icons.arrow_forward_ios,color: Colors.red[300],size: 60,),
                  onPressed: (){

                    if(isSwitched==true)
                      {
                        _role='student';
                      }
                    else
                      {
                        _role='teacher';
                      }
                    Map<String,dynamic> details={
                      'details':{
                        'firstName':this._firstName,
                        'lastName':this._lastName,
                        'role':this._role,
                      }

                    };

                    var user=FirebaseAuth.instance.currentUser;
                    FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((docs){
                      FirebaseFirestore.instance.document('/users/${docs.documents[0].documentID}').updateData(details);
                    }).catchError((e){
                      print(e.code);
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
