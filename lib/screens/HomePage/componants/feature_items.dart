import 'package:flutter/material.dart';
import 'package:storeaksdk/models/Inventory/ProductModel.dart';

class FeatureItems extends StatefulWidget {
  final Product data;
  @override
  _FeatureItemsState createState() => _FeatureItemsState();

  FeatureItems(this.data);
}
// to show feature item into list view
class _FeatureItemsState extends State<FeatureItems> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 170,
        ),
        Center(
          child: Container(
            height: 135,
            width: 275,
            child: Container(
              width: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      child: Text(
                        '${widget.data.name}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.all(8.0),
                    child: Text(
                      '${widget.data.currency.symbol} ${widget.data.price}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 143,
              
            ),
            child: Hero(
              tag:"f${widget.data.picturePath}" ,
              child: Container(
                  height: 170,
                  child: ClipPath(
                    clipper: TriangleClipper(),
                    child: Image.network("${widget.data.picturePath.toString()}", fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  )
              ),
            ),
          ),
        ),
      ],
    );
  }
}
//to crop Image from button
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height-10);
    path.quadraticBezierTo(
        size.width , size.height - 9, size.width, size.height-10);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
