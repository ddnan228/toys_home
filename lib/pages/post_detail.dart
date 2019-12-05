import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toys_home/components/labels_row.dart';
import 'package:toys_home/components/post_item.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class PostDetail extends StatefulWidget {
  PostDetail({
    this.detail,
  });

  final PostItem detail;

  _PostDetailState createState() => _PostDetailState(detail: detail);
}

class _PostDetailState extends State<PostDetail> {
  _PostDetailState({this.detail});
  final PostItem detail;
  String address;

  GoogleMapController mapController;
  LatLng _center;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    if (detail.latitude != null && detail.longitude != null) {
      _getAddress();
    }
  }

  _getAddress() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          detail.latitude, detail.longitude);
      Placemark place = p[0];
      setState(() {
        address = '${place.locality}, ${place.postalCode}, ${place.country}';
        _center = LatLng(detail.latitude, detail.longitude);
      });
    } catch (e) {
      print(e);
    }
  }

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
                child: detail.imageUrl == null
                    ? Image.asset('images/teddy-default.png')
                    : Image.network(detail.imageUrl),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    detail.title,
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
            textBox('Price\$ ${detail.price}'),
            Divider(color: Colors.orangeAccent),
            textBox('Contact to ${detail.contact}'),
            SizedBox(height: 5.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.phone,
                    color: Colors.orange,
                  ),
                  onTap: (){
                    _phone_call();
                  },
                ),
                SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  child: Icon(
                    Icons.message,
                    color: Colors.orange,
                  ),
                  onTap: (){
                    _message_to();
                  },
                ),
              ],
            ),
            Divider(color: Colors.orangeAccent),
            textBox('${detail.contact}'),
            Divider(color: Colors.orangeAccent),
            textBox('Post at ${detail.time}'),
            Divider(color: Colors.orangeAccent),
            show_location(),
            Divider(color: Colors.orangeAccent),
            fromBox('Posted by ${detail.user}'),
          ],
        ),
      ),
    );
  }

  _phone_call() async{
    if(await UrlLauncher.canLaunch('tel:${detail.contact}')){
      await UrlLauncher.launch('tel:${detail.contact}');
    }else{
      throw 'can not launch';
    }
  }

  _message_to() async{
    if(await UrlLauncher.canLaunch('sms:${detail.contact}')){
      await UrlLauncher.launch('sms:${detail.contact}');
    }else{
      throw 'can not launch';
    }

  }

  Widget show_location() {
    if (address == null) {
      return textBox('User not showing Location');
    } else {
      return Column(
        children: <Widget>[
          textBox('Location: $address'),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            height: 200.0,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 12.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('1'),
                  position: _center,
                  infoWindow: InfoWindow(
                    title: 'I am Here',
                  ),
                )
              },
            ),
          ),
        ],
      );
    }
  }

  Widget get_all_label_row() {
    if (detail.labels == null) {
      return Container();
    }
    List<Widget> lists = [];
    var num = detail.labels.length;
    var i = 0;
    for (; i < num - 4; i = i + 4) {
      lists.add(LablesRow(
        labels: detail.labels.sublist(i, i + 4),
        len: 4,
        align: MainAxisAlignment.center,
        colour: Colors.orange,
        fontsize: 15.0,
      ));
    }
    lists.add(LablesRow(
      labels: detail.labels.sublist(i, num),
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
    if (detail.labels == null) {
      return Center(child: Text('No labels'));
    }
    List<Widget> boxes = [];
    var num = detail.labels.length;
    if (num > 4) {
      num = 4;
    }
    for (var i = 0; i < num; i++) {
      boxes.add(Container(
        padding: EdgeInsets.all(3.0),
        child: FlatButton(
          color: Colors.black12,
          child: Text(detail.labels[i].toString()),
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
