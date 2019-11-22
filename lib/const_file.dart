import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



//<div>Icons made by Freepik from www.flaticon.com

const text_field_dec = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter your password.',
  contentPadding: EdgeInsets.symmetric(
      vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.amber, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
        color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const text_style_user_post = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.lime,
  fontSize: 20.0,
);