import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.colour, this.title, @required this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      );
  }
}


class RoundedButton_Icon extends StatelessWidget {
  RoundedButton_Icon({this.colour, @required this.onPressed});

  final Color colour;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: colour,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 42.0,
        height: 42.0,
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
