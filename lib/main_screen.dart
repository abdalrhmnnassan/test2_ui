import 'package:flutter/material.dart';

import 'screen2.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.blueGrey),
          actions: [
            IconButton(
              icon: Icon(Icons.add_shopping_cart_sharp),
              onPressed: () {},
            ),
          ],
        ),
        drawer: Drawer(),
        body: SingleChildScrollView(
          child: Column(

            children: [
              start(),
              search(),
              grid1(),
              //  MainGridList(),
              grid2(),
            ],
          ),
        ));
  }

  Widget start() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Hi Abdalrhmn",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.sports_handball_sharp,
                color: Colors.yellow,
                size: 30,
              ),
            ],
          ),
          Text(
            "Find your daily goods",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget search() {
    return Padding(
      padding: const EdgeInsets.only(left:20.0 , right: 20.0 , bottom: 20.0),
      child:Container(
        //width: SizeConfig.screenWidth * 0.6,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          //onChanged: (value) => print(value),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 9),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "Search hear",
              prefixIcon:GestureDetector(
                child: Container(
                  child: Icon(Icons.search),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());

                  print("prefix tapped");
                },
              ),

              ),
        ),
      )
    );
  }

  Widget grid1() {
    return Container(
      padding: const EdgeInsets.only(left:20.0 ),
      height: 140,
      child: GridView.builder(
        padding: EdgeInsets.only(top: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 30.0,
            childAspectRatio: MediaQuery.of(context).size.width / 700),
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int index) {
          /* return Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text("GridView $index"),
                    ),
                  );*/
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: Colors.blueGrey, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(
                  10.0) //                 <--- border radius here
              ),
            ),
            child: Center(
              child: Text("GridView $index"),
            ),
          );
        },
      ),
    );
  }

  Widget grid2() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: 21,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 3.0),
            ),
          );
        },
      ),
    );
  }
}
