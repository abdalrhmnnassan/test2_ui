import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeaksdk/storeaksdk.dart';
import 'file:///C:/AndroidStudio/fluttre_project/test_f/lib/screens/Login/login.dart';
import 'CartListItem.dart';
import 'model_product.dart';
var cartList;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StoreakSDK.init(
      clientId: 'd07204ae-4ea4-45c7-b6fb-64969f778ea1',
      clientSecret: '3zsCDFefv54HIRlljzNU1VPEulg60P8R',
      oneSignal: "oneSignal",
      isTest: true);
  List <ProductShared> d ;//to store data from shared to list
  SharedPreferences _pref = await SharedPreferences.getInstance();
  if (_pref.getString('Products') != null){
    d = ProductShared.decode(_pref.getString('Products'));
  }
  else {
    d = [];
  }
  runApp(ChangeNotifierProvider<CartListItem>(
    create: (BuildContext context) => CartListItem(d != null ? d : [] ),
    child: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    cartList = Provider.of<CartListItem>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      // home: SignInScreen(),
      home: Login(),
      // home: CartView(),
    );
  }
}
