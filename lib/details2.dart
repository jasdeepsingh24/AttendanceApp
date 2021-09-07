import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//FIrebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Details2 extends StatefulWidget {
  @override
  _Details2State createState() => _Details2State();
}

class _Details2State extends State<Details2> {
  String _rollNo;
  String alert='Roll number only contain digits';
  Stream details;

 
  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  Future <void> addDialog(BuildContext context) async{

    return showDialog(

        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Center(child: Text(alert,style: TextStyle(color: Colors.grey,),)),
            actions: <Widget>[

              Center(
                child: FlatButton(
                  child: Text('try again',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },

                ),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    children: <Widget>[

                      Row(
                        children: <Widget>[
                          Text('ROLL NUMBER',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
                          Text('.',style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
                        child: Material(

                          borderRadius: BorderRadius.circular(30),
                          elevation: 10,
                          child: TextFormField(
                            decoration: InputDecoration(

                              contentPadding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
                              border: InputBorder.none,
                              hintText: '. . .',
                              hintStyle: TextStyle(color: Colors.grey,),


                            ),
                            style: TextStyle(color: Colors.redAccent),
                            onChanged: (val){
                              setState(() {
                                _rollNo=val;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(

                  icon: Icon(Icons.arrow_forward_ios,color: Colors.red[300],size: 60,),
                  onPressed: () {
                    
                            if(_isNumeric(_rollNo)){
                            Map<String, dynamic> details = {

                            'rollNo': this._rollNo,


                            };
                            var user = FirebaseAuth.instance.currentUser;
                            FirebaseFirestore.instance.collection('users').where(
                            'uid', isEqualTo: user.uid).getDocuments().then((
                            docs) {
                            FirebaseFirestore.instance.document(
                            '/users/${docs.documents[0].documentID}')
                                .updateData(details);
                            }).catchError((e) {
                            print(e.code);
                            });
                            }
                            else
                              {
                                addDialog(context);

                              }

                    },

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
