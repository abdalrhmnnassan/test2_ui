import 'package:flutter/material.dart';
import 'package:test_ui/body_screen2.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body() ,
    );
  }

}
