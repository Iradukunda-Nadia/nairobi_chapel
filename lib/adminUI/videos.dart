import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nairobi_chapel/adminUI/upload.dart';
import 'package:video_player/video_player.dart';

class videosAdmin extends StatefulWidget {
  @override
  _videosAdminState createState() => _videosAdminState();
}

class _videosAdminState extends State<videosAdmin> {

  Future getList() async{
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore.collection("videos").orderBy('time', descending: true).getDocuments();
    return snap.documents;
  }

  CollectionReference collectionReference =
  Firestore.instance.collection("videos");
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video list"),),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(12.0),
              children: <Widget>[
                SizedBox(height: 20.0),
                StreamBuilder<QuerySnapshot>(
                    stream: db.collection('videos').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data.documents.map((doc) {
                            return ListTile(
                              leading: Image.network(doc.data["thumbNail"]),
                              title: Text("${doc.data["Title"]}"),
                              subtitle: Text("${doc.data["preacher"]}"),
                              trailing: RaisedButton(
                                color: Colors.yellow,
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Delete this video"),
                                          content: Text("Are you sure??"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("Yes"),
                                              onPressed: () async {
                                                await db
                                                    .collection('videos')
                                                    .document(doc.documentID)
                                                    .delete();

                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text("Deleted"),
                                                        content: Text("Stand deleted from database"),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child: Text("Close"),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("No"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      });

                                },
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text('Delete',style: TextStyle(color: Colors.white),),
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


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add Sermon"),
        onPressed: (){
          Navigator.of(context).push(new CupertinoPageRoute(
              builder: (BuildContext context) => new  Upload()
          ));
        },
      ),
    );
  }
}