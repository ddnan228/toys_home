import 'package:flutter/material.dart';


class PostBox extends StatelessWidget {
  PostBox({this.user, this.title, this.price, this.contact, this.onPressed, this.imageUrl});

  final String user;
  final String title;
  final String price;
  final String contact;
  final Function onPressed;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
      child: FlatButton(
        onPressed: onPressed,
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          elevation: 3.0,
          color: Colors.amber[200],
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 20.0,
              ),
              CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.transparent,
                backgroundImage: imageUrl == null ? AssetImage('images/teddy-bear_default_icon.png') : NetworkImage(imageUrl),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        '$title',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.attach_money, color: Colors.orange, size: 20.0,),
                          Text(
                            '$price',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Icon(Icons.phone, color: Colors.orange, size: 20.0,),
                          Text(
                            '$contact',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      Text('From $user'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}