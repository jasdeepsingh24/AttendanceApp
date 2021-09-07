
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mark/pageTransitions/bouncyPageRoute.dart';
import 'package:mark/teacher/attendenceLists.dart';
import 'package:mark/teacher/attendencePage.dart';
import 'package:intl/intl.dart';
// import 'package:firebase/firebase.dart';
//Pages
import '../loading.dart';
import 'totalStudents.dart';
import 'takeAttendence.dart';
import 'package:mark/services/usermanagement.dart';
//transition
import 'package:mark/pageTransitions/sideTransition.dart';
//Calender
import 'package:table_calendar/table_calendar.dart';


// import '


class Subject extends StatefulWidget {
  String i;
  String userDocId;
  String classDocID;
  String ref;
  Subject({this.i,this.userDocId,this.classDocID,this.ref});


  @override
  _SubjectState createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  CalendarController _calendarController;
  Stream st;
  var user=FirebaseAuth.instance.currentUser;
  var _selectedEvent=new List<attendenceListMain>();
  int selectedListLength;
  String attendenceDocID;
  var listAll=new List<attendenceListMain>();
  int l;
  var docID;
  var classDocID;


  // List event;
  // DateTime dateSelected=DateTime.now();
  DateTime todaysDate=DateTime.now();
  DateTime dateSelected=DateTime.now();
  Future getCalendarDate() async
  {
    setState(() {
      selectedListLength=0;
    });
    // var docID=widget.userDocId;
    // var classDocID=widget.classDocID;
    // // setState(() => st=FirebaseFirestore.instance.collection('/users/${docID}/classes/${classDocID}/Attendence').where('datetime',isEqualTo: '${dateSelected.day}/${dateSelected.month}/${dateSelected.year}').snapshots());
    // FirebaseFirestore.instance.collection('/users/${docID}/classes/${classDocID}/Attendence').getDocuments().then((docsCalendar){
    //   setState(() {
    //     l=docsCalendar.documents.length;
    //   });
    //
    //   for(int i=0;i<l;i++)
    //   {
    //     listAll.add(attendenceListMain(docsCalendar.documents[i].data()['dateTime'] , docsCalendar.documents[i].data()['attendence'],docsCalendar.documents[i].documentID));
    //   }

      for(int i=0;i<l;i++)
      {
        String dateSelectedString='${dateSelected.year}-${dateSelected.month}-${dateSelected.day}';
        String listDateString='${listAll[i].dateTime.toDate().year}-${listAll[i].dateTime.toDate().month}-${listAll[i].dateTime.toDate().day}';
        print('${dateSelected.year}-${dateSelected.month}-${dateSelected.day}');
        print('${listAll[i].dateTime.toDate().year}-${listAll[i].dateTime.toDate().month}-${listAll[i].dateTime.toDate().day}');
        if(dateSelectedString==listDateString)
        {
          _selectedEvent.add(attendenceListMain(listAll[i].dateTime, listAll[i].attendence,listAll[i].documentID));
          setState(() {
            selectedListLength++;
          });
        }


        print('printing attendence data ${listAll[i].dateTime.toDate().toString().substring(0,10)}    ----    ${listAll[i].attendence.values}');

      }
      for(int i=0;i<selectedListLength;i++)
      {
        print(_selectedEvent[i].dateTime.toDate());
        print(_selectedEvent[i].attendence);
      }


      // print(l1);
    // }).catchError((e){
    //   print(e);
    // });
    // FirebaseFirestore.instance.collection('/users/${docID}/classes').getDocuments().then((classDoc){
    //   // var classDocID=classDoc.documents[int.parse(widget.i)].documentID;
    //   var classDocID=widget.classDocID;
    //   // setState(() => st=FirebaseFirestore.instance.collection('/users/${docID}/classes/${classDocID}/Attendence').where('datetime',isEqualTo: '${dateSelected.day}/${dateSelected.month}/${dateSelected.year}').snapshots());
    //   FirebaseFirestore.instance.collection('/users/${docID}/classes/${classDocID}/Attendence').getDocuments().then((docsCalendar){
    //     int l=docsCalendar.documents.length;
    //
    //     for(int i=0;i<l;i++)
    //     {
    //       listAll.add(attendenceListMain(docsCalendar.documents[i].data()['dateTime'] , docsCalendar.documents[i].data()['attendence']));
    //     }
    //
    //     for(int i=0;i<l;i++)
    //     {
    //       String dateSelectedString='${dateSelected.year}-${dateSelected.month}-${dateSelected.day}';
    //       String listDateString='${listAll[i].dateTime.toDate().year}-${listAll[i].dateTime.toDate().month}-${listAll[i].dateTime.toDate().day}';
    //       print('${dateSelected.year}-${dateSelected.month}-${dateSelected.day}');
    //       print('${listAll[i].dateTime.toDate().year}-${listAll[i].dateTime.toDate().month}-${listAll[i].dateTime.toDate().day}');
    //       if(dateSelectedString==listDateString)
    //       {
    //         _selectedEvent.add(attendenceListMain(listAll[i].dateTime, listAll[i].attendence));
    //         setState(() {
    //           selectedListLength++;
    //         });
    //       }
    //
    //
    //       print('printing attendence data ${listAll[i].dateTime.toDate().toString().substring(0,10)}    ----    ${listAll[i].attendence.values}');
    //
    //     }
    //     for(int i=0;i<selectedListLength;i++)
    //     {
    //       print(_selectedEvent[i].dateTime.toDate());
    //       print(_selectedEvent[i].attendence);
    //     }
    //
    //
    //     // print(l1);
    //   }).catchError((e){
    //     print(e);
    //   });
    // }).catchError((e){
    //   print(e);
    // });
   // await  FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((doc){
   //    // var docID=doc.documents[0].documentID;
   //   var docID=widget.userDocId;
   //    FirebaseFirestore.instance.collection('/users/${docID}/classes').getDocuments().then((classDoc){
   //      var classDocID=classDoc.documents[int.parse(widget.i)].documentID;
   //      // setState(() => st=FirebaseFirestore.instance.collection('/users/${docID}/classes/${classDocID}/Attendence').where('datetime',isEqualTo: '${dateSelected.day}/${dateSelected.month}/${dateSelected.year}').snapshots());
   //      FirebaseFirestore.instance.collection('/users/${docID}/classes/${classDocID}/Attendence').getDocuments().then((docsCalendar){
   //        int l=docsCalendar.documents.length;
   //
   //        for(int i=0;i<l;i++)
   //          {
   //            listAll.add(attendenceListMain(docsCalendar.documents[i].data()['dateTime'] , docsCalendar.documents[i].data()['attendence']));
   //          }
   //
   //        for(int i=0;i<l;i++)
   //          {
   //            String dateSelectedString='${dateSelected.year}-${dateSelected.month}-${dateSelected.day}';
   //            String listDateString='${listAll[i].dateTime.toDate().year}-${listAll[i].dateTime.toDate().month}-${listAll[i].dateTime.toDate().day}';
   //            print('${dateSelected.year}-${dateSelected.month}-${dateSelected.day}');
   //            print('${listAll[i].dateTime.toDate().year}-${listAll[i].dateTime.toDate().month}-${listAll[i].dateTime.toDate().day}');
   //            if(dateSelectedString==listDateString)
   //              {
   //                _selectedEvent.add(attendenceListMain(listAll[i].dateTime, listAll[i].attendence));
   //                setState(() {
   //                  selectedListLength++;
   //                });
   //              }
   //
   //
   //            print('printing attendence data ${listAll[i].dateTime.toDate().toString().substring(0,10)}    ----    ${listAll[i].attendence.values}');
   //
   //          }
   //        for(int i=0;i<selectedListLength;i++)
   //          {
   //            print(_selectedEvent[i].dateTime.toDate());
   //            print(_selectedEvent[i].attendence);
   //          }
   //
   //
   //        // print(l1);
   //      }).catchError((e){
   //        print(e);
   //      });
   //    }).catchError((e){
   //      print(e);
   //    });
   //
   //  }).catchError((e){
   //    print(e);
   //  });
  }
  Future <void> deleteConfirmation(BuildContext context,DateTime t,String userDocID,String classDocID) async{

    return showDialog(

        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Delete',style: TextStyle(color: Colors.black,),),
            content: Text('Once you delete it,you can not retreive it in future.'),
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
                child: Text('Delete',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                onPressed: () async {
                  await UserManagement().deleteAttendenceFromTeacher(t,widget.userDocId,widget.classDocID);


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
  Future<void> reload(){
    getAllAttendenceData();
    getCalendarDate();
    // setState(() {
    //   dateSelected=DateTime.now();
    //   _selectedEvent=[];
    //   selectedListLength=0;
    //   // print('${dateSelected.day}/${dateSelected.month}/${dateSelected.year}');
    //   getCalendarDate();
    //
    // });
  }
  Future<void> getAllAttendenceData() async
  {
    FirebaseFirestore.instance.collection('/users/${docID}/classes/${classDocID}/Attendence').getDocuments().then((docsCalendar) {
      setState(() {
        l = docsCalendar.documents.length;
      });

      for (int i = 0; i < l; i++) {
        listAll.add(attendenceListMain(
            docsCalendar.documents[i].data()['dateTime'],
            docsCalendar.documents[i].data()['attendence'],
            docsCalendar.documents[i].documentID));
      }

    }).catchError((e){
      print(e);
    });
  }
  // getTime(DateTime t)
  // {
  //   String time;
  //   if(t.hour>12)
  //     {
  //       int x=int.parse(t.hour.toString());
  //       time=(12-x).toString();
  //     }
  //   return time;
  // }

@override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    _calendarController=CalendarController();
    setState(() {
      listAll=[];
      selectedListLength=0;
      docID=widget.userDocId;
      classDocID=widget.classDocID;
      // dateSelected=DateTime.now();
    });
    getAllAttendenceData();

    // setState(() => st=FirebaseFirestore.instance.collection('/users/${docID}/classes/${classDocID}/Attendence').where('datetime',isEqualTo: '${dateSelected.day}/${dateSelected.month}/${dateSelected.year}').snapshots());
    // FirebaseFirestore.instance.collection('/users/${docID}/classes/${classDocID}/Attendence').getDocuments().then((docsCalendar) {
    //   setState(() {
    //     l = docsCalendar.documents.length;
    //   });
    //
    //   for (int i = 0; i < l; i++) {
    //     listAll.add(attendenceListMain(
    //         docsCalendar.documents[i].data()['dateTime'],
    //         docsCalendar.documents[i].data()['attendence'],
    //         docsCalendar.documents[i].documentID));
    //   }
    //   getCalendarDate();
    // }).catchError((e){
    //   print(e);
    // });
    getCalendarDate();

  }
  Widget abc(){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(0),
      child: Padding(
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
            // FlutterLogo(textColor: Colors.red,),


            IconButton(
              color: Colors.grey,
              icon: Icon(Icons.group_add_sharp,size: 30,),
              onPressed: (){
                Navigator.push(
                    context, SideTransition(widget: TotalStudents(i: widget.i,classDocID: widget.classDocID,userDocID: widget.userDocId,ref:widget.ref,listAll: listAll,)));
              },
            )
          ],
        ),
      ),
    );
  }

  Widget content(){
   return Padding(
     padding: const EdgeInsets.only(left:15,right:15,top:0,bottom: 25),
     child: Material(

       elevation: 10,

       borderRadius: BorderRadius.circular(50),
       child: Container(

         decoration: BoxDecoration(

           color: Colors.white70,
           borderRadius: BorderRadius.circular(50)
         ),
         child: TableCalendar(

           availableGestures: AvailableGestures.horizontalSwipe,
           onDaySelected: (date,event,holidays){
             setState(() {
               dateSelected=date;
               _selectedEvent=[];
               selectedListLength=0;
               // print('${dateSelected.day}/${dateSelected.month}/${dateSelected.year}');
                getCalendarDate();

             });


           },
            formatAnimation: FormatAnimation.scale,

           builders: CalendarBuilders(
             selectedDayBuilder: (context, date, events) => Container(
                 margin: const EdgeInsets.all(4.0),
                 alignment: Alignment.center,
                 decoration: BoxDecoration(
                     color: Colors.red,
                     borderRadius: BorderRadius.circular(10.0)),
                 child: Text(

                   date.day.toString(),
                   style: TextStyle(color: Colors.white,fontSize: 20),
                 )),
             todayDayBuilder: (context, date, events) => Container(
                 margin: const EdgeInsets.all(4.0),
                 alignment: Alignment.center,

                 decoration: BoxDecoration(

                     color: Colors.orangeAccent,
                     borderRadius: BorderRadius.circular(10.0)),
                 child: Text(
                   date.day.toString(),
                   style: TextStyle(color: Colors.white),
                 )),
           ),


           calendarStyle: CalendarStyle(

             renderSelectedFirst: true,
             // todayColor: Colors.red,
             // selectedColor: Colors.orange,
             // todayStyle: TextStyle(
             //   color: Colors.black,
             //   fontWeight: FontWeight.bold,
             //   fontSize: 20,
             // ),
             // selectedStyle: TextStyle(
             //   color: Colors.black,
             //   fontWeight: FontWeight.bold,
             //   fontSize: 20,
             // ),

           ),
           headerStyle: HeaderStyle(
             centerHeaderTitle: true,
             formatButtonShowsNext: false,
             formatButtonVisible: false,

           ),
           startingDayOfWeek: StartingDayOfWeek.monday,

           calendarController: _calendarController,
         ),
       ),
     ),
   );
  }





  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              color: Colors.transparent,
              child: CustomScrollView(
                physics: ScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),

                slivers: [

                  SliverAppBar(
                    title: abc(),
                    automaticallyImplyLeading: false,
                    expandedHeight: 490,
                    // forceElevated: true,
                    backgroundColor: Colors.white,
                    floating: false,
                    pinned: false,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,

                      background: Padding(

                        padding: const EdgeInsets.only(top: 90),
                        child: content(),

                      ),
                    ),
                  ),
                  // SliverToBoxAdapter(
                  //
                  //     child:Stack(
                  //
                  //       children: [
                  //         Container(
                  //
                  //           height:50,
                  //           color: Colors.white,
                  //
                  //         ),
                  //         Container(
                  //           height: 50,
                  //
                  //           decoration: BoxDecoration(
                  //
                  //             color: Colors.red,
                  //             borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
                  //           ),
                  //         ),
                  //         Container(
                  //           height: 50,
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(top: 5),
                  //             child: Row(
                  //
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Container(
                  //                   height: 2,
                  //                   width: 80,
                  //
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       borderRadius: BorderRadius.circular(1)
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     )
                  // ),

                  // selectedListLength!=0?SliverList(
                  //
                  //   delegate: SliverChildBuilderDelegate((context,index)=>Padding(
                  //     padding: const EdgeInsets.only(left: 15,right: 15,top: 7,bottom: 7),
                  //     child: Material(
                  //       elevation: 10,
                  //       borderRadius: BorderRadius.circular(30),
                  //       child: Container(
                  //         // child: Text(snapshot.data.documents[index].data()['dateTime'].toString()),
                  //         height: 100,
                  //         child: Center(child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 15),
                  //               child: Text('${_selectedEvent[index].dateTime.toDate().hour}:${_selectedEvent[index].dateTime.toDate().minute}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  //             ),
                  //           ],
                  //         )),
                  //         decoration: BoxDecoration(
                  //             gradient: LinearGradient(
                  //                 begin: Alignment.topLeft,
                  //                 end: Alignment.bottomRight,
                  //                 colors: [Colors.red,Colors.yellow]
                  //             ),
                  //             borderRadius: BorderRadius.circular(30)
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  //
                  //     // childCount: snapshot.data.documents.length,
                  //     childCount: selectedListLength,
                  //   ),
                  //
                  // ):SliverList(
                  //
                  //   delegate: SliverChildBuilderDelegate((context,index)=>Padding(
                  //     padding: const EdgeInsets.only(left: 15,right: 15,top: 7,bottom: 7),
                  //     child: Material(
                  //         elevation: 10,
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(30),
                  //         child: Container(
                  //             height: 100,
                  //             decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius: BorderRadius.circular(30),
                  //             ),
                  //             child: Center(child: Padding(
                  //               padding: const EdgeInsets.only(left: 15),
                  //               child: '${dateSelected.year}-${dateSelected.month}-${dateSelected.day}'=='${todaysDate.year}-${todaysDate.month}-${todaysDate.day}'?Text("Please Click on '+' button to take Attendence ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 17),):Text("Attendence was not taken on the following Date",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 17),),
                  //             ),))),
                  //   ),
                  //
                  //     // childCount: snapshot.data.documents.length
                  //     childCount: 1,
                  //   ),
                  //
                  // ),

                ],
              ),
            ),
            DraggableScrollableSheet(
                expand: true,
                minChildSize: 0.2,
                maxChildSize: 0.9,
                initialChildSize:0.2,

                builder:(context,controller){
              return Material(
                elevation: 10,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                color: Colors.red,
                shadowColor: Colors.grey,
                child: Stack(
                  children: [
                    Container(
                      child: selectedListLength!=0?ListView.builder(
                        physics: ScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                          controller: controller,
                          itemCount: selectedListLength,
                          itemBuilder: (BuildContext context,index){
                            return Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15,top: 7,bottom: 7),
                              child: InkWell(
                                onTap: (){
                                  // print('hi');
                                  Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
                                    return AttendencePage(current: _selectedEvent[index].dateTime,list: _selectedEvent[index].attendence,userDocID: widget.userDocId,classDocId: widget.classDocID,documentIDAttendence: _selectedEvent[index].documentID,);
                                  }));
                                },
                                child: Material(
                                  elevation: 10,
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    // child: Text(snapshot.data.documents[index].data()['dateTime'].toString()),
                                    height: 100,
                                    child: Center(child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          // child: Text('${_selectedEvent[index].dateTime.toDate().hour}:${_selectedEvent[index].dateTime.toDate().minute}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                          child: Text('${DateFormat.jm().format(_selectedEvent[index].dateTime.toDate())}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                        ),
                                        IconButton(icon: Icon(Icons.delete,color: Colors.black,),
                                            onPressed:(){
                                            deleteConfirmation(context,_selectedEvent[index].dateTime.toDate(),widget.userDocId,widget.classDocID);
                                            // UserManagement().deleteAttendenceFromTeacher(_selectedEvent[index].dateTime.toDate(),widget.userDocId,widget.classDocID);
                                        }),
                                      ],
                                    )),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [Colors.white,Colors.red]
                                        ),
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }):Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 7),
                        child: Material(
                            elevation: 10,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: '${dateSelected.year}-${dateSelected.month}-${dateSelected.day}'=='${todaysDate.year}-${todaysDate.month}-${todaysDate.day}'?Text("Please Click on '+' button to take Attendence ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 17),):
                                  dateSelected.compareTo(todaysDate)<0?
                                  Text("Attendence was not taken on the following Date",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 17),):Text("You can mark attendence only for today's Date",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 17),),
                                ),))),
                      ),
                    ),
                    Container(
                      // alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(left: (MediaQuery.of(context).size.width-60)/2,top: 5),
                      height: 3,
                      width: 60,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                    ),
                  ],

                ),
              );
            }),
          ],

        ),



          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FloatingActionButton(
                elevation: 10.0,
                child: new Icon(Icons.add,size: 30,color: selectedListLength==0?Colors.white:Colors.red,),
                backgroundColor: selectedListLength==0?Colors.red:Colors.white,
                onPressed: (){
                  Navigator.push(
                      context, BouncyPageRoute(widget: TakeAttendence(i: widget.i,userDocId: widget.userDocId,classDocId: widget.classDocID,listAll: listAll,)));
                }
            ),
          ),


      ),
    );
  }

}

