import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:storeaksdk/models/GPS/LocationsList.dart';
import 'package:storeaksdk/models/GPS/ZoneModelList.dart';
import 'package:test_f/LocationAndZone/LocationAndZone.dart';
import 'package:test_f/services/services_location.dart';
import 'package:test_f/services/services_zone.dart';


class ButtonCheckout extends StatefulWidget {
  @override
  _ButtonCheckoutState createState() => _ButtonCheckoutState();
}

class _ButtonCheckoutState extends State<ButtonCheckout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.blue,
        elevation: 6,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: () {
            LocationsList locationsList;
            getlocations().then((value) {//to call function and store data by result
              locationsList = value['result'];

            }).whenComplete(() {
              getZones().then((value) {//to call function and store data by result
                ZoneModelList z =  value['result'];
                showAlertDialog(context, locationsList,z);
              });
            });

          },
          minWidth: (MediaQuery.of(context).size.width),
          height: 45,
          child: Text(
            "Checkout",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context , LocationsList locationsList  ,ZoneModelList z )
  {

    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return LocationAndZone(data: locationsList,zoneModelList: z);
      },
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.easeInExpo,
      duration: Duration(seconds: 1),
    );
  }
}
