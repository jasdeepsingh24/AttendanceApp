import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mark/teacher/attendenceLists.dart';

class getAttendenceList{

   String getAttendencePercentage(String uid,List<attendenceListMain> a){

     int l=a.length;
     int classesAttended=0;
     for(int k=0;k<l;k++)
     {
       Map l=a[k].attendence;
       int la=l.values.length;
       for(int i=0;i<la;i++)
       {
         if(l.values.elementAt(i)['uid'].toString()==uid)
         {
           if(l.values.elementAt(i)['attendence']=='Present')
             {
               classesAttended++;
             }

           // return l.values.elementAt(i)['attendence'].toString();
         }


       }
       // print(a[k].attendence.values);
     }
     double p=(classesAttended/l)*100;

     // return p.toString().substring(0,5);
     String x=p.toStringAsFixed(2).toString();
     if(x=='NaN')
       {
         return '0';
       }

  return x;


    // else
    //   {
    //     if(p>=90)
    //       {
    //         return Colors.green;
    //       }
    //     else if(p<90 && p>=85)
    //       {
    //         return Colors.blue;
    //       }
    //     else if(p>=80 &&p<85)
    //       {
    //         return 'Colors.orange';
    //       }
    //     else if(p>=75 && p<=80)
    //       {
    //         return 'Colors.yellow';
    //       }
    //     else{
    //       return 'COlors.red';
    //     }
    //   }

  }
  Color getAttendenceColors(String uid,List<attendenceListMain> a){
     String x=getAttendencePercentage(uid, a);
     double p=double.parse(x);


     if(p>=90)
     {
       return Colors.green.shade900;
     }
     else if(p<90 && p>=85)
     {
       return Colors.blue.shade900;
     }
     else if(p>=80 &&p<85)
     {
       return Colors.orange.shade900;
     }
     else if(p>=75 && p<=80)
     {
       return Colors.yellow.shade900;
     }
     else{
       return Colors.red.shade900;
     }
  }
}
