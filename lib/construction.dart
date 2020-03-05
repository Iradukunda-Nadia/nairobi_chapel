import 'package:flutter/material.dart';

class Construction extends StatefulWidget {
  @override
  _ConstructionState createState() => _ConstructionState();
}

class _ConstructionState extends State<Construction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/unnamed.jpg",
          fit: BoxFit.contain,
          height: 200.0,
          width: 200.0,
        ),
      ),
    );
  }
}

