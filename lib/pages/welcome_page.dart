import 'package:flutter/material.dart';
import 'package:toys_home/pages/register_page.dart';
import 'log_in_page.dart';
import 'package:toys_home/components/rounded_button.dart';

class WelcomePage extends StatefulWidget {
  static String id = 'welcome_page';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Page',
      home: Scaffold(
        backgroundColor: Colors.amber[400],
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: CircleAvatar(
                    radius: 75.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('images/teddy-bear.png'),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Find A Toy',
                  style: TextStyle(
                    fontFamily: 'IndieFlower',
                    fontSize: 40.0,
                    color: Colors.orange[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: RoundedButton(
                    colour: Colors.greenAccent,
                    title: 'Log in',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return LoginPage();
                          }));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: RoundedButton(
                    colour: Colors.lightBlueAccent,
                    title: 'Register',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return RegisterPage();
                          }));
                    },
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
