import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toys_home/pages/welcome_page.dart';
import 'list_page.dart';
import 'package:toys_home/components/rounded_button.dart';
import 'package:toys_home/const_file.dart';

class LoginPage extends StatefulWidget {
  static String id = 'log_in_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email;
  String password;
  bool showSpinner = false;

  String message = 'Please enter your email and password';

  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      home: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
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
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
                    child: Center(
                      child: Text(
                        message,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value;
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
                      obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password = value;
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
                          colour: Colors.green[200],
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        RoundedButton(
                          colour: Colors.greenAccent,
                          title: 'Log in',
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final user = await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                              //wrong password or user
                              if(user != null){
                                Navigator.pushNamed(context, ListPage.id);
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            }
                            catch(e){
                              print('error in login on loginpage');
                              setState(() {
                                showSpinner = false;
                                message = 'Email or password is wrong';
                              });
                            }
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
      ),
    );
  }
}
