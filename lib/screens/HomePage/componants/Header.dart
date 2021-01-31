import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Header extends StatefulWidget {
  String name;

  Header({this.name});

  @override
  _HeaderState createState() => _HeaderState();
}
// to show username
class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
            const EdgeInsets.only(left: 20.0, top: 12, bottom: 0),
            child: Text(
              'Hi ${widget.name}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(left: 20.0, top: 12, bottom: 8),
            child: Text(
              'Find your daily goods',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
