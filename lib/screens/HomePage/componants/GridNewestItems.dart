import 'package:flutter/material.dart';
import 'package:storeaksdk/models/Inventory/ProductModel.dart';
import 'package:test_f/screens/Details/details.dart';

import 'newest_items.dart';
class GridNewestItems extends StatefulWidget {
  final List<Product> data;

  GridNewestItems({this.data});

  @override
  _GridNewestItemsState createState() => _GridNewestItemsState();
}
// to show data into grid
class _GridNewestItemsState extends State<GridNewestItems> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right:20.0,left:20,top: 20),
      child: GridView.builder(
          padding: EdgeInsets.only(top: 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 8,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              childAspectRatio: (MediaQuery.of(context).size.width/2)/250
          ),
          shrinkWrap: true,
          itemCount: widget.data.length,
          physics: ScrollPhysics(),
          itemBuilder: (_, int index) {
            return InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Details(data:widget.data,index:index,isFut:"n")));
              },
              child: NewestItems(widget.data[index]),
            );
          }),
    );
  }
}
