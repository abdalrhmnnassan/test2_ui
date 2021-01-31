import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:storeaksdk/models/GPS/Locations.dart';
import 'package:storeaksdk/models/GPS/LocationsList.dart';
import 'package:storeaksdk/models/GPS/ZoneModelList.dart';
class LocationAndZone extends StatefulWidget {
  final LocationsList data;// This list stores data about regions
  final ZoneModelList zoneModelList;// This list stores data about zone
  LocationAndZone({this.data , this.zoneModelList});
  @override
  _LocationAndZoneState createState() => _LocationAndZoneState();
}

class _LocationAndZoneState extends State<LocationAndZone> {
  var districtsVal;//To store the children data that we have selected
  var cityVal;//To store the children data that we have selected
  var countriesVal;//To store the children data that we have selected
  List<Locations> cities; // this list to store data city after select Country
  List<Locations> district;// this list to store data district
  // ct after select city
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child:  DropdownButton(
                        hint: Text("Country"),
                        items: widget.data.locations.map((item) {// this map that contain data from api to show Country;
                          return  DropdownMenuItem(
                            onTap: (){
                              setState(() {
                               // print(countriesVal.toString());
                                 if(countriesVal!=null){
                                   if(countriesVal.name!= item.name) {
                                     district = null;
                                     districtsVal = null;
                                     cityVal = null;
                                     cities = null;
                                   }
                                 }

                                cities = item.children; //To store the children data that we have selected
                              }
                                );
                            },
                            child:  Text(item.name.toString()), // this name that come back from list method of api
                            value: item,// this item that store all data from the same id
                          );
                        }).toList(),
                        onChanged: (v){
                          setState(() {
                            countriesVal = v;//To store the data that we have selected

                          });
                        },
                        value: countriesVal,
                      ),
                    ),

                    cities==null ?Expanded(
                      child: DropdownButton(
                        //To select a city and it displays a city if the country is not selected
                          hint: Text("City")
                      ),
                    )
                        :new Expanded(child:DropdownButton(

                      hint: Text("City"),
                      items: cities.map((item) {// this map that contain data from api to show City;
                        return new DropdownMenuItem(
                          onTap: (){
                           if(cityVal!=null){
                             if(cityVal.name!= item.name ) {
                               district = null;
                               districtsVal = null;
                             }
                           }
                            district = item.children;//To store the children data that we have selected
                          },
                          child: new Text(item.name.toString()),
                          value: item,// To store the data that we have selected
                        );
                      }).toList(),
                      onChanged: (v){
                        setState(() {
                          cityVal = v;//To store the data that we have selected


                        });
                      },
                      value: cityVal,//To store the data that we have selected
                    )),

                    district==null?Expanded (
                      child: DropdownButton(
                        //To Selects the District and displays a city if the city is not selected
                          hint: Text("District")
                      ),
                    ) : Expanded(child:DropdownButton(
                      hint: Text("District"),
                      items: district.map((item) {// this map that contain data from api to show District;
                        return DropdownMenuItem(
                          onTap: (){
                          },
                          child: Text(item.name.toString() ,),
                          value: item,//To store the data that we have selected
                        );
                      }).toList(),
                      onChanged: (v){
                        setState(() {
                          districtsVal = v;//To store the data that we have selected
                          // to chick if city and country and district is found or no
                         int index = widget.zoneModelList.zones.indexWhere((element) => element.address.country.id==countriesVal.id);
                         if(index!=-1){
                           int index = widget.zoneModelList.zones.indexWhere((element) => element.address.city.id==cityVal.id);
                              if(index!=-1){
                                int index = widget.zoneModelList.zones.indexWhere((element) => element.address.district.id==districtsVal.id);
                                if(index!=-1){
                                  print(index.toString());
                                }else{
                                  showAnimatedDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return ClassicGeneralDialogWidget(
                                        titleText: 'wrong',
                                        contentText: 'Sorry, region not found',
                                        onPositiveClick: () {
                                          Navigator.of(context).pop();
                                        },
                                        onNegativeClick: () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    },
                                    animationType: DialogTransitionType.fadeScale,
                                    curve: Curves.fastOutSlowIn,
                                    duration: Duration(seconds: 1),
                                  );

                                }
                              }
                         }
                                // to do
                        });
                      },
                      value: districtsVal,
                    )),
                  ],
                ),


              ],
            )
        ),
      )
    );
  }
}
