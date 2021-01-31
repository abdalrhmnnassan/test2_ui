import 'package:flutter/material.dart';
import 'package:storeaksdk/models/Inventory/ProductModel.dart';
import 'package:test_f/screens/Details/details.dart';
import 'package:test_f/services/services_product.dart';
import 'feature_items.dart';

class SearchAndFeatureItem extends StatefulWidget {
  final List<Product> dataF;

  SearchAndFeatureItem({this.dataF});

  @override
  _SearchAndFeatureItemState createState() => _SearchAndFeatureItemState();
}
// to search and show feature item
class _SearchAndFeatureItemState extends State<SearchAndFeatureItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    search = TextEditingController();
  }
  bool startSearch = false;
  TextEditingController search;
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: TextField(
              controller: search,
              onTap: (){
                setState(() {
                  startSearch = true;
                });
              },
              onChanged:(d){

              },
              decoration: InputDecoration(
                // fillColor: Colors.grey[200],
                // filled: true,
                hintText: 'Search here',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left:12.0,right: 12),
          child: Container(
            height: 170,
            child: !startSearch?ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.dataF.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Details(data:widget.dataF,index:index,isFut:"f")));
                      },
                      child: Container(
                        child: FeatureItems(widget.dataF[index]),
                      ),
                    ),
                  );
                }):FutureBuilder(
              future: searchedItem(search.text),
              builder: (_,snapshot){
                if (snapshot.connectionState==ConnectionState.waiting){
                  return Container(width: 45,height: 45,child: Center(child: CircularProgressIndicator()),);
                }
                else if (snapshot.hasError){
                  return Icon(Icons.warning,color: Colors.red,size: 30,);
                }
                else {
                  List <Product> data = snapshot.data;
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => Details(data:data,index:index,isFut:"f")));
                            },
                            child: Container(
                              child: FeatureItems(data[index]),
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
