import 'package:flutter/material.dart';
import 'package:storeaksdk/models/Inventory/ProductModel.dart';
import 'componants/GridNewestItems.dart';
import 'componants/Header.dart';
import 'componants/Navbar.dart';
import 'componants/SearchAndFeatureItem.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  final List<Product> dataF;//to store data feature
  final List<Product> data;////to store data Newest Items
  String name;
  @override
  _HomePageState createState() => _HomePageState();

  HomePage({Key key, this.dataF , this.data , this.name}) : super (key:key);
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        var focus  =FocusScope.of(context);
        if(!focus.hasPrimaryFocus){
          focus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          shrinkWrap: true,
          children: [
            Navbar(),
            Header(name: widget.name,),
            SearchAndFeatureItem(dataF: widget.dataF,),
            GridNewestItems(data: widget.data,)
          ],
        ),
      ),
    );
  }
}
