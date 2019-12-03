import 'package:flutter/material.dart';
import 'package:toys_home/pages/user_profile.dart';
import 'post_page.dart';
import 'package:toys_home/components/bottom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toys_home/components/post_box.dart';
import 'post_detail.dart';


class MyPostsPage extends StatefulWidget {
  static String id = 'my_posts';

  @override
  _MyPostsPageState createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPostsPage> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

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
        //print(loggedInUser.email);
      }
    } catch (e) {
      print('error in getCurrentUser on listpage');
    }
  }

//  void getPostsData() async {
//    final posts = await _firestore.collection('doudouPosts').getDocuments();
//    for (var post in posts.documents) {
//      print(post.data);
//    }
//  }

  void postsStream() async {
    await for (var snapshot
        in _firestore.collection('doudouPosts').snapshots()) {
      for (var post in snapshot.documents) {
        print(post.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Posts',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lime,
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
          title: Text('My Posts'),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('doudouPosts').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final posts = snapshot.data.documents;
              List<PostBox> postWidgets = [];
              for (var post in posts) {
                if(post.data['userEmail'] == loggedInUser.email) {
                  final postWidget = PostBox(
                    user: post.data['userEmail'],
                    title: post.data['postTitle'],
                    price: post.data['postPrice'],
                    contact: post.data['postContact'],
                    imageUrl: post.data['postThumbnail'],
                    colour: Colors.lime[200],
                    labels: post.data['postLabels'],
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return PostDetail(
                              title: post.data['postTitle'],
                              user: post.data['userEmail'],
                              price: post.data['postPrice'],
                              contact: post.data['postContact'],
                              description: post.data['postDescription'],
                              imageUrl: post.data['postImageUrl'],
                              labels: post.data['postLabels'],
                            );
                          }));
                    },
                  );
                  postWidgets.add(postWidget);
                }
              }
              return Align(
                alignment: Alignment.topCenter,
                child: ListView(
                  shrinkWrap: true,
                  reverse: true,
                  children: postWidgets,
                ),
              );
            }),
      ),
    );
  }
}
