import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mark/services/usermanagement.dart';

class TeacherProfile extends StatefulWidget {
  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  bool list=true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.grey,),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert,color: Colors.grey,),
              onPressed: (){
                UserManagement().signOut();
                Navigator.of(context).pop();
              } ,
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(

                  transitionOnUserGestures:false,
                  tag: 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(62.5),
                      image:DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                        fit: BoxFit.cover,

                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey,
                      //     spreadRadius: 3,
                      //     blurRadius: 5,
                      //   )
                      // ]
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Text('Rick Grimmes',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
                SizedBox(height: 4,),
                Text('Manhattan, NY',style: TextStyle(color: Colors.grey,fontSize: 15),),
                Padding(
                    padding: EdgeInsets.all(30),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('24K',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            SizedBox(height: 4,),
                            Text('FOLLOWERS',style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('21',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            SizedBox(height: 4,),
                            Text('TRIPS',style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('32',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            SizedBox(height: 4,),
                            Text('BUCKET LIST',style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                      ],
                    )
                ),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 0),
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.grid_on,color: list==false?Colors.blue:Colors.grey,),
                        onPressed: (){
                          setState(() {
                            list=false;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.list,color:list==true?Colors.blue:Colors.grey,),
                        onPressed: (){
                          setState(() {

                            list=true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                list==true?_buildImage():_buildImageGrid(),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget _buildImage(){
    return Padding(
      padding: EdgeInsets.only(left: 15,right: 15,top: 25),
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: Row(
              children: <Widget>[
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width-30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1469474968028-56623f02e42e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1053&q=80'),
                        fit: BoxFit.cover,

                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.1,
                          blurRadius: 4,

                        )
                      ]
                  ),
                ),
                // SizedBox(width: 2,),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: <Widget>[
                //     Container(
                //       height: 111.5,
                //       width: MediaQuery.of(context).size.width/2-72,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
                //           image: DecorationImage(
                //             image: NetworkImage('https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80'),
                //             fit: BoxFit.cover,
                //           ),
                //           boxShadow: [
                //             BoxShadow(
                //               color: Colors.grey,
                //               spreadRadius: 0.1,
                //               blurRadius: 4,
                //             )]
                //
                //       ),
                //
                //     ),
                //     SizedBox(height: 2,),
                //     Container(
                //       height: 111.5,
                //       width: MediaQuery.of(context).size.width/2-72,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
                //         image: DecorationImage(
                //           image: NetworkImage('https://images.unsplash.com/photo-1508672019048-805c876b67e2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1093&q=80',),
                //           fit: BoxFit.cover,
                //
                //         ),
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.grey,
                //             spreadRadius: 0.1,
                //             blurRadius: 4,
                //           )],
                //       ),
                //     ),
                //
                //   ],
                // )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15,right: 15,top: 0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.send,color: Colors.blue.shade300,),
                      onPressed: (){},
                    ),
                    IconButton(
                      icon: Icon(Icons.comment,color: Colors.blue.shade300,),
                      onPressed: (){},
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite,color: Colors.blue.shade300,),
                      onPressed: (){},
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text('Maui Summer 2020',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Rick added 42 photos',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(width: 20,),
                            Icon(Icons.timer,color: Colors.black,size: 5,),
                            SizedBox(width: 2,),
                            Text('2h ago',style: TextStyle(color: Colors.grey,fontSize: 12),),
                          ],
                        ),

                      ],
                    ),

                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _buildImageGrid(){
    return Padding(
      padding: EdgeInsets.only(left: 15,right: 15,top: 25),
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            child: Row(
              children: <Widget>[
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width/2-30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1469474968028-56623f02e42e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1053&q=80'),
                        fit: BoxFit.cover,

                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.1,
                          blurRadius: 4,

                        )
                      ]
                  ),
                ),
                // SizedBox(width: 2,),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: <Widget>[
                //     Container(
                //       height: 111.5,
                //       width: MediaQuery.of(context).size.width/2-72,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
                //           image: DecorationImage(
                //             image: NetworkImage('https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80'),
                //             fit: BoxFit.cover,
                //           ),
                //           boxShadow: [
                //             BoxShadow(
                //               color: Colors.grey,
                //               spreadRadius: 0.1,
                //               blurRadius: 4,
                //             )]
                //
                //       ),
                //
                //     ),
                //     SizedBox(height: 2,),
                //     Container(
                //       height: 111.5,
                //       width: MediaQuery.of(context).size.width/2-72,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
                //         image: DecorationImage(
                //           image: NetworkImage('https://images.unsplash.com/photo-1508672019048-805c876b67e2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1093&q=80',),
                //           fit: BoxFit.cover,
                //
                //         ),
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.grey,
                //             spreadRadius: 0.1,
                //             blurRadius: 4,
                //           )],
                //       ),
                //     ),
                //
                //   ],
                // )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10,right: 15,top: 0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.send,color: Colors.blue.shade300,),
                      onPressed: (){},
                    ),
                    IconButton(
                      icon: Icon(Icons.comment,color: Colors.blue.shade300,),
                      onPressed: (){},
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite,color: Colors.blue.shade300,),
                      onPressed: (){},
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text('Grid...',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Rick added 42 photos',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(width: 20,),
                            Icon(Icons.timer,color: Colors.black,size: 5,),
                            SizedBox(width: 2,),
                            Text('2h ago',style: TextStyle(color: Colors.grey,fontSize: 12),),
                          ],
                        ),

                      ],
                    ),

                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


