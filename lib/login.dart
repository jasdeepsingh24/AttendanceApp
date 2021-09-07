import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Transition Page
import 'pageTransitions/bouncyPageRoute.dart';

//Pages
import 'package:mark/signup.dart';

//Firebase
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;
  bool _hidePassword=true;
  String alert;

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
  Future <void> enterPassword(BuildContext context) async{

    return showDialog(

        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Please Enter Password',style: TextStyle(color: Colors.black),),
            actions: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text('Try Again',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },

                  ),
                ],
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
    var width=MediaQuery.of(context).size.width;
    return MaterialApp(

      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
// crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FlutterLogo(textColor: Colors.red,size: 50,),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 50, 15, 10),
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
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
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
                          hintText: 'password'


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
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          child: Text('forgot password',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                          onTap: (){},
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 40,
                      width: width-240,
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      // color: Colors.orange,
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(30),
                        color: Colors.red,
                        // boxShadow: [
                        //   BoxShadow(
                        //     blurRadius: 10,
                        //     spreadRadius: 3,
                        //     color: Colors.redAccent.shade100,
                        //   )
                        // ]
                      ),
                      child: InkWell(
                        // splashColor: Colors.green,
                        child: Center(child: Text('LOGIN',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)),
                        onTap: (){
                          if(_password==null)
                            {
                              enterPassword(context);
                            }
                          FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password).catchError((e){
                            print(e.code);
                              setState(() {
                                // alert=e.code
                                if(e.code=='invalid-email')
                                  {
                                    alert='Your Email Address is not valid';

                                  }
                                else if(e.code=='user-not-found')
                                  {
                                    alert="Please Signup,you'r not registered";
                                  }

                              });
                                addDialog(context);

                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30,left: 15,right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: 40,
                          child: InkWell(
                            onTap: (){},
                            child: Image(
                              image: AssetImage('assets/google.png'),

                              fit: BoxFit.cover,


                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        Container(
                          height: 40,
                          width: 40,
                          child: InkWell(
                            onTap: (){},
                            child: Image(
                              image: AssetImage('assets/facebook-blue.png'),
                              fit: BoxFit.cover,


                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40,bottom: 0,right: 15,left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 15)),
                        SizedBox(width: 2,),
                        InkWell(
                          onTap: (){
                            Navigator.push(context,BouncyPageRoute(widget: Signup()));
                          },
                          child: Text('SIGN UP',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),


      ),
    );
  }

}

