import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeaksdk/models/Inventory/ProductModel.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:test_f/screens/Cart/cart.dart';
import '../../main.dart';
import '../../model_product.dart';
import 'componantes/Detail_body.dart';

class Details extends StatefulWidget {
  final List<Product> data;//to get data from home page
  final int index;// to get data from home page
  final String isFut;//to improve tag image cause show multi image with the same tag

  @override
  _DetailsState createState() => _DetailsState();

  Details({Key key, this.data, this.index, this.isFut}) : super(key: key);
}


class _DetailsState extends State<Details> with TickerProviderStateMixin {
  int numOfItems = 1;//to store count of item
  bool bottomSheet = false; // to show and hide buttom sheet
  AnimationController aniController;
  AnimationController aniController2;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  var offset = Tween(begin: Offset(-2, -3), end: Offset(0, 0));
  var offset2 = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
  List<ProductShared> _list = cartList.getCart();
  bool expanded = false;
  bool isChanging = false;
  int indexItem;
  void _addItem(BuildContext context) async {// to add item and check if item is added or mo and if added  The quantity will be adjusted
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var v = widget.data[widget.index];
    ProductShared map = ProductShared(
        id: v.id,
        name: v.name,
        subDescription: v.subDescription,
        price: v.price,
        count: numOfItems,
        image: v.picturePath,
        currency: v.currency.name,
        unitInfoName: v.unitInfo.name,
        unitInfoValue:v.unitInfo.value.toString());
    int index = _list.indexWhere((element) => element.id==v.id);
    if (index==-1) {
      _list.insert(0, map);
      _listKey.currentState.insertItem(0, duration: Duration(milliseconds: 500));
      final String encodedData = ProductShared.encode(cartList.getCart());
      _pref.setString("Products", encodedData);
    } else {
      _list[index] = ProductShared(
          id: _list[index].id,
          name:_list[index].name,
          subDescription: _list[index].subDescription,
          price: _list[index].price,
          count: _list[index].count + numOfItems,
          image: _list[index].image,
          currency: _list[index].currency,
          unitInfoName: _list[index].unitInfoName,
          unitInfoValue: _list[index].unitInfoValue);
      final String encodedData = ProductShared.encode(cartList.getCart());
      _pref.setString("Products", encodedData);

    }
  }

  Animation<Offset> _animationOffset;
  Animation<double> _animationHeight;

  @override
  initState() {
    super.initState();
    aniController = AnimationController(
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 300),
      vsync: this,
    );
    aniController2 = AnimationController(
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animationOffset =
        Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(aniController);
    aniController2.addStatusListener((status) {
      if (aniController2.isCompleted) {
        setState(() {
          expanded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    aniController.dispose();
    aniController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _animationHeight =
        Tween(begin: 100.0, end: size.height).animate(aniController2);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
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
                  padding: const EdgeInsets.only(bottom:50.0,right: 25,left: 25,top:25),
                  child:Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 50),
                        alignment: Alignment.center,
                        child: Hero(
                          tag:
                          "${widget.isFut}${widget.data[widget.index].picturePath}",
                          child: Image.network(
                            "${widget.data[widget.index].picturePath}",
                            height: 250,
                            width: 250,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      DetailBody(data: widget.data, index: widget.index,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 35, left: 10),
              child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  }),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height:bottomSheet?195:95,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                 begin: Alignment.topCenter,
                  end:Alignment.bottomCenter,
                  colors:[
                    Colors.grey[50].withOpacity(0.4),
                    Colors.grey[50],
                    Colors.grey[50],
                    Colors.grey[50],
                    Colors.grey[50],
                    Colors.grey[50],
                    Colors.grey[50],
                  ]
                )
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Center(
                  child: AnimatedPadding(
                    duration: Duration(milliseconds: 300),
                    padding:  EdgeInsets.only(top:12.0,bottom:bottomSheet?100:0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: size.width * 0.5 - 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey.withOpacity(1),width:1.5),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(Icons.remove,color: Colors.black,),
                                    onPressed:(){
                                      if (numOfItems > 1) {
                                        setState(() {
                                          numOfItems--;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:  Center(
                                    child: Text(
                                      numOfItems.toString(),
                                      style: Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(Icons.add,color: Colors.black,),
                                    onPressed:(){
                                      setState(() {
                                        numOfItems++;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              child: RaisedButton(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                color: Colors.black,
                                onPressed: () {
                                  setState(() {
                                    bottomSheet = true;
                                  });
                                  aniController.forward().whenComplete(() {
                                    _addItem(context);
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    "Add to cart",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          //================================
          if (bottomSheet)
            Container(
              height: size.height,
              color: Colors.black.withOpacity(0.2),
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        aniController.reverse().whenComplete(() => setState(() {
                          bottomSheet = false;
                        }));
                      },
                    ),
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: AnimatedBuilder(
                            animation: aniController,
                            builder: (context, _) {
                              return SlideTransition(
                                position: _animationOffset,
                                child: SwipeDetector(
                                  onSwipeDown: () {
                                    setState(() {
                                      expanded = false;
                                    });
                                    aniController
                                        .reverse()
                                        .whenComplete(() => setState(() {
                                      bottomSheet = false;
                                      aniController2.reverse();
                                    }));
                                  },
                                  onSwipeUp: () {
                                    setState(() {
                                      isChanging = true;
                                    });
                                    aniController2.forward();
                                  },
                                  child: AnimatedBuilder(
                                    animation: aniController2,
                                    builder: (context, _) {
                                      return Container(
                                        height: _animationHeight.value,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          color:Colors.black,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(
                                                  !expanded ? 20 : 0)),
                                        ),
                                        child: expanded
                                            ? Column(
                                              children: [
                                                Container(
                                                  width: double.maxFinite,
                                                  child: Align(
                                                    alignment:
                                                    Alignment.topLeft,
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          top: 25),
                                                      child: IconButton(
                                                        icon: Icon(
                                                            Icons
                                                                .arrow_back_ios_rounded,
                                                            color: Colors
                                                                .white),
                                                        onPressed: () {
                                                          setState(() {
                                                            expanded =
                                                            false;
                                                          });
                                                          aniController
                                                              .reverse()
                                                              .whenComplete(
                                                                  () =>
                                                                  setState(
                                                                          () {
                                                                        bottomSheet =
                                                                        false;
                                                                        aniController2.reverse();
                                                                        isChanging =
                                                                        false;
                                                                      }));
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                 Expanded(child: CartView(Colors.white)),
                                              ],
                                            )
                                            : Stack(
                                          children: [
                                            Align(
                                                alignment:
                                                Alignment.topCenter,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(8.0),
                                                  child: Icon(
                                                    Icons.shopping_cart,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                            !isChanging
                                                ? Align(
                                              alignment: Alignment
                                                  .bottomCenter,
                                              child: Container(
                                                height: 50,
                                                child:
                                                Directionality(
                                                  textDirection:
                                                  TextDirection
                                                      .rtl,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left:
                                                        6.0,
                                                        right:
                                                        6.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: AnimatedList(
                                                              key: _listKey,
                                                              scrollDirection: Axis.horizontal,
                                                              initialItemCount: _list.length,
                                                              itemBuilder: (context, index, animation) {
                                                                return SlideTransition(
                                                                    position: animation.drive(_list.length <= 6 ? offset : offset2),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(4.0),
                                                                      child: Container(
                                                                        width: 45,
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          borderRadius: BorderRadius.circular(8),
                                                                        ),
                                                                        child: TweenAnimationBuilder(
                                                                          duration: Duration(milliseconds: 350),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(4.0),
                                                                            child: Image.network(_list[index].image, alignment: Alignment.center),
                                                                          ),
                                                                          tween: Tween<double>(begin: 0, end: 1),
                                                                          builder: (context, _val, child) {
                                                                            return Opacity(
                                                                              opacity: _val,
                                                                              child: child,
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ));
                                                              }),
                                                        ),
                                                        Container(
                                                          width: 8,
                                                        ),
                                                        Center(
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.only(top: 8.0),
                                                            child:
                                                            Text(
                                                              'Cart',
                                                              style:
                                                              TextStyle(
                                                                color:
                                                                Colors.white,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize:
                                                                18,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 6,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                                : Container(),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
