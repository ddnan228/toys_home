import 'package:flutter/material.dart';
import 'package:toys_home/pages/user_profile.dart';
import 'post_page.dart';
import 'package:toys_home/components/bottom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toys_home/components/post_box.dart';
import 'post_detail.dart';

class ListPage extends StatefulWidget {
  static String id = 'list_page';

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
      title: 'ListPage',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.toys),
            onPressed: () {
              //postsStream();
            },
          ),
          backgroundColor: Colors.amber[400],
          title: Text('Find A Toy'),
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
                final postWidget = PostBox(
                  user: loggedInUser.email,
                  title: post.data['postTitle'],
                  price: post.data['postPrice'],
                  contact: post.data['postContact'],
                  imageUrl: post.data['postImageUrl'],
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return PostDetail(
                        title: post.data['postTitle'],
                        user: loggedInUser.email,
                        price: post.data['postPrice'],
                        contact: post.data['postContact'],
                        description: post.data['postDescription'],
                        imageUrl: post.data['postImageUrl'],
                      );
                    }));
                  },
                );
                postWidgets.add(postWidget);
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
        bottomNavigationBar: Cus_BottomAppBar(
          colour: Colors.amber[400],
          first_icon_color: Colors.white,
          third_icon_color: Colors.black12,
          third_Onpressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return UserProfile(email: loggedInUser.email,);
            }));
          },
        ),
      ),
    );

  }
}
