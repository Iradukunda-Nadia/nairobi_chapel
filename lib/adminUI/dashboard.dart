import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nairobi_chapel/adminUI/addEvent.dart';
import 'package:nairobi_chapel/adminUI/videos.dart';
import 'package:nairobi_chapel/construction.dart';
import 'package:nairobi_chapel/events.dart';
import 'package:nairobi_chapel/loginUI/baseAuth.dart';
import 'package:nairobi_chapel/loginUI/root.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoggedIn = false;


  logout() async {

    Navigator.of(context).push(new CupertinoPageRoute(
        builder: (BuildContext context) => new RootPage(auth: new Auth())
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: <Widget>[
          new Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              WavyHeader(),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Text("Admin",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 54.0),
                    textAlign: TextAlign.center),
              ),
              Positioned(
                top: 40,
                left: 300,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 40,
                left: 300,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        PopupMenuButton(
                          icon: new Icon(Icons.person, color: Colors.black,),
                          onSelected: (String value) {
                            switch (value) {
                              case 'logout':
                                logout();
                                break;
                            // Other cases for other menu options
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem<String>(
                              value: "logout",
                              child: Row(
                                children: <Widget>[
                                  Text("LOGOUT"),
                                  Icon(Icons.exit_to_app, color: Colors.pink[900],),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                padding: EdgeInsets.all(16.0),
                childAspectRatio: 9.0 / 9.0,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(new CupertinoPageRoute(
                          builder: (BuildContext context) => new  videosAdmin()
                      ));
                    },
                    child: Card(
                      color: Colors.yellow,
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                              aspectRatio: 18.0 / 11.0,
                              child: Icon(Icons.import_contacts, size: 50.0, color: Colors.white,)
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Sermons', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(new CupertinoPageRoute(
                          builder: (BuildContext context) => new  EventsList()
                      ));
                    },
                    child: Card(
                      color: Colors.yellow,
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                              aspectRatio: 18.0 / 11.0,
                              child: Icon(Icons.assignment, size: 50.0, color: Colors.white,)
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Events', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(new CupertinoPageRoute(
                          builder: (BuildContext context) => new  Construction()
                      ));
                    },
                    child: Card(
                      color: Colors.yellow,
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                              aspectRatio: 18.0 / 11.0,
                              child: Icon(Icons.group_add, size: 50.0, color: Colors.white,)
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Connect', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(new CupertinoPageRoute(
                          builder: (BuildContext context) => new  Construction()
                      ));
                    },
                    child: Card(
                      color: Colors.yellow,
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                              aspectRatio: 18.0 / 11.0,
                              child: Icon(Icons.details, size: 50.0, color: Colors.white,)
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Prayer', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(new CupertinoPageRoute(
                          builder: (BuildContext context) => new  Construction()
                      ));
                    },
                    child: Card(
                      color: Colors.yellow,
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                              aspectRatio: 18.0 / 11.0,
                              child: Icon(Icons.layers, size: 50.0, color: Colors.white,)
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Programs', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(new CupertinoPageRoute(
                          builder: (BuildContext context) => new  Construction()
                      ));
                    },
                    child: Card(
                      color: Colors.yellow,
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                              aspectRatio: 18.0 / 11.0,
                              child: Icon(Icons.attach_money, size: 50.0, color: Colors.white,)
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Funds', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                ],// Replace
              ),
            ),
          )
        ],
      ),
    );
  }
}


const List<Color> orangeGradients = [
  Color(0xFFFFFFFF),
  Color(0xFFFFFFFF),
  Color(0xFFFFFFFF),
];

class WavyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: orangeGradients,
              begin: Alignment.topLeft,
              end: Alignment.center),
        ),
        height: MediaQuery.of(context).size.height / 2.5,
      ),
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset firstEndPoint = Offset(size.width * .5, size.height - 20);
    Offset firstControlPoint = Offset(size.width * .25, size.height - 30);
    Offset secondEndPoint = Offset(size.width, size.height - 50);
    Offset secondControlPoint = Offset(size.width * .75, size.height - 10);

    final path = Path()
      ..lineTo(0.0, size.height)
      ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
          firstEndPoint.dx, firstEndPoint.dy)
      ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
          secondEndPoint.dx, secondEndPoint.dy)
      ..lineTo(size.width, 0.0)
      ..close();
    return path;  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}