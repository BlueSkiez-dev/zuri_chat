import 'package:flutter/material.dart';
import 'package:zuri_chat/constants.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {this.title, this.colour, @required this.onPressed, this.color2});

  final Color colour;
  final Color color2;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40),
      child: Material(
        shadowColor: kPrimaryColor,
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 400,
          height: 42.0,
          child: Row(
            children: [
              Image.asset('assets/images/search.png', height: 30, width: 30),
              SizedBox(width: 18),
              Text(
                title,
                style: TextStyle(
                  color: color2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
