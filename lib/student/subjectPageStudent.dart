
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mark/pageTransitions/bouncyPageRoute.dart';
import 'package:mark/teacher/attendenceLists.dart';
import 'package:mark/teacher/attendencePage.dart';
// import 'package:firebase/firebase.dart';
//Pages
import '../loading.dart';
// import 'totalStudents.dart';
// import 'takeAttendence.dart';
//transition
import 'package:mark/pageTransitions/sideTransition.dart';
//Calender
import 'package:table_calendar/table_calendar.dart';


// import '


class SubjectStudent extends StatefulWidget {
  // String i;
  String userDocId;
  // String classDocID;
  String ref;
  SubjectStudent({this.userDocId,this.ref});


  @override
  _SubjectStudentState createState() => _SubjectStudentState();
}

class _SubjectStudentState extends State<SubjectStudent> {
  CalendarController _calendarController;
  Stream st;
  var user=FirebaseAuth.instance.currentUser;
  var _selectedEvent=new List<attendenceListMain>();
  int selectedListLength;
  String attendenceDocID;
  var weekday=['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
  var listAll=new List<attendenceListMain>();
  int listAllLength=0;
  var listOfAttendence=new List<attendenceListSub>();
  int l;
  bool calendar=true;




  // List event;
  // DateTime dateSelected=DateTime.now();
  DateTime todaysDate=DateTime.now();
  DateTime dateSelected=DateTime.now();
  String getAttendence(Map l){
    var user=FirebaseAuth.instance.currentUser;
    int la=l.values.length;
    for(int i=0;i<la;i++)
      {
        if(l.values.elementAt(i)['studentName'].toString()=='student')
          {
            return l.values.elementAt(i)['attendence'].toString();
          }


      }
    return 'Not Recorded';


  }
  Future getCalendarDate() async
  {
    // setState(() {
    //   selectedListLength=0;
    //   // _selectedEvent=[];
    // });
    // // var docID=widget.userDocId;
    // FirebaseFirestore.instance.collection('${widget.ref}/Attendence').getDocuments().then((docs){
    //
    //
    //   setState(() {
    //     l=docs.documents.length;
    //   });
    //
    //   for(int i=0;i<l;i++)
    //     {
    //       listAll.add(attendenceListMain(docs.documents[i].data()['dateTime'], docs.documents[i].data()['attendence'], docs.documents[i].documentID));
    //       setState(() {
    //         listAllLength++;
    //       });
    //
    //     }
      setState(() {
        selectedListLength=0;
      });
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
      // for(int i=0;i<selectedListLength;i++)
      // {
      //   print(_selectedEvent[i].dateTime.toDate());
      //   print(_selectedEvent[i].attendence);
      // }


     listAll.sort((a,b){

        return a.dateTime.toDate().compareTo(b.dateTime.toDate());
      });
      listAll=listAll.reversed.toList();
      // for(int i=0;i<l;i++)
      //   {
      //     print(listAll[i].dateTime.toDate());
      //   }


      
      
    // }).catchError((e){
    //   print(e);
    // });

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
      selectedListLength=0;
      // _selectedEvent=[];
    });
    // var docID=widget.userDocId;
    FirebaseFirestore.instance.collection('${widget.ref}/Attendence').getDocuments().then((docs) {
      setState(() {
        l = docs.documents.length;
      });

      for (int i = 0; i < l; i++) {
        listAll.add(attendenceListMain(docs.documents[i].data()['dateTime'],
            docs.documents[i].data()['attendence'],
            docs.documents[i].documentID));
        setState(() {
          listAllLength++;
        });

      }
      getCalendarDate();
    }).catchError((e){
      print(e);
    });



    // for(int i=0;i<l;i++)
    // {
    //   Map list=listAll[i].attendence;
    //   int lA=list.values.length;
    //   for(int j=0;j<lA;j++)
    //     {
    //       listOfAttendence.add(attendenceListSub(list.values.elementAt(j)['attendence'],list.values.elementAt(j)['rollNo'] ,list.values.elementAt(j)['studentName']));
    //     }
    //
    // }
    // for(int i=0;i<l;i++)
    //   {
    //     print(listOfAttendence[i]);
    //   }

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


            calendar==false?IconButton(
              color: Colors.red,
              icon: Icon(Icons.date_range_rounded,),
              onPressed: (){
                setState(() {
                  calendar=true;
                });
              },
            ):IconButton(
              color: Colors.red,
              icon: Icon(Icons.list_rounded,),
              onPressed: (){
                  setState(() {
                    calendar=false;
                  });
              },
            ),
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
              setState(() async{
                dateSelected=date;
                _selectedEvent=[];
                selectedListLength=0;
                // print('${dateSelected.day}/${dateSelected.month}/${dateSelected.year}');
                await getCalendarDate();

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
                    expandedHeight: calendar==true?490:200,
                    // forceElevated: true,
                    backgroundColor: Colors.white,
                    floating: false,
                    pinned: false,
                    flexibleSpace: calendar==true?FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,

                      background: Padding(

                        padding: const EdgeInsets.only(top: 90),
                        child: content(),

                      ),
                    ):FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,

                      background: Padding(

                        padding: const EdgeInsets.only(top: 30),
                        child: Center(child: Text('Your Overall Attendence',style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),)),

                      ),
                    ),
                  ),

                  // SliverList(
                  //
                  //   delegate:SliverChildBuilderDelegate((context,index)=>
                  //        Padding(
                  //       padding: const EdgeInsets.only(left: 15,right: 15,top: 7,bottom: 7),
                  //   child: InkWell(
                  //
                  //     onTap: (){
                  //       // print('hi');
                  //       // Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
                  //       //   // return AttendencePage(current: _selectedEvent[index].dateTime,list: _selectedEvent[index].attendence,userDocID: widget.userDocId,classDocId: widget.classDocID,documentIDAttendence: _selectedEvent[index].documentID,);
                  //       // }));
                  //     },
                  //     child: Material(
                  //       elevation: 10,
                  //       borderRadius: BorderRadius.circular(30),
                  //       child: Container(
                  //         // child: Text(snapshot.data.documents[index].data()['dateTime'].toString()),
                  //         height: 100,
                  //         child: Center(child: Padding(
                  //           padding: const EdgeInsets.all(15.0),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text('${weekday[listAll[index].dateTime.toDate().weekday-1]}',style: TextStyle(color: Colors.black,fontSize: 22),),
                  //                   Text('${listAll[index].dateTime.toDate().hour}:${_selectedEvent[index].dateTime.toDate().minute}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  //                 ],
                  //               ),
                  //               Text(getAttendence(listAll[index].attendence),style: TextStyle(color: Colors.black,fontSize: 20),),
                  //             ],
                  //           ),
                  //         )),
                  //         decoration: BoxDecoration(
                  //             gradient: LinearGradient(
                  //                 begin: Alignment.topLeft,
                  //                 end: Alignment.bottomRight,
                  //                 colors: [Colors.white,Colors.red]
                  //             ),
                  //             borderRadius: BorderRadius.circular(30)
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  //     childCount: listAllLength,
                  //
                  //   ),
                  //
                  // ),
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

                  calendar==false?SliverList(

                    delegate: SliverChildBuilderDelegate((context,index)=>Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 5),
                      child:InkWell(

                        onTap: (){
                          // print('hi');
                          // Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
                          //   // return AttendencePage(current: _selectedEvent[index].dateTime,list: _selectedEvent[index].attendence,userDocID: widget.userDocId,classDocId: widget.classDocID,documentIDAttendence: _selectedEvent[index].documentID,);
                          // }));
                        },
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            // child: Text(snapshot.data.documents[index].data()['dateTime'].toString()),
                            height: 100,
                            child: Center(child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${listAll[index].dateTime.toDate().toString().substring(0,10)}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                      Text('${weekday[listAll[index].dateTime.toDate().weekday-1]}',style: TextStyle(color: Colors.black,fontSize: 22),),
                                      Text('${listAll[index].dateTime.toDate().hour}:${listAll[index].dateTime.toDate().minute}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    ],
                                  ),
                                  Text(getAttendence(listAll[index].attendence),style: TextStyle(color: Colors.black,fontSize: 20),),
                                ],
                              ),
                            )),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Colors.white,Colors.red]
                                ),
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                      ),
                    ),

                      // childCount: snapshot.data.documents.length,
                      childCount: listAllLength,
                    ),

                  ):SliverToBoxAdapter(),
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
            calendar==true?DraggableScrollableSheet(
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

                              controller: controller,
                              itemCount: selectedListLength,
                              itemBuilder: (BuildContext context,index){
                                return Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15,top: 7,bottom: 7),
                                  child: InkWell(

                                    onTap: (){
                                      // print('hi');
                                      // Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
                                      //   // return AttendencePage(current: _selectedEvent[index].dateTime,list: _selectedEvent[index].attendence,userDocID: widget.userDocId,classDocId: widget.classDocID,documentIDAttendence: _selectedEvent[index].documentID,);
                                      // }));
                                    },
                                    child: Material(
                                      elevation: 10,
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        // child: Text(snapshot.data.documents[index].data()['dateTime'].toString()),
                                        height: 100,
                                        child: Center(child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('${weekday[_selectedEvent[index].dateTime.toDate().weekday-1]}',style: TextStyle(color: Colors.black,fontSize: 22),),
                                                  Text('${_selectedEvent[index].dateTime.toDate().hour}:${_selectedEvent[index].dateTime.toDate().minute}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                                ],
                                              ),
                                              Text(getAttendence(_selectedEvent[index].attendence),style: TextStyle(color: Colors.black,fontSize: 20),),
                                            ],
                                          ),
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
                }):Container(),
          ],

        ),



        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(left: 30),
        //   child: FloatingActionButton(
        //       elevation: 10.0,
        //       child: new Icon(Icons.add,size: 30,color: selectedListLength==0?Colors.white:Colors.red,),
        //       backgroundColor: selectedListLength==0?Colors.red:Colors.white,
        //       onPressed: (){
        //         Navigator.push(
        //             context, BouncyPageRoute(widget: TakeAttendence(i: widget.i,userDocId: widget.userDocId,classDocId: widget.classDocID,)));
        //       }
        //   ),
        // ),


      ),
    );
  }

}

