import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thumbnails/thumbnails.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  File videoFile;
  TextEditingController prodcutTitle = new TextEditingController();
  TextEditingController prodcutPrice = new TextEditingController();
  TextEditingController firstReading = new TextEditingController();
  TextEditingController secondReading = new TextEditingController();
  TextEditingController thirdReading = new TextEditingController();
  bool _isLoading = false;
  double _progress;



  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    super.initState();
  }



  void addNewProducts() async{
    if (videoFile == null) {
      final snackbar = SnackBar(
        content: Text('you have not selected a video'),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    }

    if (prodcutTitle.text == "") {
      final snackbar = SnackBar(
        content: Text('Enter Title'),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    }

    if (prodcutPrice.text == "") {
      final snackbar = SnackBar(
        content: Text('Enter Preacher Name'),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    }

    else {
      var appDocDir = await getApplicationDocumentsDirectory();
      final folderPath = appDocDir.path;
      final thumb = await VideoThumbnail.thumbnailFile(
        video: videoFile.path.toString(),
        thumbnailPath: folderPath,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 400, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
        quality: 100,
      );
      final thumbImage = File(thumb);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(thumb);
      StorageUploadTask upload = firebaseStorageRef.putFile(thumbImage,);
      StorageTaskSnapshot taskSnapshot=await upload.onComplete;

      String Imageurl = await taskSnapshot.ref.getDownloadURL();

      StorageReference reference =
      FirebaseStorage.instance.ref().child(videoFile.path.toString());
      StorageUploadTask uploadTask = reference.putFile(videoFile);

      uploadTask.events.listen((event) {
        setState(() {
          _isLoading = true;
          _progress = event.snapshot.bytesTransferred.toDouble() / event.snapshot.totalByteCount.toDouble();
        });
      }).onError((error) {
        scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(error.toString()), backgroundColor: Colors.red,) );
      });

      uploadTask.onComplete.then((snapshot) {
        setState(() {
          _isLoading = false;
        });
      });

      StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;

      String url = await downloadUrl.ref.getDownloadURL();




      await Firestore.instance.runTransaction((Transaction transaction) async {
        CollectionReference reference = Firestore.instance.collection(
            'videos');

        await reference.add({
          "Title": prodcutTitle.text,
          "preacher": prodcutPrice.text,
          "video": url,
          "reading1": firstReading.text,
          "reading2": secondReading.text,
          "reading3": thirdReading.text,
          "thumbNail": Imageurl,
          "time": DateTime.now()
        });
      }).then((result) =>

          _showRequest());
    }
  }

  void _showRequest() {
    // flutter defined function

    setState(() {
      prodcutTitle.text= "";
      prodcutPrice.text="";
      firstReading.text="";
      secondReading.text="";
      thirdReading.text="";
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Your data has been saved"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        bottom: _isLoading ? PreferredSize(
          child: LinearProgressIndicator(
            value: _progress,
            backgroundColor: Colors.white,
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 5.0),
        ) : null,
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Visibility(
              visible: _controller != null,
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the VideoPlayerController has finished initialization, use
                    // the data it provides to limit the aspect ratio of the video.
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      // Use the VideoPlayer widget to display the video.
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    // If the VideoPlayerController is still initializing, show a
                    // loading spinner.
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Center(
              child: new RaisedButton.icon(
                  color: Colors.red[900],
                  shape: new RoundedRectangleBorder(
                      borderRadius:
                      new BorderRadius.all(new Radius.circular(15.0))),
                  onPressed: () => getVideo(),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: new Text(
                    "Select video to upload",
                    style: new TextStyle(color: Colors.white),
                  )),

            ),
            new SizedBox(
              height: 10.0,
            ),
            productTextField(
                textTitle: "Sermon Title",
                textHint: "Enter Sermon Title",
                controller: prodcutTitle),
            new SizedBox(
              height: 10.0,
            ),
            productTextField(
                textTitle: "Preacher name",
                textHint: "Enter Preacher name",
                controller: prodcutPrice),
            new SizedBox(
              height: 10.0,
            ),
            productTextField(
                textTitle: "Readings",
                textHint: "Enter readings",
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: firstReading),
            new SizedBox(
              height: 10.0,
            ),
            productTextField(
                textTitle: "Second reading",
                textHint: "Second reading",
                controller: secondReading),
            new SizedBox(
              height: 10.0,
            ),
            productTextField(
                textTitle: "Third Reading",
                textHint: "Enter Third reading",
                controller: thirdReading),
            new SizedBox(
              height: 10.0,
            ),
            new SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: new EdgeInsets.all(10.0),
              child: new RaisedButton(
                color: Colors.red[900],
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.all(new Radius.circular(15.0))),
                onPressed: addNewProducts,
                child: Container(
                  height: 50.0,
                  child: new Center(
                    child: new Text(
                      "save",
                      style: new TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
      floatingActionButton: _controller == null
          ? null
          : FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future getVideo() async {
    Future<File> _videoFile =
    ImagePicker.pickVideo(source: ImageSource.gallery);
    _videoFile.then((file) async {
      setState(() {
        videoFile = file;
        _controller = VideoPlayerController.file(videoFile);

        // Initialize the controller and store the Future for later use.
        _initializeVideoPlayerFuture = _controller.initialize();

        // Use the controller to loop the video.
        _controller.setLooping(true);
      });
    });
  }
}

Widget productTextField(
    {String textTitle,
      String textHint,
      double height,
      TextEditingController controller,
      TextInputType textType, TextInputAction textInputAction, TextInputType keyboardType, maxLines}) {
  textTitle == null ? textTitle = "Enter Title" : textTitle;
  textHint == null ? textHint = "Enter Hint" : textHint;
  height == null ? height = 50.0 : height;
  //height !=null

  return Column(
    //mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Text(
          textTitle,
          style:
          new TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      new Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Container(
          height: height,
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: Colors.white),
              borderRadius: new BorderRadius.all(new Radius.circular(4.0))),
          child: new Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new TextField(
              controller: controller,
              keyboardType: textType == null ? TextInputType.text : textType,
              maxLines: 4,
              decoration: new InputDecoration(
                  border: InputBorder.none, hintText: textHint),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget appButton(
    {String btnTxt,
      double btnPadding,
      Color btnColor,
      VoidCallback onBtnclicked}) {
  btnTxt == null ? btnTxt == "App Button" : btnTxt;
  btnPadding == null ? btnPadding = 0.0 : btnPadding;
  btnColor == null ? btnColor = Colors.black : btnColor;

  return Padding(
    padding: new EdgeInsets.all(btnPadding),
    child: new RaisedButton(
      color: Colors.red,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(new Radius.circular(15.0))),
      onPressed: onBtnclicked,
      child: Container(
        height: 50.0,
        child: new Center(
          child: new Text(
            btnTxt,
            style: new TextStyle(color: btnColor, fontSize: 18.0),
          ),
        ),
      ),
    ),
  );
}
