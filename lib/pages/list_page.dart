import 'package:flutter/material.dart';
import 'package:toys_home/pages/user_profile.dart';
import 'post_page.dart';
import 'package:toys_home/components/bottom_appbar.dart';

class ListPage extends StatefulWidget {

  static String id = 'list_page';

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListPage',
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.toys),
          backgroundColor: Colors.amber[400],
          title: Text('Find A Toy'),
        ),
        body: Container(),
        bottomNavigationBar: Cus_BottomAppBar(
          colour: Colors.amber[400],
          first_icon_color: Colors.white,
          third_icon_color: Colors.black12,
          third_Onpressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return UserProfile();
            }));
          },
        ),
      ),
    );;
  }
}


