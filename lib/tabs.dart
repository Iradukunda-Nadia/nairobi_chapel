
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nairobi_chapel/adminUI/dashboard.dart';
import 'package:nairobi_chapel/adminUI/videos.dart';
import 'package:nairobi_chapel/connect.dart';
import 'package:nairobi_chapel/construction.dart';
import 'package:nairobi_chapel/events.dart';
import 'package:nairobi_chapel/give.dart';
import 'package:nairobi_chapel/home.dart';
import 'package:nairobi_chapel/loginUI/baseAuth.dart';
import 'package:nairobi_chapel/loginUI/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

class tabView extends StatefulWidget {
  tabView({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;


  @override
  _tabViewState createState() => _tabViewState();
}

class _tabViewState extends State<tabView> with SingleTickerProviderStateMixin {

  TabController controller;
  String _email;
  String id;
  String _password;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = new TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', "");
    prefs.setString('dept', "");

    setState(() {
      isLoggedIn = false;
    });

    Navigator.of(context).push(new CupertinoPageRoute(
        builder: (BuildContext context) => new LoginSignupPage()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // Appbar
      appBar: new AppBar(
        title: Image.asset('assets/nc.png',
          fit: BoxFit.contain,
          width: 200,
          height: 50,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.yellow,),
      ),

      drawer: Drawer(
        child: Column(
          children: <Widget>[
            new DrawerHeader(decoration: new BoxDecoration(
              color: Colors.yellow,
            ),),
            new Divider(),
            new ListTile(
              leading: new Icon(Icons.group),
              title: new Text("Admin"),
              onTap: (){
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new  Dashboard()
                ));
              },
            ),
          ],
        ),
      ),

      body: new TabBarView(
        // Add tabs as widgets
        children: <Widget>[new Home(),  new events(), new Giving(), new Connect(), new Construction(),],
        // set the controller
        controller: controller,
      ),
      // Set the bottom navigation bar
      bottomNavigationBar: new Material(
        // set the color of the bottom navigation bar
        color: Colors.white,
        // set the tab bar as the child of bottom navigation bar
        child: new TabBar(
          labelStyle: TextStyle(fontSize: 10),
          indicatorWeight: 5.0,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
          tabs: <Tab>[
            new Tab(
              text: 'Sermons',// set icon to the tab
              icon: new Icon(Icons.change_history),
            ),
            new Tab(
              text: 'Events',
              icon: new Icon(Icons.date_range),
            ),
            new Tab(
              text: 'Giving',
              icon: new Icon(Icons.attach_money),
            ),
            new Tab(
              text: 'Connect',
              icon: new Icon(Icons.group),
            ),
            new Tab(
              text: 'Profile',
              icon: new Icon(Icons.person),
            ),


          ],
          // setup the controller
          controller: controller,
        ),
      ),
    );
  }
}