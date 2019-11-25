import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toys_home/pages/list_page.dart';
import 'package:flutter/material.dart';

//main() => runApp(LocalNotification());

class LocalNotification extends StatefulWidget {
  @override
  _LocalNotificationState createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {

  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
      title: 'test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('test notification'),

        ),
        body: Center(
          child: FlatButton(
            color: Colors.lightBlueAccent,
            child: Text('test'),
            onPressed: (){
              notifications.show(0, 'title', 'body', _ongoing);

            },

          ),
        ),
      ),
    );
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
