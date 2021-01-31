import 'package:flutter/material.dart';

class Delivery extends StatefulWidget {
  @override
  _DeliveryState createState() => _DeliveryState();
}
// to show design delivery
class _DeliveryState extends State<Delivery> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.grey,
      ),
      child: ListTile(
        leading: Icon(
          Icons.delivery_dining,
          size: 50,
        ),
        title: Text("Our delivery"),
        subtitle: Text("is always free"),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
