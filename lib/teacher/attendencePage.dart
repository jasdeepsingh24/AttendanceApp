


// import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mark/pageTransitions/bouncyPageRoute.dart';
import 'package:mark/teacher/attendenceLists.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:csv/csv.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:firebase/firebase.dart';
//Pages
import '../loading.dart';
import 'totalStudents.dart';
import 'takeAttendence.dart';
//transition
import 'package:mark/pageTransitions/sideTransition.dart';
//Calender
import 'package:table_calendar/table_calendar.dart';

class AttendencePage extends StatefulWidget {
  Timestamp current;
  Map list;
  String userDocID;
  String classDocId;
  String documentIDAttendence;
  AttendencePage({this.current,this.list,this.userDocID,this.classDocId,this.documentIDAttendence});

  @override
  _AttendencePageState createState() => _AttendencePageState();
}


class _AttendencePageState extends State<AttendencePage> {

  var weekday=['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
  int i;
  bool changesMade=false;
  bool saveChanges=false;
  var listOfAttendence=new List<attendenceListSub>();
  var listChanges=new List<saveChangesList>();



  // String filePath;
  //
  // Future<String> get _localPath async {
  //   final directory = await getApplicationSupportDirectory();
  //
  //   return directory.absolute.path;
  // }
  //
  // Future<File> get _localFile async {
  //   final path = await _localPath;
  //   setState(() {
  //     filePath = '$path/data.csv';
  //   });
  //
  //   return File('$path/data.csv').create();
  // }
  // sendMailAndAttachment() async {
  //   final Email email = Email(
  //     body:
  //     'Hey, the CSV made it!',
  //     subject: 'Datum Entry for ${DateTime.now().toString()}',
  //     recipients: ['aayush.luck@gmail.com'],
  //     isHTML: true,
  //     attachmentPaths: [filePath],
  //   );
  //
  //   await FlutterEmailSender.send(email);
  // }


  Future <void> addDialog(BuildContext context) async{

    return showDialog(

        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.white,
            // title: Text('A',style: TextStyle(color: Colors.grey,),),
            title: Text('Attendence of "${widget.current.toDate().toString().substring(0,10)}" will be send to your mail in a .csv format.',style: TextStyle(color: Colors.black, ),),

            actions: <Widget>[
              FlatButton(
                child: Text('Cancel',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Get Attendence',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                onPressed: ()async{
                  // Navigator.of(context).pop();
                  // Clipboard.setData(new ClipboardData(text: u));
                  // download();
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
  
  
  
  Widget abc(){
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
                        if(saveChanges==false && changesMade==true) {
                          int lx = listChanges.length;
                          setState(() {
                            for (int z = 0; z < lx; z++) {
                              listOfAttendence[listChanges[z].x].attendence =
                                  listChanges[z].attendence;
                              print(listOfAttendence[listChanges[z].x]
                                  .attendence);
                              widget.list.values.elementAt(
                                  listChanges[z].i)['attendence'] =
                                  listChanges[z].attendence;
                            }
                          });
                        }


                      Navigator.of(context).pop();

                    },),
                  // FlutterLogo(textColor: Colors.red,size: 30,),
                  IconButton(
                    icon: Icon(Icons.download_rounded,color: Colors.grey,size: 30,),
                    onPressed: (){


                      addDialog(context);

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
  void initState() {
    // TODO: implement initState
    super.initState();
  print('updated list====>${widget.list.values.length}');

  int l=widget.list.values.length;
    for(int i=0;i<l;i++)
      {
          listOfAttendence.add(attendenceListSub(widget.list.values.elementAt(i)['attendence'],widget.list.values.elementAt(i)['rollNo'], widget.list.values.elementAt(i)['studentName'],widget.list.values.elementAt(i)['uid'],widget.list.values.elementAt(i)['lastName']));
      }
    listOfAttendence.sort((a,b){
      return int.parse(a.rollNo).compareTo(int.parse(b.rollNo));
    });



    // for(int i=0;i<l;i++)
    //   {
    //     print(listOfAttendence[i].studentName);
    //   }
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,

        body: CustomScrollView(
          physics: ScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverAppBar(
                title: abc(),
                expandedHeight: 200,
                backgroundColor: Colors.white,

                floating: true,
                pinned: true,
              flexibleSpace: FlexibleSpaceBar(


                background:Padding(
                  padding: const EdgeInsets.only(top:100,left: 15,right: 15),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Column(
                          children: [
                            // Text('${DateFormat.yMd().format(widget.current.toDate())}'),
                            Text('${DateFormat.yMd().format(widget.current.toDate())}',style: TextStyle(color: Colors.black,fontSize: 17),),
                            // Text('${DateFormat.jm().format(widget.current.toDate())}'),
                            Text('${weekday[widget.current.toDate().weekday-1]}',style: TextStyle(color: Colors.black,letterSpacing: 2,fontSize: 22,fontWeight: FontWeight.bold),),
                            Text('${DateFormat.jm().format(widget.current.toDate())}',style: TextStyle(color: Colors.black,fontSize: 17),),
                            changesMade==true?Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(


                               onTap: (){

                                 Map<String,dynamic> updatedAttendence={
                                   'attendence':widget.list,
                                 };
                                  // FirebaseFirestore.instance.collection('/users/${widget.userDocID}/classes/${widget.classDocId}/Attendence').where('dateTime',isEqualTo: widget.current).getDocuments().then((docs){
                                  //   docs.documents[0].data()['attendence']=widget.list;
                                  // }).catchError((e){
                                  //   print(e);
                                  // });
                                 FirebaseFirestore.instance.document('/users/${widget.userDocID}/classes/${widget.classDocId}/Attendence/${widget.documentIDAttendence}').updateData(updatedAttendence);
                                  setState(() {
                                    saveChanges=true;

                                  });

                               },
                                child: saveChanges==false?Container(
                                  height: 30,
                                  width: 110,
                                  child: Center(child: Text('Save Changes',style: TextStyle(fontWeight: FontWeight.bold),)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green,
                                  ),
                                ):Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                              ),
                            ):SizedBox(height: 0,width: 0,),

                          ],
                        ),
                      )


                    ],

                  ),
                ),

              ),
              ),
            // SliverToBoxAdapter(
            //   child: Text('${widget.list.values.elementAt(0)}'),
            // ),
            SliverList(

                delegate: SliverChildBuilderDelegate((context,index){

              return Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.black45,Colors.red],
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text('${widget.list.values.elementAt(index)['studentName']}',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                              Text('${listOfAttendence[index].studentName} ${listOfAttendence[index].lastName}',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                              Text('${listOfAttendence[index].rollNo}',style:TextStyle(color: Colors.white)),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${listOfAttendence[index].attendence}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              PopupMenuButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                color: Colors.white,
                                elevation: 10,
                                onSelected:choiceAction,
                                itemBuilder: (BuildContext context){
                                  setState(() {
                                    i=index;
                                  });
                                  return Constants.choices.map((String choice){
                                    if(listOfAttendence[i].attendence=='Present')
                                      {
                                        return PopupMenuItem(
                                            value: 'Mark Absent',
                                            child:Text('Mark Absent')
                                        );
                                      }
                                    else if(listOfAttendence[i].attendence=='Absent')
                                      {
                                        return PopupMenuItem(
                                            value: 'Mark Present',
                                            child:Text('Mark Present'),

                                        );
                                      }


                                  }).toList();
                                },
                              )
                              // IconButton(
                              //   icon:Icon(Icons.arrow_drop_down_outlined,color: Colors.white,),
                              //   onPressed: (){},
                              // )
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Text('${widget.list.values.elementAt(index)['attendence']}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          //     IconButton(
                          //       icon: Icon(Icons.p),
                          //     )
                          //   ],
                          // )

                        ],
                      ),
                    )
                  ),
                ),
              );
            },
                  childCount:widget.list.values.length,

            ),

            ),

          ],
        )
      ),
    );
  }
  void choiceAction(String choice)
  {
    if(listOfAttendence[i].attendence=='Present')
      {
            print('mark absent');
            setState(() {
              listOfAttendence[i].attendence='Absent';
              int l=widget.list.values.length;
              for(int k=0;k<l;k++)
                {
                  if(widget.list.values.elementAt(k)['uid']==listOfAttendence[i].uid)
                    {
                      widget.list.values.elementAt(k)['attendence']='Absent';
                      listChanges.add(saveChangesList(k,'Present',i));
                    }
                }

              changesMade=true;
            });
            // print(widget.list);

      }
    else
      {
        print('mark present');
        setState(() {
          listOfAttendence[i].attendence='Present';
          int l=widget.list.values.length;
          for(int k=0;k<l;k++)
          {
            if(widget.list.values.elementAt(k)['uid']==listOfAttendence[i].uid)
            {
              widget.list.values.elementAt(k)['attendence']='Present';
              listChanges.add(saveChangesList(k,'Absent',i));
            }
          }
          // widget.list.values.elementAt(i)['attendence']='Present';
          changesMade=true;
        });
      }
    // print(widget.list.values);
    // print('${widget.list.values.elementAt(i)['attendence']}');
  }
  // download() async{
  //
  //   List<List<dynamic>> rows = List<List<dynamic>>();
  //   rows.add(["Roll No","First Name","Last Name","Attendence"]);
  //
  //   for(int i=0;i<widget.list.values.length;i++)
  //     {
  //       List<dynamic> row = List<dynamic>();
  //       row.add(listOfAttendence[i].rollNo);
  //       row.add(listOfAttendence[i].studentName);
  //       row.add(listOfAttendence[i].lastName);
  //       row.add(listOfAttendence[i].attendence);
  //       rows.add(row);
  //       // print(rows);
  //     }
  //   File f= await _localFile;
  //   String csv=const ListToCsvConverter().convert(rows);
  //   print(csv);
  //   f.writeAsString(csv);
  // await sendMailAndAttachment();
  //
  //
  // }



}

class Constants{
  static const String Absent='Mark Present';
  static const String Present='Mark Absent';
  static const List<String> choices=<String>[
    Absent
  ];
}

