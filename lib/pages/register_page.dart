import 'package:flutter/material.dart';
import 'package:toys_home/components/rounded_button.dart';
import 'package:toys_home/const_file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'list_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _anth = FirebaseAuth.instance;

  String email;
  String password;
  bool showSpinner = false;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register Page',
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
                    height: 75.0,
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
                          colour: Colors.blue[200],
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        RoundedButton(
                          colour: Colors.lightBlueAccent,
                          title: 'Register',
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final newUser = await _anth
                                  .createUserWithEmailAndPassword(
                                  email: email, password: password);
                              if(newUser != null){
                                Navigator.pushNamed(context, ListPage.id);
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            }
                            catch(e){
                              print(e);
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
