import 'package:flutter/material.dart';
import 'pages/list_page.dart';
import 'pages/post_page.dart';
import 'pages/log_in_page.dart';
import 'pages/welcome_page.dart';
import 'pages/user_profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toys_Home',
      initialRoute: WelcomePage.id,
      routes: {
        WelcomePage.id: (context) => WelcomePage(),
        ListPage.id: (context) => ListPage(),
        PostPage.id: (context) => PostPage(),
        UserProfile.id: (context) => UserProfile(),
        LoginPage.id: (context) => LoginPage(),

      },
    );
  }
}
