import 'package:flutter/material.dart';
import 'package:toys_home/components/rounded_button.dart';
import 'package:toys_home/const_file.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register Page',
      home: Scaffold(
        backgroundColor: Colors.amber[400],
        body: Center(
          child: SafeArea(
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                SizedBox(
                  height: 100.0,
                ),
                Center(
                  child: Hero(
                    tag: 'logo',
                    child: CircleAvatar(
                      radius: 150.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('images/teddy-bear.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
                  child: TextField(
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    decoration: text_field_dec.copyWith(
                      hintText: 'Enter your email',
                      fillColor: Colors.amber[100],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
                  child: TextField(
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    decoration: text_field_dec.copyWith(
                      hintText: 'Enter your password',
                      fillColor: Colors.amber[100],
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RoundedButton_Icon(
                        colour: Colors.blue[200],
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      RoundedButton(
                        colour: Colors.lightBlueAccent,
                        title: 'Register',
                        onPressed: () {
                          //
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
