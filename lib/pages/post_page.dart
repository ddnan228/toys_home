import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toys_home/const_file.dart';

//void main() => runApp(PostPage());

class PostPage extends StatefulWidget {
  static String id = 'post_page';

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListPage',
      home: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          backgroundColor: Colors.green[200],
          title: Text('Post A Toy'),
          leading: FlatButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            child: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.backspace,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: ListView(children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: text_field_dec.copyWith(
                hintText: 'Enter title',
                fillColor: Colors.green[50],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    decoration: text_field_dec.copyWith(
                      hintText: 'Enter Price',
                      fillColor: Colors.green[50],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    decoration: text_field_dec.copyWith(
                      hintText: 'Enter Contact No.',
                      fillColor: Colors.green[50],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: TextField(
              maxLines: 7,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: text_field_dec.copyWith(
                hintText: 'Enter description',
                fillColor: Colors.green[50],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 0, 0, 0),
            child: Text(
              'Add Image (up to 5)',
              style: TextStyle(
                fontSize: 15,
                color: Colors.green[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //post a new one, upload to database
          },
          child: Icon(Icons.check_circle),
          backgroundColor: Colors.greenAccent,
        ),
      ),
    );
  }
}

class PhotoFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Icon(Icons.add_box),
        decoration: ShapeDecoration(
          color: Colors.black12,
          shape: Border.all(
            color: Colors.orange,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
