import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toys_home/components/labels_row.dart';

class PostBox extends StatelessWidget {
  PostBox(
      {this.user,
      this.title,
      this.price,
      this.contact,
      this.onPressed,
      this.imageUrl,
      this.colour,
      this.labels});

  final String user;
  final String title;
  final String price;
  final String contact;
  final Function onPressed;
  final String imageUrl;
  final Color colour;
  final List<dynamic> labels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
      child: FlatButton(
        onPressed: onPressed,
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          elevation: 3.0,
          color: colour,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10.0,
              ),
              CircleAvatar(
                radius: 35.0,
                backgroundColor: Colors.transparent,
                backgroundImage: imageUrl == null
                    ? AssetImage('images/teddy-bear_default_icon.png')
                    : NetworkImage(imageUrl),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '$title',
                        style: TextStyle(
                            fontFamily: 'IndieF',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800]),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.attach_money,
                            color: Colors.orange,
                            size: 20.0,
                          ),
                          Text(
                            '$price',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Icon(
                            Icons.phone,
                            color: Colors.orange,
                            size: 20.0,
                          ),
                          Text(
                            '$contact',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      LablesRow(
                        labels: labels,
                        len: 3,
                        align: MainAxisAlignment.start,
                        colour: Colors.orange,
                        fontsize: 13.0,
                      ),
                      Text(
                        'From $user',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
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
