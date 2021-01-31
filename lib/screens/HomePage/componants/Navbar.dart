import 'package:flutter/material.dart';
import 'package:test_f/screens/Cart/cart.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}
//to show drawer and icon cart
class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SafeArea(
        top: true,
        child: Container(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.menu),
                      )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      alignment: Alignment.centerRight,
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Scaffold(appBar: AppBar(iconTheme: IconThemeData(color: Colors.black,),elevation: 0,backgroundColor: Colors.grey[50],leading: IconButton(
                              icon: Icon(
                                  Icons
                                      .arrow_back_ios_rounded,
                                  color: Colors
                                      .black),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),),body:CartView(Colors.black),)));
                      },
                      icon: Icon(Icons.shopping_cart_outlined)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
