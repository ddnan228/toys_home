import 'package:flutter/material.dart';
import 'list_page.dart';

//main() => runApp(PostDetail());

class PostDetail extends StatelessWidget {

  PostDetail({this.user,this.price,this.title, this.contact, this.description, this.imageUrl});

  final String user;
  final String title;
  final String price;
  final String contact;
  final String description;
  final String imageUrl;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post Detail',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[400],
          title: Text('Post Detail'),
          leading: FlatButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            child: Icon(
              Icons.backspace,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Material(
                borderRadius: BorderRadius.circular(30.0),
                elevation: 3.0,
                color: Colors.amber[200],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),

                  child: imageUrl == null?Image.asset('images/teddy-default.png') : Image.network(imageUrl),
                )),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(title, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[800],
                    fontSize: 30.0,
                  ),)),
            ),
            textBox('price: $price'),
            textBox('Contact to $contact'),
            textBox('Decription: $description'),
            textBox('Posted by $user'),

          ],
        ),
      ),
    );
  }

  Widget textBox(String t){
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Text(t,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

}
