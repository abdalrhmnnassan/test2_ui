import 'package:flutter/material.dart';
import 'package:storeaksdk/models/Inventory/ProductModel.dart';

class NewestItems extends StatefulWidget {
  final Product data;
  @override
  _NewestItemsState createState() => _NewestItemsState();

  NewestItems(this.data);
}

class _NewestItemsState extends State<NewestItems> {
//  to show Newest item into list view
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width:MediaQuery.of(context).size.width/2,
          height: 250,
        ),
        Align(
          alignment:Alignment.bottomCenter,
          child: Container(
            width:(MediaQuery.of(context).size.width/2),
            height: 190,
            decoration:BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:80,bottom: 8.0,left: 16),
                  child: Container(
                    width: 75,
                    child: Text(
                      '${widget.data.name}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:16.0),
                  child: Container(
                    width: 75,
                    child: Text(
                      '${widget.data.currency.symbol} ${widget.data.price}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child:Padding(
            padding: const EdgeInsets.only(bottom:100.0),
            child: Hero(
                tag :"n${widget.data.picturePath}",
                child:
                Image.network("${widget.data.picturePath}",height: 120,
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
        ),
      ],
    );
  }
}
