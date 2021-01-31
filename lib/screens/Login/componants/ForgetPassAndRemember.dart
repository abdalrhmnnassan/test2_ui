import 'package:flutter/material.dart';

//to show design forget and remember password
class ForgetPassAndRemember extends StatefulWidget {
  @override
  _ForgetPassAndRememberState createState() => _ForgetPassAndRememberState();
}

class _ForgetPassAndRememberState extends State<ForgetPassAndRemember> {
  bool remember = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: remember,
          activeColor: Colors.grey,
          onChanged: (value) {
            setState(() {
              remember = value;
            });
          },
        ),
        Text("Remember me"),
        Spacer(),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Forgot Password",
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}
