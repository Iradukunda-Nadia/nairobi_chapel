import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Connect extends StatefulWidget {
  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  final db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: db.collection('groups').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.documents.map((doc) {
                      return new GestureDetector(
                        onTap: (){},
                        child: new Card(
                          elevation:8,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Stack(
                                alignment: FractionalOffset.topLeft,
                                children: <Widget>[
                                  new Container(
                                    width: MediaQuery.of(context).size.width * 0.95,
                                    height: MediaQuery.of(context).size.height * 0.2,

                                    child: Container(
                                      decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: new NetworkImage(doc.data["image"]))
                                      ),
                                    ),

                                  ),

                                ],
                              ),
                              new Container(
                                height:90.0 ,
                                width: MediaQuery.of(context).size.width * 0.95,
                                color: Colors.white,
                                child: new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Column(
                                          children: <Widget>[
                                            new Text("${doc.data["title"]}",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 24.0,
                                                  color: Colors.black),),
                                            new Text("${doc.data["desc"]}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: new TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black87),),

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return SizedBox();
                }
              }),
        ],
      ),
    );
  }
}
