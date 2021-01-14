import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}
Color _favIconColor = Colors.grey;
int numOfItems = 1;
class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: size.height * 0.3),
            padding: EdgeInsets.only(
              top: size.height * 0.12,
              left: 20.0,
              right: 20.0,
            ),
            // height: 500,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            height: 200,
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),

          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  child: Hero(
                    tag: "a",
                    child: Image.network(
                      "https://www.storeakmedia.com/oldstoreak-test/images/items/238/846/441/67306a15-af5c-4f2b-a82e-b38892933d64_View.png",
                      height: 250,
                      width: 250,
                    ),
                  ),
                ),
                Text(
                  "Fairy Original Liquid",
                  style: TextStyle(
                      fontSize: 27, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Lemon & Lime",
                  style: TextStyle(fontSize: 27),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "500ml",
                  style: TextStyle(color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.favorite_outlined ),
                      iconSize: 30,
                      color: _favIconColor,

                      onPressed: () {
                        setState(() {
                          if(_favIconColor == Colors.grey){
                            _favIconColor = Colors.red;
                          }else{
                            _favIconColor = Colors.grey;
                          }
                        });
                      },
                    ),
                    Text("\$1.19" ,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("About the product" ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 10,
                ),
                Text("Every drop of Fairy Washing Up Liquid provide the ultra long lasting cleaning power you expect",style: TextStyle(color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: <Widget>[
                        buildOutlineButton(
                          icon: Icons.remove,
                          press: () {
                            if (numOfItems > 1) {
                              setState(() {
                                numOfItems--;
                              });
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            numOfItems.toString(),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        buildOutlineButton(
                            icon: Icons.add,
                            press: () {
                              setState(() {
                                numOfItems++;
                              });
                            }),
                      ],
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      color: Colors.black,
                      onPressed: () {},
                      child: Text(
                        "Add to cart",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                // to do button sheet state management
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35 , left: 10),
            child: buildOutlineButton(
                icon:Icons.arrow_back_ios_outlined ,
                colors: Colors.white,
                press: () {setState(() {
                  Navigator.pop(context);
            });}),
          ),
        ],
      ),
    );
  }
  SizedBox buildOutlineButton({IconData icon, Function press , Color colors}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon , color: colors,),
      ),
    );
  }
}
