import 'package:flutter/material.dart';

//to show design text username and password
class TextNameAndPassword extends StatefulWidget {
  final FocusScopeNode _node;
  TextNameAndPassword(this._node);
  @override
  _TextNameAndPasswordState createState() => _TextNameAndPasswordState();

}
TextEditingController username = new TextEditingController();
TextEditingController password = new TextEditingController();
class _TextNameAndPasswordState extends State<TextNameAndPassword> {


  bool _isHidden = true; ////////////////   this parameter boo to chick into icon button if checked or no
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        TextFormField(

          controller: username,
          //  obscureText: false,
          onEditingComplete: widget._node.nextFocus,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter userName';
            }
            if (value.length < 3) {
              return 'userName less than 3 chars ';

            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "UserName",
            hintText: "Enter your Name",
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(Icons.person),
          )
      ),
        SizedBox(height:30),
        TextFormField(
          controller: password,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter password';
            }
            if (value.length < 3) {
              return 'password less than 3 chars';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: IconButton(
              onPressed: _toggleVisibility,
              icon: _isHidden ? Icon(
                Icons.visibility_off, color: Colors.blueGrey,) : Icon(
                Icons.visibility, color: Colors.blueGrey,),
            ),
          ),
          obscureText: _isHidden,
        ),

      ],
    );
  }
}
