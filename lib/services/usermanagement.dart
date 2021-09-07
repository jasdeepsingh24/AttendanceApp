import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
//Firebase
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//Pages
import 'package:mark/login.dart';
import 'package:mark/loading.dart';
import 'package:mark/teacher/teacherdashboard.dart';
import 'package:mark/pageTransitions/toptransition.dart';
import 'package:mark/details.dart';
import 'package:mark/details2.dart';
import 'package:mark/student/studentdashboard.dart';


class UserManagement {
    String code;

  Widget handleAuth() {


    return new StreamBuilder(
        stream:  FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting)
            {
              return LoadingScreen();
            }
          else if(snapshot.hasData)
            {
              return handleD();
            }
          else
            {
              return Login();
            }
        },
    );
  }
  getName()  {
    String name;
    var user= FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('/users').where('uid',isEqualTo: user.uid).getDocuments().then((docs){
      // FirebaseFirestore.instance.collection('/users/${docs.documents[0].documentID}/classes').add({'className':name});
      name=docs.documents[0].data()['details']['firstName'].toString();
      print("Name $name");
      return name;


    }).catchError((e){
      print(e);
    });

  }
  storeNewUser(user,context) {

    FirebaseFirestore.instance.collection('/users').add({
      'email':user.email,
      'uid': user.uid,
      'details':{'role':null,'firstName':null,'lastName':null},
    }).then((value){
      Navigator.of(context).pop();
      // Navigator.pushReplacement(context,TopTransition(widget: TeacherDashboard()));
      handleAuth();
    }).catchError((e){
      print(e);
    });
  }

   addStudent(String code,String userName,String em,String uid,String rollNo,String lastName) async{
    var user=FirebaseAuth.instance.currentUser;
     await FirebaseFirestore.instance.collection('invitecode').getDocuments().then((docs) async{
      int l=docs.documents.length;
      for(int i=0;i<l;i++)
        {
          if(code==docs.documents[i].documentID)
            {

                code=docs.documents[i].data()['ref'].toString();
                print(code);
                String className;
                FirebaseFirestore.instance.document(code).get().then((docClassName){
                  className= docClassName.data()['className'];
                }).catchError((e){
                  print(e);
                });



              FirebaseFirestore.instance.collection('${code}/Students').getDocuments().then((studentDocs){
                int n=studentDocs.documents.length;
                int j;
                for(j=0;j<n;j++)
                  {
                    if(uid==studentDocs.documents[j].data()['uid'].toString())
                      {
                        return;
                      }
                    else
                      {
                        continue;
                      }
                  }
                FirebaseFirestore.instance.collection('${code}/Students').add(
                          {'studentName': userName, 'email': em, 'uid': uid,'rollNo':rollNo,'lastName':lastName});
                  FirebaseFirestore.instance.collection('users').where('uid',isEqualTo:user.uid).getDocuments().then((docCurrent){
                FirebaseFirestore.instance.collection('/users/${docCurrent.documents[0].documentID}/classes').add({
                  'classRef':code,
                  'className':className,

                });
                // print(className);
                }).catchError((e){
                print(e);
                });


              }).catchError((e){
                print(e);
              });





            }

        }

    });
    // print(code);


  }
  createNewClass(String name) {
    String ref;
    var user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((docs){
      FirebaseFirestore.instance.collection('/users/${docs.documents[0].documentID}/classes').add({'className':name});
      // print(docs.documents[0].documentID);
    }).catchError((e){
      print(e);
    });
    FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((docs){
      FirebaseFirestore.instance.collection('/users/${docs.documents[0].documentID}/classes').where('className',isEqualTo: name).getDocuments().then((docClass){
        // String z='/users/${docs.documents[0].documentID}/classes';
        String x='/users/${docs.documents[0].documentID}/classes/${docClass.documents[0].documentID}';
         ref=x;
        // print(ref);
        FirebaseFirestore.instance.collection('invitecode').add({'ref':ref}).then((value){
          FirebaseFirestore.instance.collection('invitecode').where('ref',isEqualTo:ref).getDocuments().then((docInvite){
            String b='${docInvite.documents[0].documentID}';
            // print('ref ${b}');
            Map<String,dynamic> details={
              'ref':b,

            };
            FirebaseFirestore.instance.document(ref).updateData(details);
            // docClass.documents[0].data()['ref']=b;
            // FirebaseFirestore.instance.collection(z).where('className',isEqualTo: name).add({'ref':b})
          }).catchError((e){
            print(e);
          });
        });



      }).catchError((e){
        print(e);
      });

      // print(docs.documents[0].documentID);
    }).catchError((e){
      print(e);
    });


  }
  updateUserProfile(picUrl) async{

  }
  String getInviteCode(String i){

    int x=int.parse(i);
    var user=FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('/users').where('uid',isEqualTo: user.uid).getDocuments().then((docs){
      FirebaseFirestore.instance.collection('/users/${docs.documents[0].documentID}/classes').getDocuments().then((docum){
        code=docum.documents[x].data()['ref'].toString();
        print(code);

      }).catchError((e){
        print(e);
      });
    }).catchError((e){
      print(e);
    });


    // return code;
  }
  signOut(){
    FirebaseAuth.instance.signOut();

  }
  Future deleteStudentFromTeacher(String uid,String studentPath,String studentClassPath,String studentDocIDPath){
    FirebaseFirestore.instance.document('$studentPath/$studentDocIDPath').delete().catchError((e){
      print(e);
    });
    FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: uid).getDocuments().then((doc){
      FirebaseFirestore.instance.collection('users/${doc.documents[0].documentID}/classes').where('classRef',isEqualTo: studentClassPath).getDocuments().then((docID){
        FirebaseFirestore.instance.document('users/${doc.documents[0].documentID}/classes/${docID.documents[0].documentID}').delete().catchError((e){
          print(e);
        });
      }).catchError((e){
        print(e);
      });
    }).catchError((e){
      print(e);
    });

  }
  deleteClassFromTeacher(String path){

    FirebaseFirestore.instance.collection('$path/Students').getDocuments().then((docs)async{
      int l=docs.documents.length;
      for(int i=0;i<l;i++)
        {
          String uid=docs.documents[i].data()['uid'].toString();
          String studentPath='$path/Students'.toString();
          // String studentClassPath=path.toString();
          String studentDocIDPath=docs.documents[i].documentID.toString();

          await deleteStudentFromTeacher(uid,studentPath,path,studentDocIDPath);

        }

    }).catchError((e){
      print(e);
    });
    FirebaseFirestore.instance.document(path).delete().catchError((e){
      print(e);
    });
  }
  deleteAttendenceFromTeacher(DateTime t,String userDocID,String classDocID){
    String p='/users/$userDocID/classes/$classDocID/Attendence';
    FirebaseFirestore.instance.collection(p).where('dateTime',isEqualTo: t).getDocuments().then((docs){
      FirebaseFirestore.instance.document('$p/${docs.documents[0].documentID}').delete().catchError((e){
        print(e);
      });
    }).catchError((e){
      print(e);
    });

  }
  Widget handleD(){

    // Stream<QuerySnapshot> x=Firestore.instance.collection('/users').snapshots();





      return StreamBuilder (
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (BuildContext context,snapshot){
            if(snapshot.data==null)
            {
              return AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: LoadingScreen(),
              );
              return LoadingScreen();
            }
            int x;
            var user=FirebaseAuth.instance.currentUser;
            if(snapshot.data.documents!=null) {
              int l=snapshot.data.documents.length;
              for (int i = 0; i < l; i++) {
                if (snapshot.data.documents[i].data()['uid'] == user.uid) {
                  x = i;
                  break;
                }
              }
            }
            print(snapshot.data.documents[x].data()['details']);
           // print(snapshot.documents.data()['email']);
           // if(sna)



            if(snapshot.data.documents[x].data()['details']['role']==null)
              {

                // return Details();
                return AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: Details(),
                );
              }
            if( snapshot.data.documents[x].data()['details']['role']=='student' && snapshot.data.documents[x].data()['rollNo']==null)
              {

                  // return Details2();
                return AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: Details2(),
                );
              }
            if(snapshot.data.documents[x].data()['details']['role']=='student')
              {
                // return StudentDashboard();
                return AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: StudentDashboard(),
                );
              }
            if(snapshot.data.documents[x].data()['details']['role']=='teacher')
            {
              // return TeacherDashboard();
              return AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: TeacherDashboard(),
                //   child: TopTransition(widget: TeacherDashboard()),

              );
            }
            else{
              return TeacherDashboard();
            }
          },
      );
    }

    // getClassName()async{
    //   // var user=FirebaseAuth.instance.currentUser;
    //   //  FirebaseFirestore.instance.collection('users').where('uid',isEqualTo:user.uid ).getDocuments().then((docs){
    //   //    QuerySnapshot snapshot= FirebaseFirestore.instance.collection('/users/${docs.documents[0].documentID}/classes').snapshots();
    //   //
    //   // }).asStream();
    //   //  print(snapshot.data.documents.length);
    //
    //
    //
    // }
   // getUserDoc()
   // {
   //   int x;
   //   final Stream<Snapshot> snapshot=FirebaseFirestore.instance.collection('users').snapshots();
   //   var user=FirebaseAuth.instance.currentUser;
   //   if(snapshot.data.documents!=null) {
   //     int l=snapshot.data.documents.length;
   //     for (int i = 0; i < l; i++) {
   //       if (snapshot.data.documents[i].data()['uid'] == user.uid) {
   //         x = i;
   //         break;
   //       }
   //     }
   //   }
   //   return x;
   // }
   //  updateData()
   //  {
   //    Firestore.instance.collection('users').document().updateData(data)
   //  }

}