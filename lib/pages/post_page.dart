import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:toys_home/const_file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'list_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as img;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//void main() => runApp(PostPage());

class PostPage extends StatefulWidget {
  static String id = 'post_page';

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;

  File imageFile;
  String _uploadedImageUrl;
  String _uploadedThumbnail;

  bool uploadSpinner = false;

  String title;
  String price;
  String contact;
  String description;

  final notifications = FlutterLocalNotificationsPlugin(); // for notification

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    initializeNotification();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print('error in getCurrentUser on postpage');
    }
  }

  void initializeNotification(){
    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));
    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ListPage()),
  );



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListPage',
      home: ModalProgressHUD(
        inAsyncCall: uploadSpinner,
        child: Scaffold(
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
              child: Icon(
                Icons.backspace,
                color: Colors.white,
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
                  title = value;
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
                        price = value;
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
                        contact = value;
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
                  description = value;
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
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                  child: Text(
                    'Add Image Here',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.green[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                phone_upload_button()
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: _showPic(),
                ),
                SizedBox(
                  width: 20.0,
                ),
              ],
            ),
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (title != null &&
                  title != '' &&
                  price != null &&
                  price != '' &&
                  contact != null &&
                  contact != '') {

                uploadSpinner = true;

                // upload image
                if(imageFile != null){
                  await uploadImage(imageFile);
                }

                //post a new one, upload to database
                await _firestore.collection('doudouPosts').add({
                  'userEmail': loggedInUser.email,
                  'postTitle': title,
                  'postPrice': price,
                  'postContact': contact,
                  'postDescription': description,
                  'postTime': DateTime.now(),
                  'postImageUrl': _uploadedImageUrl,
                  //'postThumbnail': _uploadedThumbnail,
                });
                uploadSpinner = false;
                notifications.show(0, 'New Post', title, _ongoing);
                Navigator.pop(context);
              }
            },
            child: Icon(Icons.check_circle),
            backgroundColor: Colors.greenAccent,
          ),
        ),
      ),
    );
  }

  Widget _showPic() {
    if (imageFile == null) {
      return Text(
        'No image selected',
      );
    } else {
      return Image.file(
        imageFile,
        width: 300.0,
      );
    }
  }

  Widget phone_upload_button() {
    return FlatButton(
      child: Padding(
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
      ),
      onPressed: () {
        _showChoiceDialog(context);
      },
    );
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //title: Text('From'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(
                    child: GestureDetector(
                      child: Text('Gallary'),
                      onTap: () {
                        _openGallary(context);
                      },
                    ),
                  ),
                  Divider(
                    color: Colors.green,
                  ),
                  Center(
                    child: GestureDetector(
                      child: Text('Camera'),
                      onTap: () {
                        _openCamera(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _openGallary(BuildContext context) async {
    var pic = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = pic;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var pic = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = pic;
    });
    Navigator.of(context).pop();
  }
  
  Future<void> uploadImage(file) async {
    try {


      var uuid = Uuid().v1();
      StorageReference _storageRef = FirebaseStorage.instance
          .ref().child('DoudouAppImages').child('postImages').child(
          'pose_$uuid.jpg');
      StorageUploadTask uploadTask = _storageRef.putFile(file);
      _uploadedImageUrl =
      await(await uploadTask.onComplete).ref.getDownloadURL();

      print(_uploadedImageUrl);

//      File _thumbnailFile = await FlutterNativeImage.compressImage(file, targetWidth: 120);
//      print(1);
//
////      img.Image currImage = img.decodeImage(file.readAsBytesSync());
////      print(1);
////      img.Image _thumbnail = img.copyResize(currImage, width: 120);
////      print(2);
////      File thumFile;
////      print(3);
////      //await thumFile.writeAsBytesSync(img.encodePng(_thumbnail));
////      print(4);
//
//      StorageReference _storageRef2 = FirebaseStorage.instance
//          .ref().child('DoudouAppImages').child('postImages').child(
//          'pose_thumbnail_$uuid.png');
//      StorageUploadTask uploadTask2 = _storageRef.putFile(_thumbnailFile);
//      _uploadedThumbnail = await(await uploadTask2.onComplete).ref.getDownloadURL();
//
//      print(_uploadedThumbnail);
    }
    catch(e){
      print('error in uploading image to storage.');
    }
  }


  NotificationDetails get _ongoing{
    final androidChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.Max,
      priority: Priority.High,
      ongoing: true,
      autoCancel: false,
    );
    final iOSChannelSpecifics = IOSNotificationDetails();
    return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
  }
  
}
