import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:storeaksdk/models/Inventory/ProductsPageModel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:test_f/screens/HomePage/home_page.dart';
import 'package:test_f/services/services_login.dart';
import 'package:test_f/services/services_product.dart';

import 'componants/CreateAccount.dart';
import 'componants/ForgetPassAndRemember.dart';
import 'componants/TextNameAndPassword.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {


//////////////////////////////////////////////
  bool validatePass = false; ///////////////
  bool validatePassLength = false; //////////
  bool validateUserNameLength = false; ///////// this parameter bool to validate UserName and Password
  bool validateUserName = false; ////////////
  ///////////////////////////////////////


  String accessToken ; ////////     this parameter String to store AccessToken
  String tokenType; ///////////      this parameter String to store TokenType
  String tokenTypeCorrect; /////////       this parameter String to store TokenType after convert first char into toUpperCase and To combine it with the rest of String

  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final FocusScopeNode _node = FocusScopeNode();
  bool _isInAsyncCall = false;//to show and hide progress
  showAlertDialog(BuildContext context, String title) {
    // set up the button
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          titleText: 'Notice',
          contentText: '$title',
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
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        var focus  =FocusScope.of(context);
        if(!focus.hasPrimaryFocus){
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Login",),),
        body:ModalProgressHUD(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: buildLoginForm(context),
          ),
          inAsyncCall: _isInAsyncCall,
          // demo of some additional parameters
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
        ),
      ),
    );
  }
  Widget buildLoginForm(BuildContext context){
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: FocusScope(
                node: _node,
                child: Column(
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Log in with your name and password  \nto show product list",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    TextNameAndPassword(_node),
                    SizedBox(height:30),
                    ForgetPassAndRemember(),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height:56,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: Colors.grey,
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false
                          // otherwise.
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              _isInAsyncCall = true;
                            });
                            log(username.text,password.text).then((value) {
                              if(value['bool']){
                                //this function to get data product from api
                                product().then((value) {
                                  ProductsPageModel pageModel = value['result'];
                                  ProductsPageModel pageModel2 = value['sortedResult'];
                                  //navigator to Home page
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (BuildContext context) => HomePage(dataF:pageModel.results,data: pageModel2.results  , name: username.text,)));
                                }).whenComplete(() { setState(() {
                                  _isInAsyncCall = false;
                                });});
                              }
                              else{
                                setState(() {
                                  _isInAsyncCall = false;
                                });
                                showAlertDialog(context,value['result']);
                              }
                            }).whenComplete(()  {
                              setState(() {
                                //  _isInAsyncCall = false;
                              });
                            });



                          }
                        },
                        child: Text(
                          "continue",
                          style: TextStyle(
                            fontSize:18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:  MediaQuery.of(context).size.height * 0.04),

                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CreateAccount(),
        ),
      ],
    );
  }
}
