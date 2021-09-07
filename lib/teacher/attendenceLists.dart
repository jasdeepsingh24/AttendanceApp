

import 'package:cloud_firestore/cloud_firestore.dart';

class attendenceListMain{

  attendenceListMain(Timestamp t,Map j,String d)
  {
    dateTime=t;
    attendence=j;
    documentID=d;

  }
  Timestamp dateTime;
  Map attendence;
  String documentID;

}

class attendenceListSub{
  String attendence;
  String rollNo;
  String studentName;
  String uid;
  String lastName;
  attendenceListSub(String a,String r,String s,String u,String ln){
    attendence=a;
    rollNo=r;
    studentName=s;
    uid=u;
    lastName=ln;
  }

}
class saveChangesList{
  int i;
  int x;
  String attendence;
  saveChangesList(int n,String a,int b)
  {
    i=n;
    attendence=a;
    x=b;
  }
}