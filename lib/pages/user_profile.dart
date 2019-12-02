import 'package:flutter/material.dart';
import 'package:toys_home/pages/my_posts.dart';
import 'package:toys_home/pages/welcome_page.dart';
import 'post_page.dart';
import 'list_page.dart';
import 'package:toys_home/components/bottom_appbar.dart';
import 'package:toys_home/const_file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toys_home/components/rounded_button.dart';

class UserProfile extends StatefulWidget {
  UserProfile({this.email});

  static String id = 'user_profile';
  final String email;

  @override
  _UserProfileState createState() => _UserProfileState(email: email);
}

class _UserProfileState extends State<UserProfile> {
  _UserProfileState({this.email});

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  final String email;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print('error in getCurrentUser on listpage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListPage',
      home: Scaffold(
        backgroundColor: Colors.lime[100],
        appBar: AppBar(
          leading: Icon(Icons.person_outline),
          backgroundColor: Colors.lime,
          title: Text('My Profile'),
        ),
        bottomNavigationBar: Cus_BottomAppBar(
          colour: Colors.lime,
          first_icon_color: Colors.black12,
          third_icon_color: Colors.white,
          first_Onpressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ListPage();
            }));
          },
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 150.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 20.0,
                  ),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('images/girl.png'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'User Email: $email',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RoundedButton(
                colour: Colors.lime,
                title: 'My Posts',
                onPressed: (){
                  Navigator.pushNamed(context, MyPostsPage.id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RoundedButton(
                colour: Colors.red[200],
                title: 'Log Out',
                onPressed: (){
                  _auth.signOut();
                  Navigator.pushNamed(context, WelcomePage.id);

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
