import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Pages
import 'package:mark/login.dart';
import 'package:mark/signup.dart';
import 'services/usermanagement.dart';
import 'package:mark/details.dart';

//Firebase
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase/firebase.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() =>runApp(
//
//     MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home:MyApp()));
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(

      MaterialApp(
          debugShowCheckedModeBanner: false,
          home:MyApp()));
}



class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    // Firebase.initializeApp()
    //     .catchError((e){
    //   print(e);
    // });
    super.initState();


  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: UserManagement().handleAuth(),
      routes: <String,WidgetBuilder>{
        '/landingpage':(BuildContext context)=>new MyApp(),
        '/login':(BuildContext context)=>Login(),
        '/signup':(BuildContext context)=>Signup(),
        '/details':(BuildContext context)=>Details(),
      },
    );
  }
}

