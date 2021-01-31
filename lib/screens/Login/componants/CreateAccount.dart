import 'package:flutter/material.dart';
//to show design create account
class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: (16)),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            "create account",
            style: TextStyle(
                fontSize: (16),
                color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
