import 'package:flutter/material.dart';
import 'package:storeaksdk/models/Inventory/ProductModel.dart';


// ignore: must_be_immutable
class DetailBody extends StatefulWidget {
  final List<Product> data;// to get data from details
  int index;//to get index from details
  final String isFut;//to improve tag image cause show multi image with the same tag
  DetailBody({this.data, this.index , this.isFut});

  @override
  _DetailBodyState createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          widget.data[widget.index].name.toString(),
          style: TextStyle(
              fontSize: 27, fontWeight: FontWeight.bold),
        ),
        Text(
          widget.data[widget.index].subDescription.toString()== "null" ? "":widget.data[widget.index].subDescription  ,
          style: TextStyle(fontSize: 27),
        ),

        Text(
          "${widget.data[widget.index].unitInfo.value} ${widget.data[widget.index].unitInfo.name}",
          style: TextStyle(color: Colors.grey),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                  widget.data[widget.index].isLiked.toString() ==
                      "true"
                      ? Icons.favorite
                      : Icons.favorite_outline_rounded),
              iconSize: 30,
              color:
              widget.data[widget.index].isLiked.toString() ==
                  "true"
                  ? Colors.red
                  : Colors.grey,
              /* color: _favIconColor,
                        onPressed: () {
                          setState(() {
                            if(widget.data[widget.index].isLiked && _favIconColor == Colors.grey){
                              _favIconColor = Colors.red;
                            }else{
                              _favIconColor = Colors.grey;
                            }
                          });
                        },*/
            ),
            Text(
              "${widget.data[widget.index].currency.symbol} "
                  " ${widget.data[widget.index].price}",
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "About the product",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            "${widget.data[widget.index].description}",
            style: TextStyle(
              color: Colors.grey,
            ),
            overflow: TextOverflow.fade,
          ),
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
