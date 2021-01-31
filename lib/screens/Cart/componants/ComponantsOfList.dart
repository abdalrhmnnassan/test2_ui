import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../../model_product.dart';

// ignore: must_be_immutable
class ComponentsOfList extends StatefulWidget {
  int index;//to get index from cart
  List<ProductShared> list;//to get list from cart
  final Color textColor;//to get color from cart
  ComponentsOfList(this.index, this.list,this.textColor);

  @override
  _ComponentsOfListState createState() => _ComponentsOfListState();
}

class _ComponentsOfListState extends State<ComponentsOfList> with TickerProviderStateMixin {
  AnimationController _controller;
  double target = 0.0;
  @override
  void initState() {
    _controller = AnimationController(//to Initialization animation to rotate image
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {

    _controller = AnimationController(//to end animation to rotate image
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _controller.dispose();
    super.dispose();
  }
//to start animation to rotate image
  void _onTapHandler() {
    target +=1.0;
    if (target > 1.0) {

      _controller.reset();
    }
    _controller.animateTo(target);

  }
  // to show dialog when press on image
  showAlertDialog(BuildContext context ,String image  , String name ){

    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(5),
              height: 320,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                      child: Hero(
                        tag: image,
                        child: Image.network(
                          image,

                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                     name,

                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // width: 200,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        ' ${widget.list[widget.index].currency.toString()} ${widget.list[widget.index].price.toString()} ',
                        maxLines: 3,
                        style: TextStyle(fontSize: 15, color:Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      animationType: DialogTransitionType.scaleRotate,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(7),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: (){
                        // This Will Call When User Click On ListView Item
                        _onTapHandler();
                        showAlertDialog(context, widget.list[widget.index].image, widget.list[widget.index].name) ; // call dialog
                      },
                      child: Hero(
                        tag: widget.index.toString(),
                        child: Image.network(
                          widget.list[widget.index].image,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.list[widget.index].name}',
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                      color:widget.textColor
                      ),
                    ),
                    Text('${widget.list[widget.index].subDescription=="null" ?widget.list[widget.index].subDescription:""} ${widget.list[widget.index].unitInfoValue}${widget.list[widget.index].unitInfoName} ',style: TextStyle(
                      color: widget.textColor
                    ),)
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment:
              CrossAxisAlignment.end,
              children: [
                Text('${widget.list[widget.index].count}x',style: TextStyle(
                  color: Colors.grey
                ),),
                Text(
                  '${widget.list[widget.index].currency.toString()}${widget.list[widget.index].price}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,color:widget.textColor),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
