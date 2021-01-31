import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TotalPriceItem extends StatefulWidget {
  double total;
  Color textColor;
  TotalPriceItem({this.total , this.textColor});

  @override
  _TotalPriceItemState createState() => _TotalPriceItemState();
}
// to show total price item
class _TotalPriceItemState extends State<TotalPriceItem> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Total",
          style:
          TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: widget.textColor),
        ),
        Text(
          "\$${widget.total.toStringAsFixed(3)}",
          style:
          TextStyle(fontSize: 25, fontWeight: FontWeight.bold , color: widget.textColor),
        ),
      ],
    );
  }
}
