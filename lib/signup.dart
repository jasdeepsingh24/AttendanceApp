//Firebase
import 'package:firebase_auth/firebase_auth.dart';

//Pages
import 'services/usermanagement.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _email;
  String _password;
  String _checkpassword;
  bool _hidePassword=true;
  String alert;
  String x;

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
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.redAccent,
        appBar: AppBar(
          title: FlutterLogo(textColor: Colors.grey,size: 40,),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.redAccent,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text('Signup  ',style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold),),
                  ),
                  Positioned(
                    left: 167,
                      child: Text('.  ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 50),)),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 30, 15, 10),
                child: Material(

                  borderRadius: BorderRadius.circular(30),
                  elevation: 10,
                  child: TextFormField(
                    decoration: InputDecoration(

                      contentPadding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
                      border: InputBorder.none,
                      hintText: 'mark@gmail.com',
                      hintStyle: TextStyle(color: Colors.grey,),




                    ),
                    style: TextStyle(color: Colors.redAccent),
                    onChanged: (val){
                      setState(() {
                        _email=val;
                      });
                    },
                  ),
                ),
              ),
              // Row(
              //     children: <Widget>[
              //       Container(
              //         padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              //         width: (MediaQuery.of(context).size.width-30)/2,
              //         child: Material(
              //
              //           borderRadius: BorderRadius.circular(30),
              //           elevation: 10,
              //           child: TextFormField(
              //             decoration: InputDecoration(
              //               // prefixIcon: Icon(Icons.,color: Colors.grey,),
              //
              //               contentPadding: EdgeInsets.only(left: 25,top: 15,bottom: 15),
              //               border: InputBorder.none,
              //               // hintText: ',
              //               hintStyle: TextStyle(color: Colors.grey,),
              //               hintText: 'first name',
              //
              //
              //             ),
              //             style: TextStyle(color: Colors.redAccent),
              //             onChanged: (val){
              //               setState(() {
              //                 _firstname=val;
              //               });
              //             },
              //           ),
              //         ),
              //       ),
              //       Container(
              //         padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              //         width: (MediaQuery.of(context).size.width-30)/2,
              //         child: Material(
              //
              //           borderRadius: BorderRadius.circular(30),
              //           elevation: 10,
              //           child: TextFormField(
              //             decoration: InputDecoration(
              //               // prefixIcon: Icon(Icons.lock,color: Colors.grey,),
              //
              //               contentPadding: EdgeInsets.only(left: 25,top: 15,bottom: 15),
              //               border: InputBorder.none,
              //               // hintText: ',
              //               hintStyle: TextStyle(color: Colors.grey,),
              //               hintText: 'last name',
              //
              //             ),
              //             style: TextStyle(color: Colors.redAccent),
              //             onChanged: (val){
              //               setState(() {
              //                 _lastname=val;
              //               });
              //             },
              //           ),
              //         ),
              //       ),
              //     ],
              // ),

              Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Material(

                  borderRadius: BorderRadius.circular(30),
                  elevation: 10,
                  child: TextFormField(
                    obscureText: _hidePassword,
                    decoration: InputDecoration(

                      suffixIcon: InkWell(
                          onTap: (){
                            setState(() {
                              _hidePassword=!_hidePassword;
                            });
                          },
                          child: Icon(
                            Icons.remove_red_eye,color:_hidePassword==true? Colors.grey:Colors.redAccent,
                          )
                      ),
                      contentPadding: EdgeInsets.only(left: 15,top: 15),
                      border: InputBorder.none,
                      // hintText: ',
                      hintStyle: TextStyle(color: Colors.grey,),
                      hintText: 'password',

                    ),
                    style: TextStyle(color: Colors.redAccent),
                    onChanged: (val){
                      setState(() {
                        _password=val;
                      });
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Material(
                  
                  borderRadius: BorderRadius.circular(30),
                  elevation: 10,
                  child: TextFormField(
                    
                    cursorColor: Colors.redAccent,
                    obscureText: _hidePassword,
                    decoration: InputDecoration(

                      suffixIcon: InkWell(
                          onTap: (){
                            setState(() {
                              _hidePassword=!_hidePassword;
                            });
                          },
                          child: Icon(
                            Icons.remove_red_eye,color:_hidePassword==true? Colors.grey:Colors.redAccent,
                          )
                      ),
                      contentPadding: EdgeInsets.only(left: 15,top: 15),
                      border: InputBorder.none,
                      // hintText: ',
                      hintStyle: TextStyle(color: Colors.grey,),
                      hintText: 'confirm password',

                    ),
                    style: TextStyle(color: Colors.redAccent),
                    onChanged: (val){
                      setState(() {
                        _checkpassword=val;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width-240,
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      // color: Colors.orange,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,

                          boxShadow: [
                            BoxShadow(
                              // blurRadius: 10,
                              // spreadRadius: 1,
                              color: Colors.white,
                            )
                          ]
                      ),
                      child: InkWell(

                        // splashColor: Colors.green,
                        child: Center(child: Text('SIGNUP',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16),)),
                        onTap: (){
                              if(_checkpassword==_password) {
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                    email: _email, password: _password).then((
                                    signedInUser) {
                                  UserManagement().storeNewUser(
                                      signedInUser.user, context);
                                }).catchError((e) {
                                  print(e.code);
                                });
                              }




                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
