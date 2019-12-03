import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toys_home/components/labels_row.dart';

class PostDetail extends StatelessWidget {
  PostDetail(
      {this.user,
      this.price,
      this.title,
      this.contact,
      this.description,
      this.imageUrl,
      this.labels});

  final String user;
  final String title;
  final String price;
  final String contact;
  final String description;
  final String imageUrl;
  final List<dynamic> labels;

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
                child: imageUrl == null
                    ? Image.asset('images/teddy-default.png')
                    : Image.network(imageUrl),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                      fontSize: 30.0,
                      fontFamily: 'Acme',
                    ),
                  )),
            ),
            SizedBox(
              height: 10.0,
            ),
            get_all_label_row(),
            Divider(color: Colors.orangeAccent),
            textBox('Price\$ $price'),
            Divider(color: Colors.orangeAccent),
            textBox('Contact to $contact'),
            Divider(color: Colors.orangeAccent),
            textBox('$description'),
            Divider(color: Colors.orangeAccent),
            fromBox('Posted by $user'),
          ],
        ),
      ),
    );
  }

  Widget get_all_label_row() {
    if (labels == null) {
      return Container();
    }
    List<Widget> lists = [];
    var num = labels.length;
    var i = 0;
    for (; i < num - 4; i = i + 4) {
      lists.add(LablesRow(
        labels: labels.sublist(i, i + 4),
        len: 4,
        align: MainAxisAlignment.center,
        colour: Colors.orange,
        fontsize: 15.0,
      ));
    }
    lists.add(LablesRow(
      labels: labels.sublist(i, num),
      len: num - i,
      align: MainAxisAlignment.center,
      colour: Colors.orange,
      fontsize: 15.0,
    ));
    return Column(
      children: lists,
    );
  }

  Widget label_boxes() {
    if (labels == null) {
      return Center(child: Text('No labels'));
    }
    List<Widget> boxes = [];
    var num = labels.length;
    if (num > 4) {
      num = 4;
    }
    for (var i = 0; i < num; i++) {
      boxes.add(Container(
        padding: EdgeInsets.all(3.0),
        child: FlatButton(
          color: Colors.black12,
          child: Text(labels[i].toString()),
          onPressed: () {},
        ),
      ));
    }
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: boxes,
      ),
    );
  }

  Widget textBox(String t) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Text(
          t,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget fromBox(String t) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Text(
          t,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
