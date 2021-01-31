import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../model_product.dart';
import 'componants/ButtonCheckout.dart';
import 'componants/ComponantsOfList.dart';
import 'componants/Delivery.dart';
import 'componants/TotalPriceItem.dart';

class CartView extends StatefulWidget {
  final Color textColor;
  CartView(this.textColor);

  @override
  _CartViewState createState() => _CartViewState();
}

SlidableController _slidableController;
double total = 0.0;//to store sum of total
double priceItem = 0.0;//to store total before any update on it

class _CartViewState extends State<CartView> with TickerProviderStateMixin {
  List<ProductShared> _list = cartList.getCart();//to store data from list


  @override
  void initState() {
    setState(() {
      total = 0.0;// to ini total 0
      for (int i = 0; i < _list.length; i++) {//this loop to calculate total
        total = total + (_list[i].count * _list[i].price);
      }
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Text(
              "Cart",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color:widget.textColor),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top:8.0,left: 8,bottom: 8),
              child: ListView.builder(
                padding:EdgeInsets.only(top:8.0),
                  shrinkWrap: true,
                  itemCount: _list.length,
                  itemBuilder: (context, index) {

                    return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Slidable.builder(
                          key: Key(_list[index].toString()),
                          controller: _slidableController,
                          direction: Axis.horizontal,
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          //to call components of list
                          child: ComponentsOfList(index, _list,widget.textColor),
                          //this slider to show button update and delete
                          actionDelegate: SlideActionBuilderDelegate(
                              actionCount: 3,
                              builder:
                                  (context, indexSlid, animation, renderingMode) {

                                if (indexSlid == 0) {
                                  return MaterialButton(
                                    onPressed: () {
                                      //to update count of item
                                      setState(() {
                                        total = total -
                                            (double.parse(
                                                    _list[index].count.toString()) *
                                                double.parse(
                                                    _list[index].price.toString()));
                                        _list[index] = ProductShared(
                                            id: _list[index].id,
                                            name: _list[index].name,
                                            subDescription:
                                                _list[index].subDescription,
                                            price: _list[index].price,
                                            count: _list[index].count + 1,
                                            image: _list[index].image,
                                            currency: _list[index].currency,
                                            unitInfoName: _list[index].unitInfoName,
                                            unitInfoValue:
                                                _list[index].unitInfoValue);
                                        priceItem = int.parse(
                                                _list[index].count.toString()) *
                                            double.parse(
                                                _list[index].price.toString());
                                        total = total + priceItem;
                                        refreshShared();
                                      });
                                    },
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    child: Icon(
                                      Icons.add,
                                      size: 24,
                                    ),
                                    padding: EdgeInsets.all(16),
                                    shape: CircleBorder(),
                                  );
                                } else if (indexSlid == 1) {
                                  return ClipOval(
                                      child: Container(  //to show count of item
                                          height: 50.0,
                                          width: 50,
                                          margin: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Color(0x00ffffff),
                                                  width: 0.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.elliptical(3 * 10.0, 30))),
                                          // this line makes the coffee.
                                          child: Center(
                                              child: Text(
                                                  _list[index].count.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black)))));
                                } else {
                                  return MaterialButton(  //to update count of item
                                    onPressed: () {
                                      setState(() {
                                        if (_list[index].count > 1) {
                                          total = total -
                                              (double.parse(_list[index]
                                                      .count
                                                      .toString()) *
                                                  double.parse(_list[index]
                                                      .price
                                                      .toString()));
                                          _list[index] = ProductShared(
                                              id: _list[index].id,
                                              name: _list[index].name,
                                              subDescription:
                                                  _list[index].subDescription,
                                              price: _list[index].price,
                                              count: _list[index].count - 1,
                                              image: _list[index].image,
                                              currency: _list[index].currency,
                                              unitInfoName:
                                                  _list[index].unitInfoName,
                                              unitInfoValue:
                                                  _list[index].unitInfoValue);
                                          priceItem = int.parse(
                                                  _list[index].count.toString()) *
                                              double.parse(
                                                  _list[index].price.toString());
                                          total = total + priceItem;
                                          refreshShared();
                                        }
                                      });
                                    },
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    child: Icon(
                                      Icons.remove,
                                      size: 24,
                                    ),
                                    padding: EdgeInsets.all(16),
                                    shape: CircleBorder(),
                                  );
                                }
                              }),
                          secondaryActionDelegate: SlideActionBuilderDelegate(
                              actionCount: 1,
                              builder: (context, indexI, animation, renderingMode) {
                                return
                                    //ButtonDeleteItem(total: total, index: index,list: _list,);

                                    MaterialButton(//  //to delete  item
                                  onPressed: () {
                                    setState(() {
                                      total = total -
                                          (double.parse(
                                                  _list[index].count.toString()) *
                                              double.parse(
                                                  _list[index].price.toString()));
                                      _list.removeAt(index);
                                      refreshShared();
                                    });
                                  },
                                  color: Colors.redAccent,
                                  textColor: Colors.white,
                                  child: Icon(
                                    Icons.delete_forever,
                                    size: 24,
                                  ),
                                  padding: EdgeInsets.all(16),
                                  shape: CircleBorder(),
                                );
                              }),
                        ));
                  }),
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: deliveryAndCheckout(),
            ),
          ),
        ],
      ),
    );
  }

  Widget deliveryAndCheckout() {
    return Column(
      children: [
        Delivery(),
        SizedBox(
          height: 15,
        ),
        Divider(color:Colors.grey,),
        TotalPriceItem(total: total , textColor:widget.textColor),
        SizedBox(
          height: 20,
        ),
        ButtonCheckout(),
      ],
    );
  }
}
//to update shared
void refreshShared() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  final String encodedData = ProductShared.encode(cartList.getCart());
  _pref.setString("Products", encodedData);
}
