import 'package:flutter/material.dart';
import 'package:toys_home/pages/list_page.dart';
import 'package:toys_home/pages/user_profile.dart';
import 'package:toys_home/pages/post_page.dart';


class Cus_BottomAppBar extends StatelessWidget {

  Cus_BottomAppBar({this.colour, this.first_icon_color, this.third_icon_color, this.first_Onpressed, this.third_Onpressed});

  final Color colour;
  final Color first_icon_color;
  final Color third_icon_color;
  final Function first_Onpressed;
  final Function third_Onpressed;


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: colour,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
                onPressed: first_Onpressed,
                child: Icon(Icons.list, size: 40.0, color: first_icon_color)),
            FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return PostPage();
                      }));
                },
                child: Icon(Icons.add_circle_outline,
                    size: 40.0, color: Colors.black12)),
            FlatButton(
                onPressed: third_Onpressed,
                child: Icon(Icons.account_circle,
                    size: 40.0, color: third_icon_color)),
          ],
        ),
      ),
    );
  }
}
