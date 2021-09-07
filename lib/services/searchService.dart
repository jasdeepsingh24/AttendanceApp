import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchService {
  searchByName(String searchField,int i)async {
    var user=FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((doc)async{
      var docID=doc.documents[0].documentID;
      await FirebaseFirestore.instance.collection('/users/${docID}/classes').getDocuments().then((classDoc)async{
        var classDocID=classDoc.documents[i].documentID;
        await FirebaseFirestore.instance.collection('/users/${docID}/classes/${classDocID}/Students').where('searchKey',isEqualTo: searchField.substring(0,1).toUpperCase()).getDocuments();
          print('hi');
      }).catchError((e){
        print(e);
      });

    }).catchError((e){
      print(e);
    });
    
    // return Firestore.instance
    //     .collection('clients')
    //     .where('searchKey',
    //     isEqualTo: searchField.substring(0, 1).toUpperCase())
    //     .getDocuments();
  }
}